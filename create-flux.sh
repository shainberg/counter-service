export GHUSER="RivkaKremer"
export GHREPO="counter-service"
#kubectl create ns flux || true
#fluxctl install \
#  --git-user=${GHUSER} \
#  --git-branch=flask-eks-app \
#  --git-email=${GHUSER}@users.noreply.github.com \
#  --git-url=git@github.com:${GHUSER}/${GHREPO} \
#  --git-path= \
#  --namespace=flux | kubectl apply -f -

flux bootstrap github \
  --components-extra=image-reflector-controller,image-automation-controller \
  --owner=RivkaKremer \
  --repository=counter-service \
  --branch=flask-eks-app \
  --path=./ \
  --token-auth \
  --personal

# configure deploy key in github repository
# fluxctl identity --k8s-fwd-ns flux
sleep 30
fluxctl sync --k8s-fwd-ns flux
