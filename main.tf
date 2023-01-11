resource "kubernetes_secret" "secrets-vault-token" {
  for_each = { for i in var.external_secrets : i.NAMESPACE => i }
  metadata {
    name      = "vault-token"
    namespace = each.value.NAMESPACE
  }
  data = {
    token = each.value.VAULT_TOKEN
  }
}

resource "kubernetes_manifest" "external-secrets-store" {
  for_each = { for i in var.external_secrets : i.NAMESPACE => i }

  manifest = yamldecode(
    templatefile("${path.module}/external-secrets-store.yaml.tpl",
      {
        NAMESPACE         = each.value.NAMESPACE
        VAULT_URL         = each.value.VAULT_URL
        VAULT_ENGINE_PATH = each.value.VAULT_ENGINE_PATH
        VAULT_VERSION     = each.value.VAULT_VERSION
      }

    )
  )
}

resource "kubernetes_manifest" "external-secrets" {
  for_each = { for i in var.external_secrets : i.NAMESPACE => i }
  manifest = yamldecode(
    templatefile("${path.module}/external-secrets.yaml.tpl",
      {
        SECRET_NAME         = each.value.SECRET_NAME
        NAMESPACE           = each.value.NAMESPACE
        REFRESH_INTERVAL    = each.value.REFRESH_INTERVAL
        SECRET_DATA         = each.value.SECRET_DATA
        SECRET_DATAFROM     = each.value.SECRET_DATAFROM
        SECRET_DATAFROM_KEY = each.value.SECRET_DATAFROM_KEY
        CREATION_POLICY     = each.value.CREATION_POLICY
      }
    )
  )
}
