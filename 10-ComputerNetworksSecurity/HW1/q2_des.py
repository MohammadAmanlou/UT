from BitVector import BitVector
import random

IP = [
    58, 50, 42, 34, 26, 18, 10, 2,
    60, 52, 44, 36, 28, 20, 12, 4,
    62, 54, 46, 38, 30, 22, 14, 6,
    64, 56, 48, 40, 32, 24, 16, 8,
    57, 49, 41, 33, 25, 17, 9, 1,
    59, 51, 43, 35, 27, 19, 11, 3,
    61, 53, 45, 37, 29, 21, 13, 5,
    63, 55, 47, 39, 31, 23, 15, 7
]

IP_INV = [
    40, 8, 48, 16, 56, 24, 64, 32,
    39, 7, 47, 15, 55, 23, 63, 31,
    38, 6, 46, 14, 54, 22, 62, 30,
    37, 5, 45, 13, 53, 21, 61, 29,
    36, 4, 44, 12, 52, 20, 60, 28,
    35, 3, 43, 11, 51, 19, 59, 27,
    34, 2, 42, 10, 50, 18, 58, 26,
    33, 1, 41, 9, 49, 17, 57, 25
]

EXPANSION = [
    32, 1, 2, 3, 4, 5, 4, 5, 6, 7, 8, 9,
    8, 9, 10, 11, 12, 13, 12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21, 20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29, 28, 29, 30, 31, 32, 1
]

P = [
    16, 7, 20, 21,
    29, 12, 28, 17,
    1, 15, 23, 26,
    5, 18, 31, 10,
    2, 8, 24, 14,
    32, 27, 3, 9,
    19, 13, 30, 6,
    22, 11, 4, 25
]

PC1 = [
    57, 49, 41, 33, 25, 17, 9,
    1, 58, 50, 42, 34, 26, 18,
    10, 2, 59, 51, 43, 35, 27,
    19, 11, 3, 60, 52, 44, 36,
    63, 55, 47, 39, 31, 23, 15,
    7, 62, 54, 46, 38, 30, 22,
    14, 6, 61, 53, 45, 37, 29,
    21, 13, 5, 28, 20, 12, 4
]

PC2 = [
    14, 17, 11, 24, 1, 5,
    3, 28, 15, 6, 21, 10,
    23, 19, 12, 4, 26, 8,
    16, 7, 27, 20, 13, 2,
    41, 52, 31, 37, 47, 55,
    30, 40, 51, 45, 33, 48,
    44, 49, 39, 56, 34, 53,
    46, 42, 50, 36, 29, 32
]

SHIFTS = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]

STANDARD_SBOXES = [
    [
        [14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7],
        [0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8],
        [4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0],
        [15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13]
    ],
    [
        [15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10],
        [3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5],
        [0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15],
        [13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9]
    ],
    [
        [10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8],
        [13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1],
        [13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7],
        [1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12]
    ],
    [
        [7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15],
        [13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9],
        [10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4],
        [3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14]
    ],
    [
        [2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9],
        [14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6],
        [4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14],
        [11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3]
    ],
    [
        [12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11],
        [10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8],
        [9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6],
        [4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13]
    ],
    [
        [4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1],
        [13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6],
        [1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2],
        [6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12]
    ],
    [
        [13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7],
        [1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2],
        [7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8],
        [2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11]
    ]
]

def apply_table(bv, table):
    return bv.permute([x - 1 for x in table])

def text_to_bv(text):
    return BitVector(textstring=text)

def rotate_left(bv, count):
    out = bv.deep_copy()
    out << count
    return out

def bv_to_hex(bv):
    return bv.get_bitvector_in_hex()

def bit_difference(a, b):
    return a.hamming_distance(b)

def flip_one_bit(bv, index):
    changed = bv.deep_copy()
    changed[index] ^= 1
    return changed


