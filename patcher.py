import os
import shutil

import undetected_chromedriver as uc

chromedriver_copy_path = f"{os.getcwd()}/chromedriver"
shutil.copy("/usr/bin/chromedriver", chromedriver_copy_path)

options = uc.ChromeOptions()
options.headless=True
options.add_argument('--headless')

driver = uc.Chrome(driver_executable_path=chromedriver_copy_path, options=options)
driver.get("chrome://newtab")
