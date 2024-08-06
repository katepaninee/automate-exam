*** Settings ***
Library            SeleniumLibrary
Suite Setup        Set Selenium Speed         0.2s
Test Setup         Open Web browser
Test Teardown      Close Browser
Suite Teardown     Close All Browsers

*** Variables ***
${url}                        https://app.uppass.io/en/mid-assignment
${browser}                    gc
${locator_btn-start}          xpath=//*[@id="content-block-3"]/div[2]/div/button
${locator_btn-phone}          xpath=//*[@id="ok-dy__FormItem-telephone"]/div/div/div/div[2]/div/div[1]/div/div/div[1]/div/div[1]/div/div/button   
${locator_thailand}           xpath=//*[@id="ok-dy__FormItem-telephone"]/div/div/div/div[2]/div/div[1]/div/div/div[1]/div/div[2]/div/div/div/div[2]/a[1]/div/div[2]
${locator_field-search}       xpath=//*[@id="ok-dy__FormItem-telephone"]/div/div/div/div[2]/div/div[1]/div/div/div[1]/div/div[2]/div/div/div/div[1]/input
${locator_field-phone}        name=telephone
${locator_field-email}        name=email_email
${locator_field-cfemail}      name=email_confirmation
${locator_field-streetAd}     id=addressAddressField
${locator_province}           id=addressProvinceField
${locator_district}           id=addressDistrictField
${locator_subdistrict}        id=addressSubdistrictField
${locator_zipcode}            id=addressZipcodeField
${locator_search-province}    xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[3]/div/div/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[1]/input
${locator_provice-bkk}        xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[3]/div/div/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[2]/a[2]
${locator_btn-Next}           id=button__forward
${locator_btn-homepage}       xpath=//*[@id="ok-dy__FormItem-back_btn"]/div/div/div/div[2]/div/div[1]/div/div/div/div/a

#verify error msg
${locator_error_search-phone}    xpath=//*[@id="ok-dy__FormItem-telephone"]/div/div/div/div[2]/div/div[2]
${locator_error_e-mail}          xpath=//*[@id="ok-dy__FormItem-email_email"]/div/div/div/div[2]/div/div[2]  
${locator_error_cfe-mail}        xpath=//*[@id="ok-dy__FormItem-email_confirmation"]/div/div/div/div[2]/div/div[2]
${locator_error-streetAd}        xpath=//*[@id="ok-dy__FormItem-address_address"]/div/div/div/div[2]/div/div[2]
${locator_error-province}        xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[3]/div/div/div/div[2]/div/div[2]
${locator_error-district}        xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[4]/div/div/div/div[2]/div/div[2]
${locator_error-subdistrict}     xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[5]/div/div/div/div[2]/div/div[2]
${locator_error-zipcode}         xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[6]/div/div/div/div[2]/div/div[2]

#score
${locator_question1}             name=dropdown
${locator_question1-score1}      xpath=//*[@id="dropdownField"]/option[2]
${locator_question1-score2}      xpath=//*[@id="dropdownField"]/option[3]
${locator_question1-score3}      xpath=//*[@id="dropdownField"]/option[4]
${locator_question2-score1}      xpath=//*[@id="choice0Label"]/span
${locator_question2-score2}      xpath=//*[@id="choice1Label"]/span
${locator_question2-score3}      xpath=//*[@id="choice2Label"]/span
${locator_question3-score1}      id=choice10Label
${locator_question3-score2}      id=choice11Label
${locator_question3-score3}      id=choice12Label

*** Keywords ***
Open Web Browser
    Open Browser                ${url}    ${browser}
    Maximize Browser Window
    Wait Until Page Contains    Begin your onboarding

Contact Details Page
    Click Element                          ${locator_btn-start}
    Wait Until Element Is Visible          ${locator_btn-phone}                5s

Input Data Contact Details Pass
    Contact Details Page
    Click Button                           ${locator_btn-phone}
    Wait Until Element Is Visible          ${locator_field-search}             5s
    Input Text                             ${locator_field-search}             66
    Click Element                          ${locator_thailand}
    Input Text                             ${locator_field-phone}              123456789          
    Input Text                             ${locator_field-email}              test@mail.com
    Input Text                             ${locator_field-cfemail}            test@mail.com
    Input Text                             ${locator_field-streetAd}           123 ถ.วันจันทร์ @Moo 2
    ${element}=      Get WebElement        xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[6]/div/div/div   
    Scroll Element Into View               ${element}    
    Click Element                          ${locator_province}
    Wait Until Element Is Visible          ${locator_search-province}          5s
    Click Element                          ${locator_provice-bkk}
    Click Element                          ${locator_btn-Next}
    Wait Until Element Is Visible          ${locator_question1}                5s

Verify error msg fail - Test Template
    [Arguments]    ${locator}    ${msg}
    Open Web Browser
    Contact Details Page
    ${element}=      Get WebElement        xpath=//*[@id="ok-dy__FormItem-address"]/div/fieldset/div[6]/div/div/div   
    Scroll Element Into View               ${element} 
    Click Element                          ${locator_btn-Next}
    Verify error msg fail                  ${locator}                          ${msg}
    Close Browser

Verify error msg fail
    [Arguments]                         ${locator}              ${msg}=${EMPTY}
    ${txt}=    Get Text                 ${locator}
    Should Be Equal As Strings          ${txt}                  ${msg}       


Select question1-score1
    Click Element                       ${locator_question1}
    Wait Until Element Is Visible       ${locator_question1-score1} 
    Click Element                       ${locator_question1-score1} 

