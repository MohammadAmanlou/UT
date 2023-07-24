j Main

FindMax:
    addi R1, R0, 1000           # i = 1000
    lw   R2, 0(R1)              # maxElement = mem[1000]
    addi R3, R0, 0              # maxIndex = 0
    addi R4, R0, 0              # idx = 0

    Loop:
        addi R1, R1, 4          # i += 4
        addi R4, R4, 1          # idx += 1
        slti R5, R4, 20         # check if 20 elements are traversed
        beq  R5, R0, EndLoop    # if 20 elements are traversed, jump to EndLoop
        lw   R6, 0(R1)          # element = mem[i]
        slt  R5, R2, R6         # check if element is greater than maxElement
        beq  R5, R0, Loop       # if element is not greater than maxElement, jump to Loop
        add  R2, R0, R6         # maxElement = element
        add  R3, R0, R4         # maxIndex = idx
        j    Loop               # jump to Loop

    EndLoop:
        sw R2, 2000(R0)         # mem[2000] = maxElement
        sw R3, 2004(R0)         # mem[2004] = maxIndex
        jr R31                  # return


Main:
    jal FindMax                 # call FindMax
