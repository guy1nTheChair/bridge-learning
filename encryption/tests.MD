## using Cryptography 

```
# pip3 install -q cryptography
# python3 crypto.py
OriginalMessage is: This is a very secure message
Key is r0KbjW5x86lTzaWsngM1VgztcPeAIHhO_CXHq0t8Qsg=
CipherText is: gAAAAABhvuZJiT-kActGk51BFKsSxwLItQeZhBMkLFNBCSBuN8ixYJlnqmyFiZ-agm7dY8iO2xiDyfK7vPt_3BVOK5KdhG574z_EIRKPr0g7hQFuc2HWtKY=
PlainText is: This is a very secure message
```

## using pycrypto
```
vscode ➜ /workspaces/setu-learning (main ✗) $ pip3 install pycrypto -q
vscode ➜ /workspaces/setu-learning (main ✗) $ /usr/local/bin/python /workspaces/setu-learning/encryption/pycrypto.py
Password: some random text
Private Key is: b'\x14\x14\x95\x07?\xbc\x14\x19\x7fP\xe7\x1e\xc9\xc7\xa8\xe21N\xb4\xbc\x1d\xb7\xec\x1d"\x01\xc7\x86\xea\xd9`\xef'
Encrypted data is:
{'cipher_text': b'VozToqkarpFwW0aimoS6PIdg/RXoKx1mM02HcaSWOLQ=',
 'iv': b'xkR7/Lox0MLJpUOsp+MN1A==',
 'salt': b'oDuyB4AqkBg+p1JQljawVw=='}
Decrypted data is: Very sensitive content
```