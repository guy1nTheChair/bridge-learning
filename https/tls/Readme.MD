# Bridge-Learning: HTTPS - TLS

# TLS 
Transport Layer Security (TLS), the successor of the now-deprecated Secure Sockets Layer (SSL), is a cryptographic protocol designed to provide communications security over a computer network. The protocol is widely used in applications such as email, instant messaging, and voice over IP, but its use in securing HTTPS remains the most publicly visible.

In Layman terms,
1. When one tries to access a website via browser or makes a REST API call, with http protocol alone, the data being exchanged, is in plaintext form and any third party could easily interecpt this request and misuse the information or lead to data breach or security issues etc.,
2. To solve this problem, we have SSL/TLS that are wrappers around http. Here too, the data is being exchanged but it is encrypted. This means, if there's a third party snooping around, even if they get hold of the entire request, they wouldn't be able to read the information as it is in encrypted format.
3. In TLS, only the server's TLS Certificate is validated, and then the information is exchanged.
4. In mTLS, both the server and client's certificates are validated, and then the information is exchanged.

This makes for the current standard for exchanging information across the web securely.

## Technicals

1. The handshake begins when a client connects to a TLS-enabled server requesting a secure connection and the client presents a list of supported cipher suites (ciphers and hash functions).
2. From this list, the server picks a cipher and hash function that it also supports and notifies the client of the decision.
3. The server usually then provides identification in the form of a digital certificate. The certificate contains the server name, the trusted certificate authority (CA) that vouches for the authenticity of the certificate, and the server's public encryption key.
4. The client confirms the validity of the certificate before proceeding.
5. To generate the session keys used for the secure connection, the client either:
    1. encrypts a random number (PreMasterSecret) with the server's public key and sends the result to the server (which only the server should be able to decrypt with its private key); both parties then use the random number to generate a unique session key for subsequent encryption and decryption of data during the session
    2. uses Diffie–Hellman key exchange to securely generate a random and unique session key for encryption and decryption that has the additional property of forward secrecy: if the server's private key is disclosed in future, it cannot be used to decrypt the current session, even if the session is intercepted and recorded by a third party.

This concludes the handshake and begins the secured connection, which is encrypted and decrypted with the session key until the connection closes. If any one of the above steps fails, then the TLS handshake fails and the connection is not created.

Source: obviously Wikipedia 😇

## Steps:

 1. Created:
    1. EC2 with ```user_data``` to install docker and run a docker container with host ports 80 and 443 forwarded to port 5000 of the container
    2. ALB, Target Group, attached the EC2 instance to TG, created 2 listeners,
        1. port 80 listener forwarding to TG
        2. port 443 listener with SSL cert forwarding to TG
 2. Making request to API with http
 ```
 ➜  ~ curl -v http://dev.firstmistake.co.in
*   Trying 35.154.58.77:80...
* Connected to dev.firstmistake.co.in (35.154.58.77) port 80 (#0)
> GET / HTTP/1.1
> Host: dev.firstmistake.co.in
> User-Agent: curl/7.77.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Wed, 08 Dec 2021 04:45:50 GMT
< Content-Type: application/json
< Content-Length: 24
< Connection: keep-alive
< Server: Werkzeug/2.0.1 Python/3.8.10
< 
{
  "Hello": "World!"
}
* Connection #0 to host dev.firstmistake.co.in left intact
 ```
 <img src="assets/http.png" width="384" height="256">

 3. Making request with https
 ```
 ➜  ~ curl -v https://dev.firstmistake.co.in
*   Trying 35.154.58.77:443...
* Connected to dev.firstmistake.co.in (35.154.58.77) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*  CAfile: /etc/ssl/cert.pem
*  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=firstmistake.co.in
*  start date: Nov 20 00:00:00 2021 GMT
*  expire date: Dec 19 23:59:59 2022 GMT
*  subjectAltName: host "dev.firstmistake.co.in" matched cert's "*.firstmistake.co.in"
*  issuer: C=US; O=Amazon; OU=Server CA 1B; CN=Amazon
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x123010600)
> GET / HTTP/2
> Host: dev.firstmistake.co.in
> user-agent: curl/7.77.0
> accept: */*
> 
* Connection state changed (MAX_CONCURRENT_STREAMS == 128)!
< HTTP/2 200 
< date: Wed, 08 Dec 2021 04:51:01 GMT
< content-type: application/json
< content-length: 24
< server: Werkzeug/2.0.1 Python/3.8.10
< 
{
  "Hello": "World!"
}
* Connection #0 to host dev.firstmistake.co.in left intact
 ```
<img src="assets/https.png" width="384" height="256">

## Observations:
1. When request is sent with http only

