cd K8s
minikube kubectl -- delete -f ingress.yaml

cd redis
minikube kubectl -- delete -f service.yaml
minikube kubectl -- delete -f deployment.yaml
cd ..

cd nginx
minikube kubectl -- delete -f service.yaml
minikube kubectl -- delete -f deployment.yaml
cd ..

cd frontend
minikube kubectl -- delete -f service.yaml
minikube kubectl -- delete -f deployment.yaml
cd ..

cd backend
minikube kubectl -- delete -f service.yaml
minikube kubectl -- delete -f deployment.yaml
cd ..

cd db
minikube kubectl -- delete -f service.yaml
minikube kubectl -- delete -f deployment.yaml
minikube kubectl -- delete -f secret.yaml
minikube kubectl -- delete -f pvc.yaml
minikube kubectl -- delete -f pv.yaml
cd ..
cd ..