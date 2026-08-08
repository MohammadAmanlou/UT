from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad


def to_hex(data):
    return data.hex().upper()


key = b"NetworkSecKey128"
from Crypto.Random import get_random_bytes

iv = get_random_bytes(16)
plaintext = b"This is a sample plaintext for AES ECB and CBC modes."
block_size = AES.block_size


ecb_encrypt_cipher = AES.new(key, AES.MODE_ECB)
ciphertext_ecb = ecb_encrypt_cipher.encrypt(pad(plaintext, block_size))

ecb_decrypt_cipher = AES.new(key, AES.MODE_ECB)
decrypted_plaintext_ecb = unpad(
    ecb_decrypt_cipher.decrypt(ciphertext_ecb),
    block_size
)


cbc_encrypt_cipher = AES.new(key, AES.MODE_CBC, iv)
ciphertext_cbc = cbc_encrypt_cipher.encrypt(pad(plaintext, block_size))

cbc_decrypt_cipher = AES.new(key, AES.MODE_CBC, iv)
decrypted_plaintext_cbc = unpad(
    cbc_decrypt_cipher.decrypt(ciphertext_cbc),
    block_size
)


print("Original Plaintext:")
print(plaintext.decode())

print("\nCiphertext in ECB mode:")
print(to_hex(ciphertext_ecb))

print("\nDecrypted Plaintext in ECB mode:")
print(decrypted_plaintext_ecb.decode())

print("\nInitialization Vector (IV) in CBC mode:")
print(to_hex(iv))

print("\nCiphertext in CBC mode:")
print(to_hex(ciphertext_cbc))

print("\nDecrypted Plaintext in CBC mode:")
print(decrypted_plaintext_cbc.decode())

print("\nECB decryption is correct:")
print(decrypted_plaintext_ecb == plaintext)

print("\nCBC decryption is correct:")
print(decrypted_plaintext_cbc == plaintext)