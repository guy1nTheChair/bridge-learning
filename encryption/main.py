## using cryptography module

## symmetric key - one key used to encrypt and decrypt information
## Fernet uses AES underneath with 128 bit key for encryption

from cryptography.fernet import Fernet

original_message = "This is a very secure message"
print(f"OriginalMessage is {original_message}")
key = Fernet.generate_key()
print(f"Key is {key.decode('utf-8')}")
fer_obj = Fernet(key)
cipher = fer_obj.encrypt(original_message.encode("utf-8"))
print(f"CipherText is: {cipher.decode('utf-8')}")
plain_text = fer_obj.decrypt(cipher)
print(f"PlainText is: {plain_text.decode('utf-8')}")
