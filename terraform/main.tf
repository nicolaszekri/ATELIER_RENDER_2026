provider "render" {
  api_key = var.render_api_key
}

resource "render_web_service" "flask_app" {
  name     = "flask-app"
  owner_id = var.owner_id

  repo   = "https://github.com/nicolaszekri/ATELIER_RENDER_2026"
  branch = "main"

  build_command = "pip install -r requirements.txt"
  start_command = "python app.py"

  env_vars = [
    {
      key   = "ENV"
      value = "production"
    }
  ]
}
