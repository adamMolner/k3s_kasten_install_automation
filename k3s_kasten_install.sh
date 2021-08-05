# install k3s
curl -sfL https://get.k3s.io | sh -

# must set KUBECONFIG variable before running 'helm install k10...'
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh



# Prerequisites
helm repo add kasten https://charts.kasten.io/

kubectl create namespace kasten-io


# install k10
helm install k10 kasten/k10 --namespace=kasten-io \
    --set secrets.awsAccessKeyId=${{ secrets.AWS_ACCESS_KEY_ID }} \
    --set secrets.awsSecretAccessKey=${{ secrets.AWS_SECRET_ACCESS_KEY }}


# verify installation
kubectl get pods --namespace kasten-io --watch
