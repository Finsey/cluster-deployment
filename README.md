# cluster-deployment
Deploy a home cluster with full infrastructure for a smart home.

## Deployment

### Terraform
The use of this Terraform project has only been tested on a Windows 10 Operating System.

#### Prerequisites
- `terraform` installed to local device
- `Docker` installed to local device

#### Manual steps
Verify that your device hosting the KinD cluster has been provisioned with a static IPv4 address.

Edit the `dnsmasq.conf` file located at `./terraform/files/dnsmasq/dnsmasq.conf` so that `dnsmasq` resolves domain requests to your desired domain name. For example:

```
...
# Resolve all *.{sub-address-name}.{address-name} to host machine running KinD (or your PC IP)
address=/.mysurname.home/{static-ip-address-hosting-kind}
...
```

You can then proceed to add your DNS router to devices that you plan to access the smart home system from through two options:
1. Navigating to the default gateway address of your home network in your browser (e.g. `192.168.1.254`) and amend your DNS configuration to support the static IP address that will run your home DNS server (to resolve cluster records) and a public DNS server (e.g. `8.8.8.8`); or
2. Manually add the static IP address running your home DNS server (suggested: make sure that a public DNS server is available to ensure access to the internet (e.g. `8.8.8.8`)).

#### Run Terraform
Clone this Git repository to your device and run the below commands:

```
terraform init
terraform plan
terraform apply
```

### Ansible

I then launched WSL2 (Ubuntu) to run the Ansible automation procedure.

#### Prerequisites
- `ansible`
- `python3`
- `pip`
- `kubernetes` package for Python

#### Manual Steps
If you do not have a Root CA available, begin by creating a private key and a self-signed certificate that serves as your Root CA. For example, using OpenSSL:

```
# Generate a 4096-bit RSA private key
openssl genrsa -out rootCA.key 4096

# Generate a self-signed certificate valid for 20 years
openssl req -x509 -new -nodes -key rootCA.key \
  -sha256 -days 7300 \
  -subj "/C=UK/ST=State/L=City/O=Org/CN=MyRootCA" \
  -our rootCA.crt
```

Store the private key in a secure location and distribute the CA certificate to clients/machines attempting to access services on your network.

#### Installation

The `kubernetes.core` Ansible collection is required. This can be installed via:

```
ansible-galaxy collection install -r collections.yaml
```