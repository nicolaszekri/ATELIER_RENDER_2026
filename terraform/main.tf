terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "1.8.0"
    }
  }
}

variable "github_actor" {}

provider "render" {
  api_key = var.render_api_key
}

resource "render_web_service" "flask_app" {
  name     = "flask-app"
  owner_id = var.owner_id

  repo   = "https://github.com/nicolaszekri/ATELIER_RENDER_2026"
  branch = "main"

  runtime = "python"

  build_command = "pip install -r requirements.txt"
  start_command = "python app.py"

  env_vars = [
    {
      key   = "ENV"
      value = "production"
    }
  ]
}
