*** Settings ***
Library  SeleniumLibrary
Resource   ../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../resources/testdata/学校样本.xlsx    sheet_name=allschool
# Test Template     Check chooseschool

*** Test Cases ***
subj01008“通知”功能-功能更新-详细更新跳转检测
   Login subjectplatform
   Subjchooseschool  北京师范大学

# *** Keywords ***
# Check chooseschool
#   [Arguments]  ${schoolname}
#   Login subjectplatform
#   Subjchooseschool  ${schoolname}
