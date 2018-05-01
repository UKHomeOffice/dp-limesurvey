ACP-ised Lime Survey
====================

Build Lime Survey docker image and basic deployment to ACP. This is done with Apache 2.4 and mod_php 5.5.

*Requirements*
* MySQL RDS instance
* Persistent Volumes for configuration, uploads and temporary files
* SES details if you want to send e-mails.

*Things you'll need to do*
* Change hostname in the ingress
* After initial deployment, the instance needs to be configured with DB and e-mail details
* Config will survive redeployment as long as you don't remove the PVs or DB

Deployment
----------
```
# Persistent volumes
kd --context <context> \
	--file kube-notprod/volume-config.yaml \
	--file kube-notprod/volume-tmp.yaml \
	--file kube-notprod/volume-upload.yaml

# Application
kd --context <context> \
	--file kube-notprod/service.yaml \
	--file kube-notprod/deployment.yaml \
	--file kube-notprod/ingress.yaml \
	--file kube-notprod/networkpolicy.yaml
```

Deploy locally using the configuration in `kube`. You'll need to create a self-signed certificate in `/tmp/certs` by running `openssl req -x509 -newkey rsa:4096 -keyout tls-key.pem -out tls.pem -days 365 -nodes` and following the prompts.

```
kd --context <local_context> \
	--file kube/service.yaml \
	--file kube/deployment.yaml \
	--file kube/ingress.yaml \
```

