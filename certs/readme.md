Generating self-signed certs
----------------------------

Run `openssl req -x509 -newkey rsa:4096 -keyout tls-key.pem -out tls.pem -days 365 -nodes` and follow the prompts.
