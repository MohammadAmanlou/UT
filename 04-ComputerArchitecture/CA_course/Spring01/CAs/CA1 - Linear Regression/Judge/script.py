def twos_complement(x):
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


with open("x_value.txt", "rb") as xFile:
    xValues = [int(x, base=2) for x in xFile.readlines()]

with open("y_value.txt", "rb") as yFile:
    yValues = [int(y, base=2) for y in yFile.readlines()]

sumX = sum(xValues)
sumY = sum(yValues)

print(f"Sum of x (28 bits): {sumX:028b}")
print(f"Sum of y (28 bits): {sumY:028b}")

avgX = sumX // len(xValues)
avgY = sumY // len(yValues)

print()
print(f"Average of x (20 bits): {avgX:020b}")
print(f"Average of y (20 bits): {avgY:020b}")
print()

SSxy = 0
SSxx = 0
B1 = 0
B0 = 0
for i, (x, y) in enumerate(zip(xValues, yValues)):
    SSxy += (x - avgX) * (y - avgY)
    SSxx += (x - avgX) ** 2
    B1 = ((SSxy << 10) // SSxx)
    B0 = avgY - ((B1 * avgX) >> 10)
    print(f"{i:03}) SSxy: {SSxy:048b} ({SSxy}) B1: {B1:020b}\n     SSxx: {SSxx:048b} ({SSxx}) B0: {B0:020b}\n")

print()
print(f"B1 (20 bits): {B1:020b}")
print(f"B0 (20 bits): {B0:020b}")

errors = []
for x, y in zip(xValues, yValues):
    errors.append(y - ((B1 * x) >> 10) - B0)

errors = [twos_complement(f"{error:020b}") for error in errors]

with open("errors.txt", "wb") as errorFile:
    for error in errors:
        errorFile.write(f"{error}\n".encode("utf-8"))
