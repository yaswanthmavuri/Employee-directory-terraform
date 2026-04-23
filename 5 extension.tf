# 10. The Ultimate Fix: Custom Script Extension
resource "azurerm_virtual_machine_extension" "app_setup" {
  name                 = "employee-app-setup"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  protected_settings = <<PROT
  {
    "script": "${base64encode(<<EOF
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# ఇక్కడే మనం pip తీసేసి, డైరెక్ట్ గా python3-flask ఇస్తున్నాం!
apt-get update -y
apt-get install -y python3-flask sqlite3

mkdir -p /opt/employee-project
cd /opt/employee-project

cat << 'EOT' > app.py
${file("app.py")}
EOT

cat << 'EOT' > /etc/systemd/system/employeeapp.service
[Unit]
Description=Flask Employee Application
After=network.target

[Service]
User=root
WorkingDirectory=/opt/employee-project
ExecStart=/usr/bin/python3 /opt/employee-project/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
systemctl enable employeeapp.service
systemctl start employeeapp.service
EOF
    )}"
  }
  PROT
}