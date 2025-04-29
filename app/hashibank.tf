resource "kubernetes_deployment" "hashibank" {
  metadata {
    namespace = kubernetes_namespace_v1.demo_ns.id
    name = "hashibank"
    labels = {
      app = "hashibank"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hashibank"
      }
    }

    template {
      metadata {
        labels = {
           app = "hashibank"
        }
      }

      spec {
        container {
          image = "jamiewri/hashibank:0.0.3"
          name  = "hashibank"
          args                  = ["-dev"]

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }


          port {
            container_port = 8080
          }
          }
        }
      }
    }
}



resource "kubernetes_service_v1" "hashibank" {
  metadata {
    name = "hashibank-svc"
    namespace = "demo-ns"
  }
  spec {
    selector = {
      app = kubernetes_deployment.hashibank.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

