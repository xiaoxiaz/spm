*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     

*** Test Cases ***
学科门类复选框选项与版本规则验证
  #切换版本->更改纵坐标


*** Keywords ***
Check all version
    #检测所有的版本
    
    