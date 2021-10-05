# Kubectl Configmap Patcher

## Loadbalancer Patcher

Use as an init container to grab the ip address of a newly made load balancer prior to a container spinning up.

Example initContainer for a deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: some-deployment
spec:
  template:
    metadata:
      ...
    spec:
    {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      serviceAccountName: some-service-account
      initContainers:
      - name: lb-patcher
        image: servicedeployed/kubectl-loadbalancer-patcher
        env:
        - name: NAMESPACE
          value: {{ .Release.Namespace }}
        - name: CONFIG_MAP
          value: some-config-map
        - name: CONFIG_MAP_KEY
          value: public-ip
        - name: SERVICE
          value: some-service-name
      containers:
        ...
```