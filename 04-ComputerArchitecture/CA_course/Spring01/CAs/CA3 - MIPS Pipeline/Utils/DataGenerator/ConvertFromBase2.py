from sys import argv

import IoUtils as io


OUTPUT_FILE = "data.mem"
START_ADDRESS = 1000


def hex_address_generator(binary_numbers: tuple[str], start_address: int) -> str:
    res = ''
    for num in binary_numbers:
        res += f"@{start_address:03X}\n".lower()
        res += num[24:] + '\n'
        res += num[16:24] + '\n'
        res += num[8:16] + '\n'
        res += num[:8] + '\n'
        start_address += 4
    return res


def main() -> None:
    if len(argv) > 1:
        numbers = io.read_from_file(argv[1])
    else:
        numbers = io.read_from_stdin()

    res = hex_address_generator(tuple(numbers), START_ADDRESS)
    io.write_to_file(res, OUTPUT_FILE)


if __name__ == "__main__":
    main()
