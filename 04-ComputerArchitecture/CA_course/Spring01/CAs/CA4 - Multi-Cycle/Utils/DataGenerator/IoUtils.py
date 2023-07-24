def write_to_file(data: str, filename: str, comment: str = "") -> None:
    with open(filename, "a", encoding="utf-8") as file:
        if comment:
            file.write(f"// {comment}\n\n")
        file.write(data + "\n\n")


def read_from_file(filename: str) -> list[str]:
    with open(filename, "r", encoding="utf-8") as file:
        return file.read().splitlines()


def read_from_stdin() -> list[str]:
    numbers = []
    while True:
        try:
            inp = input()
            if not inp:
                continue
            numbers.append(inp)
        except EOFError:
            break
    return numbers
