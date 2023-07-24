#ifndef ASSEMBLER_HPP_INCLUDE
#define ASSEMBLER_HPP_INCLUDE

#include <array>
#include <charconv>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

class Asm {
public:
    using MachineInst = std::uint16_t;

private:
    // clang-format off
    struct Opcode {
        enum type {
            add    = 0b1000,
            sub    = 0b1000,
            bitAnd = 0b1000,
            bitOr  = 0b1000,
            bitNot = 0b1000,
            nop    = 0b1000,
            mvTo   = 0b1000,
            mvFrom = 0b1000,
            addi   = 0b1100,
            subi   = 0b1101,
            andi   = 0b1110,
            ori    = 0b1111,
            load   = 0b0000,
            store  = 0b0001,
            jump   = 0b0010,
            branch = 0b0100,
        };
    };

    struct RFunc {
        enum type {
            add    = 0b000000100,
            sub    = 0b000001000,
            bitAnd = 0b000010000,
            bitOr  = 0b000100000,
            bitNot = 0b001000000,
            nop    = 0b010000000,
            mvTo   = 0b000000001,
            mvFrom = 0b000000010,
        };
    };

    inline static const std::unordered_map<std::string, Opcode::type> opcMap {
        {"add",    Opcode::add},
        {"sub",    Opcode::sub},
        {"and",    Opcode::bitAnd},
        {"or",     Opcode::bitOr},
        {"not",    Opcode::bitNot},
        {"nop",    Opcode::nop},
        {"mvto",   Opcode::mvTo},
        {"mvfrom", Opcode::mvFrom},
        {"addi",   Opcode::addi},
        {"subi",   Opcode::subi},
        {"andi",   Opcode::andi},
        {"ori",    Opcode::ori},
        {"load",   Opcode::load},
        {"store",  Opcode::store},
        {"jump",   Opcode::jump},
        {"branch", Opcode::branch},
    };

    inline static const std::unordered_map<std::string, RFunc::type> rfuncMap {
        {"add",    RFunc::add},
        {"sub",    RFunc::sub},
        {"and",    RFunc::bitAnd},
        {"or",     RFunc::bitOr},
        {"not",    RFunc::bitNot},
        {"nop",    RFunc::nop},
        {"mvto",   RFunc::mvTo},
        {"mvfrom", RFunc::mvFrom},
    };
    // clang-format on

    struct Operand {
        enum class Type {
            opc,
            reg,
            imm9,
            imm12,
            func,
        };
        MachineInst value;
        Type type;
    };

public:
    static MachineInst assemble(const std::vector<std::string>& inst,
                                const std::unordered_map<std::string, int>& labelMap,
                                const std::size_t instCount) {
        using namespace std::string_literals;

        auto opc = opcMap.find(inst[0]);
        if (opc == opcMap.end()) {
            throw std::invalid_argument("Invalid instruction: "s + inst[0]);
        }

        if (inst.size() > 3) {
            throw std::invalid_argument("Extra operands for instruction: "s + inst[0]);
        }

        std::array<Operand, 3> operands = extractOperands(inst, labelMap);
        checkOperandBoundaries(operands);

        MachineInst mInst {};
        switch (opc->second) {
        case Opcode::add:
            operands[2].value = rfuncMap.find(inst[0])->second;
            operands[2].type = Operand::Type::func;
            mInst = ctype(operands);
            break;
        case Opcode::addi:
        case Opcode::subi:
        case Opcode::andi:
        case Opcode::ori:
            mInst = dtype(operands);
            break;
        case Opcode::load:
        case Opcode::store:
        case Opcode::jump:
            mInst = atype(operands);
            break;
        case Opcode::branch:
            mInst = btype(operands);
            break;
        default:
            throw std::invalid_argument("Invalid opcode: "s + std::to_string(opc->second));
        }

        return mInst;
    }

private:
    static std::array<Operand, 3> extractOperands(const std::vector<std::string>& inst,
                                                  const std::unordered_map<std::string, int>& labelMap) {
        using namespace std::string_literals;

        std::array<Operand, 3> operands {};

        operands[0].value = opcMap.find(inst[0])->second;
        operands[0].type = Operand::Type::opc;

        if (inst.size() == 1) {
            if (inst[0] == "nop") {
                operands[1].type = Operand::Type::reg; // don't-care value
            }
        }

        for (std::size_t i = 1, pos; i < inst.size(); ++i) {
            const auto begin = inst[i].data();
            const auto end = begin + inst[i].size();

            if (inst[i][0] == 'R') { // R12
                auto res = std::from_chars(begin + 1, end, operands[i].value);
                if (res.ec == std::errc::invalid_argument || res.ptr != end) goto label;
                operands[i].type = Operand::Type::reg;
            }
            else if ((pos = inst[i].find('(')) != std::string::npos) { // 4(R2)
                if (inst[i].back() != ')' || inst[i][pos + 1] != 'R') {
                    throw std::invalid_argument("Invalid operand format: "s + inst[i]);
                }
                std::from_chars(begin, begin + pos, operands[i].value);
                operands[i].type = Operand::Type::imm9;
                std::from_chars(begin + pos + 2, end - 1, operands[i + 1].value);
                operands[i + 1].type = Operand::Type::reg;
            }
            else if (std::isdigit(inst[i][0]) || inst[i][0] == '-') { // 24
                std::from_chars(begin, end, operands[i].value);
                operands[i].type = (inst.size() == 2) ? Operand::Type::imm12 : Operand::Type::imm9;
            }
            else {
            label:
                auto itr = labelMap.find(inst[i]);
                if (itr == labelMap.end()) {
                    throw std::invalid_argument("Invalid label: "s + inst[i]);
                }
                operands[i].value = itr->second;
                operands[i].type = (inst.size() == 2) ? Operand::Type::imm12 : Operand::Type::imm9;
            }
        }

        return operands;
    }

