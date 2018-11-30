docker build -t hbtdocker/multi-client:latest -t hbtdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hbtdocker/multi-server:latest -t hbtdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hbtdocker/multi-worker:latest -t hbtdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hbtdocker/multi-client:latest
docker push hbtdocker/multi-server:latest
docker push hbtdocker/multi-worker:latest

docker push hbtdocker/multi-client:$SHA
docker push hbtdocker/multi-server:$SHA
docker push hbtdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hbtdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=hbtdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hbtdocker/multi-worker:$SHA