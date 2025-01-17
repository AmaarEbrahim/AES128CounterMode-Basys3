from Crypto.Cipher import AES
key_str = "80df70dfc69d6d8d3309dbd3501709a7"
block_str = "AEC1BEF060B67196537A44A93388F426"
print(f'key (python): {key_str}')
print(f'block (python): {block_str}')
key = bytearray.fromhex(key_str)
message = bytearray.fromhex(block_str)
cipher = AES.new(key, AES.MODE_ECB)
ciphertext = cipher.encrypt(message)
res = ''.join(format(x, '02x') for x in ciphertext)
print(f'block output (python): {res}')