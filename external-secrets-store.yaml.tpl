apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-backend
  namespace: ${NAMESPACE} 
spec:
  provider:
    vault:
      server: "${VAULT_URL}"
      path: "${VAULT_ENGINE_PATH}"
      version: "${VAULT_VERSION}"
      auth:
        tokenSecretRef:
          name: "vault-token"
          key: "token"
