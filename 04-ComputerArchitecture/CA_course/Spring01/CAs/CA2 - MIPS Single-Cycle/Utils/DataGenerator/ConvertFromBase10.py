from sys import argv

import IoUtils as io
from ConvertFromBase2 import hex_address_generator


OUTPUT_FILE = "data.mem"
START_ADDRESS = 1000


def twos_complement(x: str):
    if x[0] != '-':
        return x
    index = x.rindex('1')
    x = list(x)
    x[0] = '0'
    for i in range(index):
        if x[i] == '1':
            x[i] = '0'
        else:
            x[i] = '1'
    x = ''.join(x)
    return x


def main() -> None:
    if len(argv) > 1:
        numbers = io.read_from_file(argv[1])
    else:
        numbers = io.read_from_stdin()

    numbers = tuple((twos_complement(f"{int(num):032b}") for num in numbers))
    res = hex_address_generator(numbers, START_ADDRESS)
    io.write_to_file(res, OUTPUT_FILE)


if __name__ == "__main__":
    main()
