## Encryption

Encryption refers to the process of encoding information. This process converts plaintext information into encrypted format known as Ciphertext. Ideally, only authorized parties can decipher a ciphertext back to plaintext and access the original information.

**Cryptography** is the means by which security for information and resources is enforced using various encryption methods and strategies.

**Applications:**

1. Military use for exchanging sensitive information
2. Modern day Computing
3. Security

**Key Terms:**

- `Plaintext`: The original, readable message or data without much processing.
- `Encryption`: The process of transforming information into an unintelligible format using an algorithm and key.
- `Ciphertext`: The unintelligible message obtained after the encryption process.
- `Decryption`: The process of retrieving the original plaintext from the ciphertext using the key and decryption algorithm.
- `Key`: Sequence of characters consisting of numeric, alpha-numeric and optionally special characters, used to encrypt/decrypt a message.

**Types of Encryption based on keys**

1. Symmetric: One single key is used to encrypt and decrypt the information. Key is shared between the users exchanging encrypted text beforehand. Classification of Symmetric Encryption is as follows:
    
    1. **Classical Cryptography:** Broadly classified into two categories: 
        - `substitution ciphers`, individual characters are replaced by some other characters. The Substitution cipher is a data encryption scheme in which the individual units of the plaintext are replaced with some other symbol or groups of symbols.
        - `transposition ciphers`, the order of the characters is rearranged. A transposition cipher is an encryption strategy in which the position of the individual tokens of the plaintext are shifted in accordance with a regular system.
            - The ciphertext is a permutation of the plaintext.
        
        In simple words, the order of the individual units is changed, i.e., the plaintext is rearranged.
        
        Classical Symmetric Ciphers may be:
        
        - `Monoalphabetic` - a single substitution/transposition is applied.
        - `Polyalphabetic` - multiple substitutions/ transpositions are applied.
        
        A **product cipher** may be formed by concatenating several such ciphers.
        
    2. **Modern Cryptography:** Digital data is represented as strings of binary digits (bits) and not using alpha-numeric characters or special symbols. Modern cryptosystems should be capable of processing these binary strings in order to convert them into a format that is unintelligible to intruders.
    
    Based on how these binary strings are manipulated, symmetric encryption schemes can be classified as:
    
    - `Stream Ciphers`: Data is treated as individual bits. A stream cipher can be defined symmetric key algorithm where the units of the plaintext are combined with a pseudorandom cipher digit keystream. Each plaintext unit is encrypted one at a time with the corresponding digit of the keystream, to generate a unit of the ciphertext stream.
    - `Block Ciphers`: Data is treated in blocks. Unlike stream ciphers which encrypt a plaintext bit by bit, block cipher algorithms work on blocks of plaintext data.
    
    Examples of Symmetric Encryption are:
    
    1. **Data Encryption Standard (DES):** DES was one of the most popular block cipher used in the 1990s.
        - Encrypts 64-bit data with 56-bit keys
        - From the 56-bit key, 16 subkeys are generated
        - The process is repeated through 16 rounds of processing
        
        The security depends on the algorithm used and the length of the key.
        
    2. **Triple DES:** Triple DES is implemented by applying three iterations of DES to each data block.
        - The key length is of 168 bits
        - Block size is increased to 64 bits
        - Since three iterations of DES is applied, Triple DES is a comparatively slow algorithm.
        - In 1998, a DES-encrypted message was cracked in three days.
        - In 1999, a network of 10,000 desktop computers managed to crack a DES-encrypted message in just 1 day.
    3. **Advanced Encryption Standard (AES):**
    4. **IDEA:** International Data Encryption Algorithm
        
        Block size - 64 bits and Key size - 128 bits
        
        Due to patent issues the use of IDEA has restricted adoption
        
    5. **Twofish:** Block size - 128 bits and Key sizes up to 256 bits
        
        Distinctive features: Use of precomputed key-dependent S-boxes, A relatively complex key schedule
        
    6. **Serpent:** Block size - 128 bits and Key size - 128, 192, or 256 bits
        
        It is comparatively slower but has a more secure design than other block ciphers
        
    
2. **Asymmetric/Public Key Cryptography:** A pair of keys, one public key and the other private are used to decrypt and encrypt the information
    - **Diffie-Hellman:** The Diffie-Hellman algorithm is a key exchange algorithm.
        
        Initially, the secure communication of encrypted data between two entities demanded the secure exchange of the keys using a secure physical channel.
        
        The Diffie-Hellman key exchange facilitates two entities that have no prior knowledge of each other to exchange secret keys over insecure channels.
        
        The keys exchanged can then be used to encrypt messages using an encryption algorithm
        
    - **RSA** (Rivest–Shamir–Adleman): The RSA algorithm was developed in the year 1977 and named after its inventors Ron Rivest, Adi Shamir, and Len Adleman.
        
        RSA is rooted in the fact that factorizing large integers is a complex task.
        
        The public key comprises two numbers in which one is the product of two large prime numbers.
        
        The private key is generated from the two large prime numbers. Hence the secrecy is highly dependent on the inability to factorize the large numbers.
        
        Thus, the strength of the algorithm can be improved significantly by increasing the key size.
        
        As of now, key sizes of 1024, 2048 or 4096 bits are used, breaking which seems to be an impossible task.
        
    - **ECC (Elliptic-Curve Cryptography):** Elliptic-curve cryptography (ECC) is a public key cryptographic strategy that exploits the algebraic structure of elliptic curves over finite fields.
        
        One of the significant advantages of ECC is that the size of the keys used can be much smaller than the keys used in other algorithms.
        
        Elliptic curves find application in various areas of digital security such as
        
        - Key agreement
        - Digital Signatures
        - Pseudo-random generators
        - Integer factorization algorithms