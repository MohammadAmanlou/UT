#!/usr/bin/env python

### hw1_starter.py

import sys
import BitVector  # pip install BitVector

expansion_permutation = [31, 0, 1, 2, 3, 4, 3, 4, 5, 6, 7, 8, 7, 8, 9, 10, 11, 12, 11, 12, 13, 14, 15, 16, 15, 16, 17, 18, 19, 20, 19, 20, 21, 22, 23, 24, 23, 24, 25, 26, 27, 28, 27, 28, 29, 30, 31, 0]


def encrypt():
    key = get_encryption_key()
    round_key = extract_round_key( key )
    bv = BitVector( 'filename.txt' )
    while (bv.more_to_read):
        bitvec = bv.read_bits_from_file( 64 )
        if bitvec.getsize() > 0:
            [LE, RE] = bitvec.divide_into_two()
            newRE = RE.permute( expansion_permutation )
            out_xor = newRE.bv_xor( round_key )

            '''
            now comes the hard part --- the substition boxes

            Let's say after the substitution boxes and another
            permutation (P in Section 3.3.4), the output for RE is
            RE_modified.

            When you join the two halves of the bit string
            again, the rule to follow (from Fig. 4 in page 21) is
            either

            final_string = RE followed by (RE_modified xored with LE)

            or

            final_string = LE followed by (LE_modified xored with RE)

            depending upon whether you prefer to do the substitutions
            in the right half (as shown in Fig. 4) or in the left
            half.

            The important thing to note is that the swap between the
            two halves shown in Fig. 4 is essential to the working
            of the algorithm even in a single-round implementation
            of the cipher, especially if you want to use the same
            algorithm for both encryption and decryption (see Fig.
            3 page 15). The two rules shown above include this swap.
            '''
