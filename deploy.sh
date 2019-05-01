docker build -t ksakhamuri/multi-client:latest -t ksakhamuri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ksakhamuri/multi-server:latest -t ksakhamuri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ksakhamuri/multi-worker:latest -t ksakhamuri/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ksakhamuri/multi-client:latest
docker push ksakhamuri/multi-server:latest
docker push ksakhamuri/multi-worker:latest

docker push ksakhamuri/multi-client:$SHA
docker push ksakhamuri/multi-server:$SHA
docker push ksakhamuri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ksakhamuri/multi-server:$SHA
kubectl set image deployments/client-deployment client=ksakhamuri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ksakhamuri/multi-worker:$SHA
