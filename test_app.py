import requests
import time

# ఇక్కడ మీ వెబ్సైట్ IP ని మార్చండి
URL = "http://40.80.92.101:5000"

print("--- Automation Testing Started ---\n")

try:
    # Test 1: Checking Website Status
    print("Test 1: Checking if website is running...")
    response = requests.get(URL)
    
    if response.status_code == 200:
        print("SUCCESS: Website is up and running!\n")
    else:
        print(f"FAILED: Website returned status code: {response.status_code}\n")

    # Test 2: Testing Data Insertion
    print("Test 2: Adding a dummy employee (Auto Tester)...")
    test_data = {'name': 'Auto Tester'}
    
    post_response = requests.post(f"{URL}/add", data=test_data)
    
    if "Auto Tester" in post_response.text:
        print("SUCCESS: Data added successfully and verified on website!\n")
    else:
        print("FAILED: Data was not saved.\n")

except Exception as e:
    print(f"ERROR: Could not connect to server: {e}")

print("--- Automation Testing Completed ---")