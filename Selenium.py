from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import webbrowser
import time
import pandas as pd
from Elem_ident import *

#selenium        4.30.0
#pandas          2.2.3

pd.options.display.colheader_justify = "left"
columns = ["duration", "title", "description"]
df = pd.DataFrame(columns=columns)

chrome_options = webdriver.ChromeOptions() # Add options to chrome
chrome_options.add_experimental_option('detach', True) # Keep the browser open
chrome_options.add_argument('--disk-cache-size=0') # Disable cache
chrome_options.add_argument('--blink-settings=imagesEnabled=false') # Disable image
chrome_options.add_argument('--headless') # Enable headless mode
driver = webdriver.Chrome(options=chrome_options)


URL = 'https://mate.academy/'

driver.get(URL)
#webbrowser.open(URL, new=2)
time.sleep(1.0)

time.sleep(1.0)
#print (ProfessionCards_content)
matches= driver.find_elements(By.CLASS_NAME, ProfessionCards_content)
for match in matches:
    #print (match.text)
    js_text = driver.execute_script("return arguments[0].innerText;", match)
    #print(js_text)
    lines = list(filter(None, js_text.strip().split("\n")))
    new_entry = {
        "duration": lines[0],  # Перша строка - тривалість
        "title": lines[1],  # Друга строка - назва професії
        "description": " ".join(lines[2:])  # Все інше - опис
    }
    df = pd.concat([df, pd.DataFrame([new_entry])], ignore_index=True)


print(df.to_string())
#print(df)
links = driver.find_elements(By.XPATH, ProfessionCards_links)
course_links = [link.get_attribute("href") for link in links]
#print("links", course_links)
columns_c = ["modules", "themes"]
df1 = pd.DataFrame(columns=columns_c)
for course_link in course_links:
    driver.get(course_link)
    time.sleep(0.5)
    ul_element = driver.find_element(By.CLASS_NAME, CourseModulesList_modules_list)
    modules = ul_element.find_elements(By.CLASS_NAME, Modules_classname)
    #print("Кількість модулів:", len(modules))
    Theme_el = driver.find_element(By.XPATH, Theme_window).text
    #print(Theme_el)
    new_entry = {
        "modules": len(modules),  # модулі
        "themes": Theme_el  # теми
    }
    df1 = pd.concat([df1, pd.DataFrame([new_entry])], ignore_index=True)

print(df1)
#webbrowser.open(ui_link)
time.sleep(1.0)
df_combined = pd.concat([df, df1], axis=1)
print(df_combined)
print("end of program")

driver.quit()