def build_round_keys(key_text):
    key64 = text_to_bv(key_text)
    key56 = apply_table(key64, PC1)

    c, d = key56.divide_into_two()
    keys = []

    for shift in SHIFTS:
        c = rotate_left(c, shift)
        d = rotate_left(d, shift)
        merged = c + d
        keys.append(apply_table(merged, PC2))

    return keys

def sbox_substitution(bits48, sboxes):
    out32 = BitVector(size=0)

    for box_index in range(8):
        chunk = bits48[box_index * 6:(box_index + 1) * 6]

        row = int(str(chunk[0]) + str(chunk[5]), 2)
        col = int(str(chunk[1:5]), 2)

        value = sboxes[box_index][row][col]
        out32 += BitVector(intVal=value, size=4)

    return out32

def feistel(right32, round_key48, sboxes):
    expanded = apply_table(right32, EXPANSION)
    mixed = expanded ^ round_key48
    substituted = sbox_substitution(mixed, sboxes)
    return apply_table(substituted, P)

def encrypt_block(block64, round_keys, sboxes):
    state = apply_table(block64, IP)
    left, right = state.divide_into_two()

    for rk in round_keys:
        next_left = right
        next_right = left ^ feistel(right, rk, sboxes)
        left, right = next_left, next_right

    preoutput = right + left
    return apply_table(preoutput, IP_INV)


def make_random_sboxes():
    boxes = []
    for _ in range(8):
        current_box = []
        for _ in range(4):
            row = [random.randint(0, 15) for _ in range(16)]
            current_box.append(row)
        boxes.append(current_box)
    return boxes


def average_avalanche(plain_bv, round_keys, sboxes):
    reference_cipher = encrypt_block(plain_bv, round_keys, sboxes)

    changed_sum = 0
    for bit_index in range(64):
        modified_plain = flip_one_bit(plain_bv, bit_index)
        modified_cipher = encrypt_block(modified_plain, round_keys, sboxes)
        changed_sum += bit_difference(reference_cipher, modified_cipher)

    return changed_sum / 64.0

def percentage_from_bits(avg_bits):
    return (avg_bits / 64.0) * 100.0


def main():
    print("DES Avalanche Effect Test")
    print("-------------------------")

    while True:
        plaintext = input("Enter plaintext (8 chars): ")
        if len(plaintext) == 8:
            break
        print("Plaintext must be exactly 8 characters.\n")

    while True:
        key = input("Enter key (8 chars): ")
        if len(key) == 8:
            break
        print("Key must be exactly 8 characters.\n")

    plain_bv = text_to_bv(plaintext)
    round_keys = build_round_keys(key)

    standard_cipher = encrypt_block(plain_bv, round_keys, STANDARD_SBOXES)
    random_sboxes = make_random_sboxes()
    random_cipher = encrypt_block(plain_bv, round_keys, random_sboxes)

    standard_avg = average_avalanche(plain_bv, round_keys, STANDARD_SBOXES)
    random_avg = average_avalanche(plain_bv, round_keys, random_sboxes)

    print("\nStandard DES")
    print("Ciphertext (hex):", bv_to_hex(standard_cipher))
    print("Average changed bits:", "{:.2f}".format(standard_avg))
    print("Avalanche percent:", "{:.2f}%".format(percentage_from_bits(standard_avg)))

    print("\nDES with Random S-boxes")
    print("Ciphertext (hex):", bv_to_hex(random_cipher))
    print("Average changed bits:", "{:.2f}".format(random_avg))
    print("Avalanche percent:", "{:.2f}%".format(percentage_from_bits(random_avg)))

    print("\nComparison")
    if standard_avg > random_avg:
        print("Standard DES produced stronger avalanche effect in this run.")
    elif random_avg > standard_avg:
        print("Random S-box version produced stronger avalanche effect in this run.")
    else:
        print("Both versions produced the same average avalanche effect in this run.")


if __name__ == "__main__":
    main()