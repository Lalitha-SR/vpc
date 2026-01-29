# data "template_cloudinit_config" "this" {
#   gzip          = false
#   base64_encode = true

#   part {
#     content_type = "text/cloud-config"
#     content = yamlencode({
#       packages = ["nginx"]

#       runcmd = [
#         "systemctl enable nginx",
#         "systemctl start nginx"
#       ]
#     })
#   }
# }
data "template_cloudinit_config" "this" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"

    content = yamlencode({
      packages = ["nginx"]

      write_files = [
        {
          path        = "/usr/share/nginx/html/index.html"
          permissions = "0644"
          content     = "<h1>Hi from ${upper(var.app_name)}</h1>"
        }
      ]

      runcmd = [
        "systemctl enable nginx",
        "systemctl restart nginx"
      ]
    })
  }
}