    static void checkOperandBoundaries(const std::array<Operand, 3> inst) {
        for (Operand x : inst) {
            switch (x.type) {
            case Operand::Type::opc:
                if (x.value > 0b1111) {
                    throw std::out_of_range("Opcode value exceeds 4 bits.");
                }
                break;
            case Operand::Type::reg:
                if (x.value > 0b111) {
                    throw std::out_of_range("Register number exceeds 7.");
                }
                break;
            case Operand::Type::imm9:
                if (x.value > 0x1FF) {
                    throw std::out_of_range("Label address exceeds 9 bits.");
                }
                break;
            case Operand::Type::imm12:
                if (x.value > 0xFFF) {
                    throw std::out_of_range("Immediate value / address exceeds 12 bits.");
                }
                break;
            case Operand::Type::func:
                if (x.value > 0x1FF) {
                    throw std::out_of_range("Function value exceeds 9 bits.");
                }
                break;
            }
        }
    }

    static MachineInst atype(const std::array<Operand, 3> inst) {
        // load store branch
        // opc[4] adr[12]
        MachineInst result = inst[0].value << 12; // opc
        result += inst[1].value;                  // adr

        if (inst[1].type != Operand::Type::imm12) {
            throw std::invalid_argument("Wrong operand type for A-type instruction.");
        }

        return result;
    }

    static MachineInst btype(const std::array<Operand, 3> inst) {
        // branch
        // opc[4] reg[3] adr[9]
        MachineInst result = inst[0].value << 12; // opc
        result += inst[1].value << 9;             // reg
        result += inst[2].value;                  // adr

        if (inst[1].type != Operand::Type::reg ||
            inst[2].type != Operand::Type::imm9) {
            throw std::invalid_argument("Wrong operand types for B-type instruction.");
        }

        return result;
    }

    static MachineInst ctype(const std::array<Operand, 3> inst) {
        // add sub and or not nop mvto mvfrom
        // opc[4] reg[3] func[9]
        MachineInst result = inst[0].value << 12; // opc
        result += inst[1].value << 9;             // reg
        result += inst[2].value;                  // func

        if (inst[1].type != Operand::Type::reg ||
            inst[2].type != Operand::Type::func) {
            throw std::invalid_argument("Wrong operand types for C-type instruction.");
        }

        return result;
    }

    static MachineInst dtype(const std::array<Operand, 3> inst) {
        // addi subi andi ori
        // opc[4] imm[12]
        MachineInst result = inst[0].value << 12; // opc
        result += inst[1].value;                  // imm

        if (inst[1].type != Operand::Type::imm12) {
            throw std::invalid_argument("Wrong operand type for D-type instruction.");
        }

        return result;
    }
};

#endif // ASSEMBLER_HPP_INCLUDE
