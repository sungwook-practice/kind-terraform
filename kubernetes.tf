resource "kind_cluster" "default" {
  name           = "cluster-1"
  wait_for_ready = true
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role  = "control-plane"
      image = "kindest/node:v1.23.4"

      # reference: https://kind.sigs.k8s.io/docs/user/using-wsl2/#accessing-a-kubernetes-service-running-in-wsl2
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
      # argo-cd http port
      extra_port_mappings {
        container_port = 30080
        host_port      = 30080
      }
      # argo-cd https port
      extra_port_mappings {
        container_port = 30443
        host_port      = 30443
      }
    }

    node {
      role  = "worker"
      image = "kindest/node:v1.23.4"
    }
  }
}
