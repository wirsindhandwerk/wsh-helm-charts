# elasticsearch

TODO

## storageclass

example StorageClass for elasticsearch 
```yaml
---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: elasticsearch
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer

