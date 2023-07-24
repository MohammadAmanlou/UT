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
    using MachineInst = std::uint32_t;

private:
    // clang-format off
    struct Opcode {
        enum type {
            add    = 0b000000,
            sub    = 0b000000,
            slt    = 0b000000,
            bitAnd = 0b000000,
            bitOr  = 0b000000,
            addi   = 0b001000,
            slti   = 0b001010,
            lw     = 0b100011,
            sw     = 0b101011,
            j      = 0b000010,
            jal    = 0b000011,
            jr     = 0b111111,
            beq    = 0b000100,
        };
    };

    struct RFunc {
        enum type {
            add    = 0b100000,
            sub    = 0b100010,
            slt    = 0b101010,
            bitAnd = 0b100100,
            bitOr  = 0b100101,
        };
    };

    inline static const std::unordered_map<std::string, Opcode::type> opcMap {
        {"add",  Opcode::add},
        {"sub",  Opcode::sub},
        {"slt",  Opcode::slt},
        {"and",  Opcode::bitAnd},
        {"or",   Opcode::bitOr},
        {"addi", Opcode::addi},
        {"slti", Opcode::slti},
        {"lw",   Opcode::lw},
        {"sw",   Opcode::sw},
        {"j",    Opcode::j},
        {"jal",  Opcode::jal},
        {"jr",   Opcode::jr},
        {"beq",  Opcode::beq},
    };

    inline static const std::unordered_map<std::string, RFunc::type> rfuncMap {
        {"add", RFunc::add},
        {"sub", RFunc::sub},
        {"slt", RFunc::slt},
        {"and", RFunc::bitAnd},
        {"or",  RFunc::bitOr},
    };
    // clang-format on

    struct Operand {
        enum class Type {
            opc,
            reg,
            imm,
            label,
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

        if (inst.size() > 4) {
            throw std::invalid_argument("Extra operands for instruction: "s + inst[0]);
        }

        std::array<Operand, 5> operands = extractOperands(inst, labelMap);
        checkOperandBoundaries(operands);

        MachineInst mInst {};
        switch (opc->second) {
        case Opcode::add:
            operands[4].value = rfuncMap.find(inst[0])->second;
            operands[4].type = Operand::Type::func;
            mInst = rtype(operands);
            break;
        case Opcode::beq:
            if (operands[3].type == Operand::Type::label) {
                operands[3].value -= instCount + 1;
                operands[3].type = Operand::Type::imm;
            }
        case Opcode::addi:
        case Opcode::slti:
            mInst = itype(operands);
            break;
        case Opcode::lw:
        case Opcode::sw:
            mInst = mtype(operands);
            break;
        case Opcode::j:
        case Opcode::jal:
            mInst = jtype(operands);
            break;
        case Opcode::jr:
            mInst = jrtype(operands);
            break;
        default:
            throw std::invalid_argument("Invalid opcode: "s + std::to_string(opc->second));
        }

        return mInst;
    }

private:
    static std::array<Operand, 5> extractOperands(const std::vector<std::string>& inst,
                                                  const std::unordered_map<std::string, int>& labelMap) {
        using namespace std::string_literals;

        std::array<Operand, 5> operands {};

        operands[0].value = opcMap.find(inst[0])->second;
        operands[0].type = Operand::Type::opc;

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
                operands[i].type = Operand::Type::imm;
                std::from_chars(begin + pos + 2, end - 1, operands[i + 1].value);
                operands[i + 1].type = Operand::Type::reg;
            }
            else if (std::isdigit(inst[i][0]) || inst[i][0] == '-') { // 24
                std::from_chars(begin, end, operands[i].value);
                operands[i].type = Operand::Type::imm;
            }
            else {
            label:
                auto itr = labelMap.find(inst[i]);
                if (itr == labelMap.end()) {
                    throw std::invalid_argument("Invalid label: "s + inst[i]);
                }
                operands[i].value = itr->second;
                operands[i].type = Operand::Type::label;
            }
        }

        return operands;
    }

    static void checkOperandBoundaries(const std::array<Operand, 5> inst) {
        for (Operand x : inst) {
            switch (x.type) {
            case Operand::Type::opc:
                if (x.value > 0b111111) {
                    throw std::out_of_range("Opcode value exceeds 6 bits.");
                }
                break;
            case Operand::Type::reg:
                if (x.value > 0b11111) {
                    throw std::out_of_range("Register number exceeds 31.");
                }
                break;
            case Operand::Type::imm:
                if (x.value > 0xFFFF) {
                    throw std::out_of_range("Immediate value exceeds 16 bits.");
                }
                break;
            case Operand::Type::label:
                if (x.value > 0x3FFFFFF) {
                    throw std::out_of_range("Label address exceeds 26 bits.");
                }
                break;
            case Operand::Type::func:
                if (x.value > 0b111111) {
                    throw std::out_of_range("Function value exceeds 6 bits.");
                }
                break;
            }
        }
    }

    static MachineInst rtype(const std::array<Operand, 5> inst) {
        // add sub slt and or
        // opc[6] sr1[5] sr2[5] dr[5] sh[5] func[6]
        MachineInst result = inst[0].value << 26; // opc
        result += inst[1].value << 11;            // dr
        result += inst[2].value << 21;            // sr1
        result += inst[3].value << 16;            // sr2
        result += inst[4].value;                  // func

        if (inst[1].type != Operand::Type::reg ||
            inst[2].type != Operand::Type::reg ||
            inst[3].type != Operand::Type::reg ||
            inst[4].type != Operand::Type::func) {
            throw std::invalid_argument("Wrong operand types for R-type instruction.");
        }

        return result;
    }

    static MachineInst mtype(const std::array<Operand, 5> inst) {
        // lw sw
        // opc[6] sr1[5] sr2[5] imm[16]
        MachineInst result = inst[0].value << 26; // opc
        result += inst[1].value << 16;            // sr2
        result += inst[2].value & 0xFFFF;         // imm
        result += inst[3].value << 21;            // sr1

        if (inst[1].type != Operand::Type::reg ||
            inst[2].type != Operand::Type::imm ||
            inst[3].type != Operand::Type::reg) {
            throw std::invalid_argument("Wrong operand types for I-type (memory) instruction.");
        }

        return result;
    }

    static MachineInst itype(const std::array<Operand, 5> inst) {
        // addi slti (beq)
        // opc[6] sr1[5] dr[5] imm[16]
        MachineInst result = inst[0].value << 26; // opc
        result += inst[1].value << 16;            // dr
        result += inst[2].value << 21;            // sr1
        result += inst[3].value & 0xFFFF;         // imm

        if (inst[1].type != Operand::Type::reg ||
            inst[2].type != Operand::Type::reg ||
            inst[3].type != Operand::Type::imm) {
            throw std::invalid_argument("Wrong operand types for I-type (arithmetic/branch) instruction.");
        }

        return result;
    }

    static MachineInst jtype(const std::array<Operand, 5> inst) {
        // j jal
        // opc[6] adr[26]
        MachineInst result = inst[0].value << 26; // opc
        result += inst[1].value;                  // adr

        if (inst[1].type != Operand::Type::label) {
            throw std::invalid_argument("Wrong operand type for J-type instruction.");
        }

        return result;
    }

    static MachineInst jrtype(const std::array<Operand, 5> inst) {
        // jr
        // opc[6] sr1[5] --[21]
        MachineInst result = inst[0].value << 26; // opc
        result += inst[1].value << 21;            // sr1

        if (inst[1].type != Operand::Type::reg) {
            throw std::invalid_argument("Wrong operand type for jr instruction.");
        }

        return result;
    }
};

#endif // ASSEMBLER_HPP_INCLUDE
