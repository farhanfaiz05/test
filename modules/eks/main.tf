#IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}

# Attach policies to the EKS role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

#EKS cluster
resource "aws_eks_cluster" "eks" {
  name     = "${var.name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      var.subnet1,
      var.subnet2,
    ]
  }
}


### EKS deployments

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.id
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

### Nginx ingress deployment
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true
}

### App deployments and service
resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "${var.name}-deployment"
    namespace = "default"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "${var.name}"
      }
    }
    template {
      metadata {
        labels = {
          app = "${var.name}"
        }
      }
      spec {
        container {
          name  = "${var.name}"
          image = "nginx"
          port {
            container_port = 80
          }
          volume_mount {
            name       = "code"
            mount_path = "/usr/share/nginx/html"
          }
        }
        volume {
          name = "code"
          config_map {
            name = kubernetes_config_map.app_cm.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name      = "${var.name}-service"
    namespace = "default"
  }
  spec {
    selector = {
      app = "${var.name}"
    }
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_config_map" "app_cm" {
  metadata {
    name      = "${var.name}-cm"
    namespace = "default"
  }
  data = {
    "index.html" = file("${var.filename}")
  }
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name = "${var.name}-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "${var.host}"
      http {
        path {
          path = "/"
          path_type = "Prefix"  
          backend {
            service {
              name = kubernetes_service.app_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}



