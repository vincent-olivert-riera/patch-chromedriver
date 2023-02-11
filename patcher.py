import os
import shutil
import subprocess

import undetected_chromedriver as uc

result = subprocess.run(
    ["/usr/bin/chromedriver", "--version"],
    capture_output=True,
    text=True
)
chromedriver_version = result.stdout.split(".")[0].split(" ")[1]

chromedriver_copy_path = f"{os.getcwd()}/chromedriver"
shutil.copy("/usr/bin/chromedriver", chromedriver_copy_path)

options = uc.ChromeOptions()
options.add_argument("--headless")

driver = uc.Chrome(
    driver_executable_path=chromedriver_copy_path,
    options=options,
    version_main=chromedriver_version
)
driver.get("chrome://newtab")
