Encode the kubeconfig File:

[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Get-Content -Raw -Path "$HOME\.kube\config")))


Aws config command:

aws eks update-kubeconfig --region <region> --name <cluster_name>
