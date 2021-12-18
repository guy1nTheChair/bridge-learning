# Bridge-Learning: HTTPS - mTLS

## mTLS
Mutual Transport Layer Security (mTLS) refers to act of two parties (client-server typically) authenticating each other's TLS certificates instead of verifying only server's certificate as in the case of TLS.

Typically used in private networks or businesses where internal communication that is not exposed to the public internet or zero-trust approach to network security is preferred.

This allows for:
1. Enhanced security by mitigating: 
    1. spoofing
    2. on-path attacks
    3. DDoS attacks etc, 
    
 as the person trying to compromise the system will not have the valid TLS certificate to prove their identity.

2. This is hard to implement on larger scale i.e global public internet, as this would require generating billions and billions of certificates and imported to browsers regularly and maintained, which seems practically a poor choice. Most of the times, we only need the server to possess a valid TLS certificate to prove it's identity in public internet and this is sufficient for the everyday security of using the internet.

## Technicals

In mTLS, both the client and server have a certificate, and both sides authenticate using their public/private key pair. Compared to regular TLS, there are additional steps in mTLS to verify both parties :

1. Client connects to server
2. Server presents its TLS certificate
3. Client verifies the server's certificate
4. Client presents its TLS certificate
5. Server verifies the client's certificate
6. Server grants access
7. Client and server exchange information over encrypted TLS connection

Source: Cloudfare

## Steps

1. Create Root CA. This CA will never be used to sign client/server certificates as risks high when private keys of Root CA are compromised, it could lead to compromising all intermediary certifcates and can be used later to sign any other certificates.
2. Create Intermediary CA to sign leaf (server/client) certificates
3. Generate private keys of leaf cert, then create certificate signing request. Then use the intermediary CA to sign the leaf cert (server/client)
4. Copy the contents of ca.crt of both inter and root to one single .crt file. import this file into browser as Authority.
5. Setup nginx server for testing locally with some dummy HTML content
6. Update nginx config /etc/nginx/sites-enabled/default with following attributes to enable mTLS
```      
server_name             localhost;
ssl_certificate         ssl/certificate.crt;
ssl_certificate_key     ssl/private.key;
ssl_protocols           TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
ssl_ciphers             HIGH:!aNULL:!MD5;
ssl_client_certificate  ssl/ca.crt;
ssl_verify_client       on;
```
7. Using curl for mTLS
```
root@bigred:~/my-own-ca# curl --key user-certs/private/user.key --cert user-certs/certs/user.crt --cacert certs/fullchain.crt https://mydomain.com -v
*   Trying 127.0.0.1:443...
* TCP_NODELAY set
* Connected to mydomain.com (127.0.0.1) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: certs/fullchain.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.3 (IN), TLS handshake, Request CERT (13):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.3 (OUT), TLS handshake, Certificate (11):
* TLSv1.3 (OUT), TLS handshake, CERT verify (15):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use http/1.1
* Server certificate:
*  subject: C=NL; ST=Hilversum; L=Hilversum; O=My Company; CN=www.mydomain.com
*  start date: Dec 18 13:57:59 2021 GMT
*  expire date: Dec 18 13:57:59 2022 GMT
*  subjectAltName: host "mydomain.com" matched cert's "mydomain.com"
*  issuer: C=NL; ST=Hilversum; O=My Company Ltd.; CN=MyInterCA
*  SSL certificate verify ok.
> GET / HTTP/1.1
> Host: mydomain.com
> User-Agent: curl/7.68.0
> Accept: */*
> 
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* old SSL session ID is stale, removing
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: nginx/1.18.0 (Ubuntu)
< Date: Sat, 18 Dec 2021 14:44:03 GMT
< Content-Type: text/html
< Content-Length: 31
< Last-Modified: Sat, 18 Dec 2021 14:06:32 GMT
< Connection: keep-alive
< ETag: "61bdeae8-1f"
< Accept-Ranges: bytes
< 
Custom HTML Content by Santosh
* Connection #0 to host mydomain.com left intact
root@bigred:~/my-own-ca# 
```
8. Removing ```--key``` and ```--cert``` from curl command. This implies, the user is not presenting our certificate to the server.
```
root@bigred:~/my-own-ca# curl --cacert certs/fullchain.crt https://mydomain.com -v
*   Trying 127.0.0.1:443...
* TCP_NODELAY set
* Connected to mydomain.com (127.0.0.1) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: certs/fullchain.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.3 (IN), TLS handshake, Request CERT (13):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.3 (OUT), TLS handshake, Certificate (11):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use http/1.1
* Server certificate:
*  subject: C=NL; ST=Hilversum; L=Hilversum; O=My Company; CN=www.mydomain.com
*  start date: Dec 18 13:57:59 2021 GMT
*  expire date: Dec 18 13:57:59 2022 GMT
*  subjectAltName: host "mydomain.com" matched cert's "mydomain.com"
*  issuer: C=NL; ST=Hilversum; O=My Company Ltd.; CN=MyInterCA
*  SSL certificate verify ok.
> GET / HTTP/1.1
> Host: mydomain.com
> User-Agent: curl/7.68.0
> Accept: */*
> 
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* old SSL session ID is stale, removing
* Mark bundle as not supporting multiuse
< HTTP/1.1 400 Bad Request
< Server: nginx/1.18.0 (Ubuntu)
< Date: Sat, 18 Dec 2021 14:45:32 GMT
< Content-Type: text/html
< Content-Length: 246
< Connection: close
< 
<html>
<head><title>400 No required SSL certificate was sent</title></head>
<body>
<center><h1>400 Bad Request</h1></center>
<center>No required SSL certificate was sent</center>
<hr><center>nginx/1.18.0 (Ubuntu)</center>
</body>
</html>
* Closing connection 0
* TLSv1.3 (OUT), TLS alert, close notify (256):
root@bigred:~/my-own-ca# 

```
9. Even with key, certs being supploed, using http only returns ```403 FORBIDDEN``` error as this is explicitly configured in the nginx config
```
root@bigred:~/my-own-ca# curl --key user-certs/private/user.key --cert user-certs/certs/user.crt --cacert certs/fullchain.crt http://mydomain.com -v
*   Trying 127.0.0.1:80...
* TCP_NODELAY set
* Connected to mydomain.com (127.0.0.1) port 80 (#0)
> GET / HTTP/1.1
> Host: mydomain.com
> User-Agent: curl/7.68.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 403 Forbidden
< Server: nginx/1.18.0 (Ubuntu)
< Date: Sat, 18 Dec 2021 14:51:49 GMT
< Content-Type: text/html
< Content-Length: 162
< Connection: keep-alive
< 
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.18.0 (Ubuntu)</center>
</body>
</html>
* Connection #0 to host mydomain.com left intact

```

References: https://www.udemy.com/course/ssltls-essentials-theory-and-implementation/
