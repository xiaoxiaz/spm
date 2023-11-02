*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check searchbox

*** Test Cases ***
subj01004搜索框功能
  Check searchbox

*** Keywords ***
Check searchbox
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  Check dataquery

  

  

