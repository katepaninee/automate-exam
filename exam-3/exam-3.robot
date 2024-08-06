*** Settings ***
Library            SeleniumLibrary
Suite Setup        Set Selenium Speed         0.2s
Test Setup         Open Web browser
Test Teardown      Close Browser
Suite Teardown     Close All Browsers

*** Variables ***
${url}                        https://app.uppass.io/en/last-assignment
${browser}                    gc
${locator_btn-start}          xpath=//*[@id="content-block-3"]/div[2]/div/button
${locator_lable}              xpath=//*[@id="app"]/div/div/div[1]/div[1]/p


*** Keywords ***
Open Web Browser
    Open Browser                     ${url}    ${browser}
    Maximize Browser Window
    Wait Until Element Is Visible    ${locator_btn-start} 


*** Test Cases ***
TC001-Test
    Click Element                    ${locator_btn-start}
    Wait Until Page Contains         Continue on your phone         5s


# ยังไม่ได้เขียนใน scripts ใน mobile เนื่องจากข้อจำกัดเรื่องเวลาและอุปกรณ์ 
# เนื่องจาก spec ที่ใช้งานทำให้เมื่อเปิดโปรแกรมและใช้งาน appium ค่อนข้างค้างบ่อย
# จะพยายามฝึกฝนเรียนรู้เพิ่มเติม เพื่อทำงานให้เร็วขึ้นค่ะ