Encode the kubeconfig File:

[Convert]::ToBase64String([IO.File]::ReadAllBytes("$env:USERPROFILE\.kube\config")) > kubeconfig_base64.txt


Aws kube config command:

aws eks update-kubeconfig --region <region> --name <cluster_name>

Command for creating a namespace:
kubectl create namespace <namespace_name>

