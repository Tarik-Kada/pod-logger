docker build -t tarikkada/pod-logger:latest .
docker push tarikkada/pod-logger:latest

bash ./service-account.sh
kubectl apply -f ./deployment.yaml