data "template_cloudinit_config" "this" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      packages = ["nginx"]

      runcmd = [
        "systemctl enable nginx",
        "systemctl start nginx"
      ]
    })
  }
}
