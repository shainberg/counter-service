export GHUSER="RivkaKremer"
export GHREPO="counter-service"
kubectl create ns flux || true
fluxctl install \
  --git-user=${GHUSER} \
  --git-branch=flask-eks-app \
  --git-email=${GHUSER}@users.noreply.github.com \
  --git-url=git@github.com:${GHUSER}/${GHREPO} \
  --git-path=namespaces,workloads \
  --namespace=flux | kubectl apply -f -
