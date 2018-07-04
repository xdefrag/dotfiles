function kubectl-switch-ns
  kubectl config set-context (kubectl config current-context) --namespace=$argv
end
