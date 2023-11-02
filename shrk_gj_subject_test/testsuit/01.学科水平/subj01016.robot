*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=allschool
Test Template     Down picture

*** Test Cases ***
subj01016飞鸟图下载功能验证
    Down picture
*** Keywords ***
Down picture
    [Arguments]  ${schoolname}
    ${time}    Get Current Date    result_format=timestamp
    Log To Console  开始时间${time}
    Run Keyword And Ignore Error    Empty Directory  D:\\workspace\\shrk_gj_subject_test\\downfile
    Subjopen01  ${schoolname}
    Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
    Wait Until Element Is Visible  xpath=//*[contains(@class,"group-g")]   timeout=10
    Mouse Over   xpath=//*[text()="雄鹰"]
    Wait Until Element Is Visible    xpath=//*[@class="special-download-btn"]
    Click Element  xpath=//*[@class="special-download-btn"]
    Sleep  2
    Check downfile  ${time}  png
    
