from sys import argv

import IoUtils as io


OUTPUT_FILE = "instructions_divided.mem"


def divide_instructions(instructions: tuple[str]) -> str:
    res = ''
    for inst in instructions:
        res += inst[24:] + '\n'
        res += inst[16:24] + '\n'
        res += inst[8:16] + '\n'
        res += inst[:8] + '\n'
    return res


def main() -> None:
    if len(argv) > 1:
        instructions = io.read_from_file(argv[1])
    else:
        instructions = io.read_from_stdin()

    res = divide_instructions(tuple(instructions))
    io.write_to_file(res, OUTPUT_FILE)


if __name__ == "__main__":
    main()
