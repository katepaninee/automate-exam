*** Settings ***
Library            SeleniumLibrary
Suite Setup        Set Selenium Speed         0.2s    

*** Variables ***
${url}                        https://www.arealme.com/colors/th/
${browser}                    gc
${locator_btn-start}          id=start


*** Keywords ***
Open Web Browser
    Open Browser                ${url}             ${browser}
    Maximize Browser Window
 
Select Color   
    ${element}=      Get WebElement        xpath=//div[contains(@class, 'color')]
    ${first_color}=  Get Element Attribute  ${element[0]}  style
    FOR  ${i}  IN  @{element}
        ${color}=    Get Element Attribute    ${element}    style
       # Run Keyword If  "${color}" != '${first_color}'  
        Click Element    ${element}
    END


*** Test Cases ***
TC-Test
    Open Web Browser
    Wait Until Page Contains    คุณจำแนกสีได้มากแค่ไหนกัน?
    Click Element               ${locator_btn-start}

# ยังติดปัญหาเรื่องการดึง Attribute ค่าสี
# เบื้องต้นจึง run scripts ได้ถึงหน้าเลือกสีค่ะ
