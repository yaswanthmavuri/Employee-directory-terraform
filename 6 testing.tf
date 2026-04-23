resource "null_resource" "run_automation_test" {
  depends_on = [azurerm_virtual_machine_extension.app_setup]

  # ముందస్తు జాగ్రత్తగా మీ లోకల్ సిస్టమ్‌లో requests ప్యాకేజీని ఇన్స్టాల్ చేస్తుంది
  provisioner "local-exec" {
    command = "pip install requests"
  }

  # ఆ తర్వాత టెస్టింగ్ స్క్రిప్ట్ రన్ చేస్తుంది
  provisioner "local-exec" {
    command = "python test_app.py"
  }
}