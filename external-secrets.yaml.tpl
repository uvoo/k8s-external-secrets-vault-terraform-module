---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: ${SECRET_NAME} 
  namespace: ${NAMESPACE} 
spec:
  refreshInterval: "${REFRESH_INTERVAL}"
  secretStoreRef:
    name: vault-backend
    kind: SecretStore
  target:
    name: ${SECRET_NAME} 
    creationPolicy: ${CREATION_POLICY}
  %{ if length(SECRET_DATAFROM_KEY) > 1 }
  dataFrom:
  - extract:
      conversionStrategy: Default
      decodingStrategy: Auto
      key: ${SECRET_DATAFROM_KEY}
  %{ endif }
  ${SECRET_DATA}
