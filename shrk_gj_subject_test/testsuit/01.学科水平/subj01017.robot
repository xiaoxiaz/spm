*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check picture

*** Test Cases ***
subj01017飞鸟图下载图片验证
    Check picture
*** Keywords ***
Check picture
    #

    
