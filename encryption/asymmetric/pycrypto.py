# using pycrypto and RSA, generate key pairs and use them to encrypt and decrypt the data

from Crypto.PublicKey import RSA

private_file_name = "rsa_private.pem"
public_file_name = "rsa_public.pem"


def generate_key_pairs():
    key = RSA.generate(4096)
    f = open(public_file_name, 'wb')
    f.write(key.publickey().exportKey('PEM'))
    f.close()
    f = open(private_file_name, 'wb')
    f.write(key.exportKey('PEM'))
    f.close()


def just_do_it(original_message):
    pub_file = open(public_file_name, 'rb')
    priv_file = open(private_file_name, 'rb')
    pub_key = RSA.importKey(pub_file.read())
    priv_key = RSA.importKey(priv_file.read())
    cipher_text = pub_key.encrypt(str.encode(original_message), 32)

    print(f"CipherText is: {cipher_text}")
    plain_text = priv_key.decrypt(cipher_text)
    print(f"PlainText is: {bytes.decode(plain_text)}")


def main():
    original_message = "Very sensitive information"
    generate_key_pairs()
    just_do_it(original_message)


if __name__ == "__main__":
    main()
