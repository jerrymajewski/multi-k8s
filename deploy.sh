docker build -t jerrymajewski/multi-client:latest -t jerrymajewski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jerrymajewski/multi-server:latest -t jerrymajewski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jerrymajewski/multi-worker:latest -t jerrymajewski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jerrymajewski/multi-client:latest
docker push jerrymajewski/multi-server:latest
docker push jerrymajewski/multi-worker:latest

docker push jerrymajewski/multi-client:$SHA
docker push jerrymajewski/multi-server:$SHA
docker push jerrymajewski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jerrymajewski/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jerrymajewski/multi-worker:$SHA
kubectl set image deployments/client-deployment client=jerrymajewski/multi-client:$SHA
