## Note:
1. Purchased Domain firstmistake.co.in on godaddy
2. Created hosted zone for firstmistake.co.in on AWS
3. Copied nameservers of above hosted zone into godaddy domain settings
4. Created SSL Cert on AWS ACM, with 
    1. ```subject: firstmistake.co.in``` as root domain
    2. ```subjectAltName: *.firstmistake.co.in``` for subdomains
