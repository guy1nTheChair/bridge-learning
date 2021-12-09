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