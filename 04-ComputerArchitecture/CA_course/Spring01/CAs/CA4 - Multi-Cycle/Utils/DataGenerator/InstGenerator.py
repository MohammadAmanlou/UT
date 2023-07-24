from sys import argv

from ConvertFromBase2 import hex_address_generator
import IoUtils as io


OUTPUT_FILE = "data.mem"
START_ADDRESS = 0


def main() -> None:
    if len(argv) > 1:
        instructions = io.read_from_file(argv[1])
    else:
        instructions = io.read_from_stdin()

    res = hex_address_generator(tuple(instructions), START_ADDRESS)
    io.write_to_file(res, OUTPUT_FILE, "Instructions")


if __name__ == "__main__":
    main()
