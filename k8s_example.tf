resource "kubernetes_namespace" "apps" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.apps.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:1.27"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.apps.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.nginx.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
