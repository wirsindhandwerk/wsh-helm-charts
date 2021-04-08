# elasticsearch

TODO

# Prerequisites 

The following prerequisites should be configured outside of the chart
## `elasticsearch.data.storageClassName`

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

```

This `StorageClass` is then referenced in `elasticsearch.data.storageClassName`


## `kibana.frontendPrefix`

This is used to load kibana in the frontend
