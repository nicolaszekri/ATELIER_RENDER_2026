terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "1.8.0"
    }
  }
}

provider "render" {
  api_key = var.render_api_key
}

resource "render_web_service" "flask_app" {
  name          = "flask-app"
  plan          = "free"
  region        = "frankfurt"
  start_command = "python app.py"

  runtime_source = {
    native_runtime = {
      auto_deploy   = true
      branch        = "main"
      build_command = "pip install -r requirements.txt"
      repo_url      = "https://github.com/nicolaszekri/ATELIER_RENDER_2026"
      runtime       = "python"
    }
  }

  env_vars = {
    ENV = {
      value = "production"
    }
  }
}

resource "render_web_service" "adminer" {
  name          = "adminer"
  plan          = "free"
  region        = "frankfurt"
  start_command = "docker run -p 10000:8080 adminer"

  runtime_source = {
    image = {
      image_url = "docker.io/adminer:latest"
    }
  }

  env_vars = {
    ADMINER_DEFAULT_SERVER = {
      value = "YOUR_POSTGRES_HOST"
    }
  }
}
