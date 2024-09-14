minikube image load k8s.gcr.io/ingress-nginx/controller:v1.9.4
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server


cd backend
docker build -t todo-backend .
minikube image load todo-backend
cd ..

cd frontend
docker build -t todo-frontend .
minikube image load todo-frontend
cd ..

cd nginx
docker build -t todo-nginx .
minikube image load todo-nginx
cd ..

cd K8s
cd db
minikube kubectl -- create -f pv.yaml
minikube kubectl -- create -f pvc.yaml
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
minikube kubectl -- apply -f secret.yaml
cd ..

sleep 10

cd backend
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

cd frontend
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

cd nginx
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

minikube kubectl -- apply -f ingress.yaml
cd ..
