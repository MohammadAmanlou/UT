ARRAY_START_ADR = 300
MAX_VALUE_ADR = 400
MAX_INDEX_ADR = 404

template = """
load {adr}         # R0 = M[{adr}]
mvto R4          # R4 = M[{adr}] (temp)
sub R1           # R0 = temp - max
and R6           # R0 & 0x8000 (keep MSB)
branch R7, gt{i}  # R0 == 0
jump end{i}

gt{i}:
    mvfrom R4    # R0 = temp
    mvto R1      # max = temp
    andi 0       # R0 = 0
    addi {i}      # R0 = 1
    mvto R2      # R2 = 1 (maxIdx)

end{i}:

"""

result = """andi 0           # R0 = 0
mvto R7          # R7 = 0 (const)
addi 1024        # R0 = 1024
add R0           # R0 = 2048
add R0           # R0 = 4096
add R0           # R0 = 8192
add R0           # R0 = 16384
add R0           # R0 = 32768
mvto R6          # R6 = 0x8000 (const)

load {startAdr}         # R0 = M[{startAdr}]
mvto R1          # R1 = M[{startAdr}] (max)
andi 0           # R0 = 0
mvto R2          # R2 = 0 (maxIdx)

""".format(startAdr=ARRAY_START_ADR)

for i in range(1, 20):
    result += template.format(
        adr=(i + ARRAY_START_ADR),
        i=f"{i:02}"
    )

result += """
mvfrom R1        # R0 = max
store {maxValAdr}        # M[{maxValAdr}] = max
mvfrom R2        # R0 = maxIdx
store {maxIdxAdr}        # M[{maxIdxAdr}] = maxIdx
""".format(maxValAdr=MAX_VALUE_ADR, maxIdxAdr=MAX_INDEX_ADR)

with open("FindMax.asm", "w", encoding="utf-8") as file:
    file.write(result)
