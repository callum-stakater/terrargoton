kind create cluster --wait 5m
kind get clusters
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl create namespace terraform
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml


#kubectl port-forward svc/argocd-server -n argocd 8080:443
#argocd login localhost:8080


kubectl delete -f .
kubectl apply -f pipeline_tasks.yaml
kubectl apply -f pipeline_resource.yaml
kubectl apply -f pipeline_apply.yaml
kubectl apply -f pipeline_plan.yaml
kubectl apply -f pipeline_run.yaml
kubectl apply -f trigger_binding.yaml
kubectl apply -f trigger_template.yaml
kubectl apply -f trigger_event_listener.yaml