# k8s-external-secrets-vault-terraform-module
Terraform module that syncs Hashicorp Vault secrets to Kubernetes secrets

Usage of module

external-secrets.tf
```
module "external-secrets" {
  source = "git@github.com:uvoo/k8s-external-secrets-vault-terraform-module.git?ref=main"
  external_secrets = [
    {
      SECRET_NAME         = "etc-certs"
      NAMESPACE           = "haproxy"
      REFRESH_INTERVAL    = "500s"
      SECRET_DATA         = ""
      SECRET_DATAFROM     = ""
      SECRET_DATAFROM_KEY = "k8s/haproxy/certs"
      CREATION_POLICY     = "Owner"
      VAULT_TOKEN         = var.VAULT_TOKEN
      VAULT_ENGINE_PATH   = "k8s-cluster1"
      VAULT_URL           = "https://vault.example.com:8200/"
      VAULT_VERSION       = "v1"
    },
    {
      SECRET_NAME         = "ingress-nginx"
      NAMESPACE           = "ingress-nginx"
      REFRESH_INTERVAL    = "500s"
      SECRET_DATA         = <<-EOT
      data:
        - secretKey: tls-default
          remoteRef:
            key: k8s/haproxy/certs
            property: tls-star-example-com
      EOT
      SECRET_DATAFROM     = ""
      SECRET_DATAFROM_KEY = ""
      CREATION_POLICY     = "Owner"
      VAULT_TOKEN         = var.VAULT_TOKEN
      VAULT_ENGINE_PATH   = "k8s-cluster1"
      VAULT_URL           = "https://vault.example.com:8200/"
      VAULT_VERSION       = "v1"
    }
  ]
}
```
