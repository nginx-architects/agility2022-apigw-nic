kubectl -n api delete secrets jwk-secret
kubectl -n api delete policy jwt-policy
kubectl apply -f module1/api-runtimes-vs.yaml