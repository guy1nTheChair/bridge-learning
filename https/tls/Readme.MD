# Bridge-Learning: HTTPS - TLS

# TLS 
Transportation Layer Security (TLS).

## Note:
1. Purchased Domain firstmistake.co.in on godaddy
2. Created hosted zone for firstmistake.co.in on AWS
3. Copied nameservers of above hosted zone into godaddy domain settings
4. Created SSL Cert on AWS ACM, with ```subject: firstmistake.co.in``` as root domain and ```subjectAltName: *.firstmistake.co.in``` for subsequent subdomains


## Observations:

 1. Created EC2, supplied user_data to install docker and run a docker container with host ports 80 and 443 forwarded to port 5000 of the container
 2. Created an ALB, Target Group, attached the EC2 instance to TG, created 2 listeners,
    1. port 80 listener forwarding to TG
    2. port 443 listener with SSL cert forwarding to TG
 3. Making request to API with http
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
 4. Making request with https
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