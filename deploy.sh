docker build -t lloydcapson/multi-client:latest -t lloydcapson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lloydcapson/multi-server:latest -t lloydcapson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lloydcapson/multi-worker:latest -t lloydcapson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lloydcapson/multi-client:latest
docker push lloydcapson/multi-server:latest
docker push lloydcapson/multi-worker:latest

docker push lloydcapson/multi-client:$SHA
docker push lloydcapson/multi-server:$SHA
docker push lloydcapson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lloydcapson/multi-server:$SHA
kubectl set image deployments/client-deployment client=lloydcapson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lloydcapson/multi-worker:$SHA