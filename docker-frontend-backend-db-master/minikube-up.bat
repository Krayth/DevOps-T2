@echo off

REM Verifica se o Minikube esta rodando
echo Verificando o estado do Minikube...
minikube status
if %errorlevel% neq 0 (
    echo Minikube nao esta rodando. Iniciando Minikube...
    minikube start --cpus 5
)

REM Habilitando imagem k8s e outras ferramentas
minikube image load k8s.gcr.io/ingress-nginx/controller:v1.9.4
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server

REM Construindo as imagens
echo Construindo a imagem do backend...
cd backend
docker build -t todo-backend .
minikube image load todo-backend
cd ..

echo Construindo a imagem do frontend...
cd frontend
docker build -t todo-frontend .
minikube image load todo-frontend
cd ..

echo Construindo a imagem customizada do Nginx...
cd nginx
docker build -t todo-nginx .
minikube image load todo-nginx
cd ..

REM Aplicando os arquivos YAML para Kubernetes
echo Aplicando os arquivos YAML do banco de dados...
cd K8s\db
minikube kubectl -- create -f pv.yaml
minikube kubectl -- create -f pvc.yaml
minikube kubectl -- apply -f secret.yaml
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

echo Aplicando os arquivos YAML do backend...
cd backend
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

echo Aplicando os arquivos YAML do frontend...
cd frontend
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

echo Aplicando os arquivos YAML do Nginx...
cd nginx
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

echo Aplicando os arquivos YAML do Redis...
cd redis
minikube kubectl -- apply -f deployment.yaml
minikube kubectl -- apply -f service.yaml
cd ..

echo Aplicando ingress
minikube kubectl -- apply -f ../K8s/ingress.yaml
cd ..

echo Todos os componentes foram implantados no cluster Minikube!
pause