Select question1-score2
    Click Element                       ${locator_question1}
    Wait Until Element Is Visible       ${locator_question1-score2} 
    Click Element                       ${locator_question1-score2} 

Select question1-score3
    Click Element                       ${locator_question1}
    Wait Until Element Is Visible       ${locator_question1-score3} 
    Click Element                       ${locator_question1-score3} 


Input Data Score Page - Test Template
    [Arguments]    ${question1}    ${question2}    ${question3}
    #dropdown question1
    IF  ${question1} == 1
        Select question1-score1       
    END
    IF  ${question1} == 2
        Select question1-score2     
    END
    IF  ${question1} == 3
        Select question1-score3  
    END
    
    #radio button question2
    IF  "${question2}" == 1
        Select Radio Button        ${locator_question2-score1}        ${question2}
    ELSE IF  "${question2}" == 2
        Select Radio Button        ${locator_question2-score2}        ${question2}
    ELSE IF  "${question2}" == 3
        Select Radio Button        ${locator_question2-score3}        ${question2}
    END 

    #checkbox question3
    IF  ${question3} == 1
        Select Checkbox            ${locator_question3-score1}
    ELSE IF  ${question3} == 2
        Select Checkbox            ${locator_question3-score1}
        Select Checkbox            ${locator_question3-score2}
    ELSE IF  ${question3} == 3
        Select Checkbox            ${locator_question3-score1}
        Select Checkbox            ${locator_question3-score2}
        Select Checkbox            ${locator_question3-score3}
    END

*** Test Cases ***
TC001-Input Data Contact Details Pass and select score
    [Documentation]    ใช้สำหรับทดสอบ กรณีกรอกครบถ้วน และเลือก score
    [Tags]     test pass
    Input Data Contact Details Pass
    # กรณีได้ score = 1
    Click Element    ${locator_question1-score1}
    # กรณีได้ score = 2
    Click Element    ${locator_question2-score1}
    Click Element    ${locator_question3-score1}
    # กรณีได้ score = 3
    Click Element    ${locator_question1-score1}
    Click Element    ${locator_question2-score1}
    Click Element    ${locator_question3-score1}
    # กรณีได้ score = 4
    Click Element    ${locator_question1-score2}
    Click Element    ${locator_question2-score1}
    Click Element    ${locator_question3-score1}
    # กรณีได้ score = 5
    Click Element    ${locator_question1-score2}
    Click Element    ${locator_question2-score2}
    Click Element    ${locator_question3-score1}
    # กรณีได้ score = 6
    Click Element    ${locator_question1-score2}
    Click Element    ${locator_question2-score2}
    Click Element    ${locator_question3-score1}
    Click Element    ${locator_question3-score2}
    # กรณีได้ score = 7
    Click Element    ${locator_question1-score3}
    Click Element    ${locator_question2-score2}
    Click Element    ${locator_question3-score1}
    Click Element    ${locator_question3-score2}
    # กรณีได้ score = 8
    Click Element    ${locator_question1-score3}
    Click Element    ${locator_question2-score3}
    Click Element    ${locator_question3-score1}
    Click Element    ${locator_question3-score2}
    # กรณีได้ score = 9 และกดปุ่ม Submit
    Click Element    ${locator_question1-score3}
    Click Element    ${locator_question2-score3}
    Click Element    ${locator_question3-score1}
    Click Element    ${locator_question3-score2}
    Click Element    ${locator_question3-score3}
    Click Button     ${locator_btn-Next}
    Wait Until Page Contains    Verification Complete    5s
    Click Element    ${locator_btn-homepage}
    Wait Until Page Contains    Begin your onboarding    5s   


# TC002 ยังไม่สามารถ run ได้ เนื่องจากยังพบปัญหาในการ Verify error message
TC002-Input Data Contact Details fail
    [Documentation]    ใช้สำหรับทดสอบข้อความแจ้งเตือน กรณีกรอกไม่ครบถ้วน
    [Tags]     test fail
    [Setup]
    [Template]    Verify error msg fail - Test Template
    ${locator_error_search-phone}      String must contain at least 1 character(s)
    ${locator_error_search-phone}      Invalid phone number
    ${locator_error_e-mail}            Please provide your e-mail
    ${locator_error_cfe-mail}          Please confirm your e-mail
    ${locator_error-streetAd}          The Street Address field is required.
    ${locator_error-province}          The Province field is required.
    ${locator_error-district}          The District field is required.
    ${locator_error-subdistrict}       The Sub-district field is required.
    ${locator_error-zipcode}           The Postal / Zip Code field is required.


# TC003 และ TC004 เป็นการเขียน Template ของ TC001 เพื่อลดความยาวในการเขียนคำสั่ง
# แต่ยังพบปัญหาไม่สามารถ run ได้
# ปัญหาหลักที่พบในการ run scripts คือ ติดปัญหาเรื่อง CAPTCHA จึงทำให้ run scripts เพื่อ test ต่อเนื่องไม่ได้ 

TC003-Input Data Score Page - no button submit
    Input Data Contact Details Pass and select score
    [Documentation]    ใช้สำหรับทดสอบการกด score ให้ได้คะแนน 1-6 
    [Tags]     no button submit
    [Setup]
    [Template]    Input Data Score Page - Test Template
    1        0        0
    1        1        0
    1        1        1
    2        1        1
    2        2        1
    2        2        2
    [Teardown]

TC004-Input Data Score Page - button submit
    [Documentation]    ใช้สำหรับทดสอบการกด score ให้ได้คะแนน 7-9
    [Tags]     button submit
    [Setup]
    [Template]    Input Data Score Page - Test Template
    3        2        2
    3        3        2
    3        3        3
    [Teardown]



