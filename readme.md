Encode the kubeconfig File:

[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Get-Content -Raw -Path "$HOME\.kube\config")))


Aws kube config command:

aws eks update-kubeconfig --region <region> --name <cluster_name>

Command for creating a namespace:
kubectl create namespace <namespace_name>

