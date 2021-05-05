kind create cluster --wait 5m
kind get clusters
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward svc/argocd-server -n argocd 8080:443
argocd login localhost:8080
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml