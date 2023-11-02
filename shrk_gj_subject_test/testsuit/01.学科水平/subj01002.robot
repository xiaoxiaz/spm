*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template   Check Dropdownbox

*** Variables ***
${expectup}  down-icon active
${expectdown}  down-icon

*** Test Cases ***
subj01002查看下拉选框“^”朝向
  Check Dropdownbox

*** Keywords ***
Check Dropdownbox
  [Arguments]  ${row}  ${schoolname}
  Subjopen01  ${schoolname}
  #1.点击学科水平(检查当前所处界面为学科水平)
  #检查左边导航栏和顶部文字
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  #2.点击日期下拉框
  Click Element  xpath=//*[@id="header-version"]/div/div/span[2]/span
  ${classup}  Get Element Attribute  xpath=//*[@id="header-version"]/div/span/span  class
  Should Be Equal As Strings  ${classup}  ${expectup}
  #3.再次点击日期下拉框
  Click Element  xpath=//*[@id="header-version"]/div/div/span[2]/span
  ${classdown}  Get Element Attribute  xpath=//*[@id="header-version"]/div/span/span  class
  Should Be Equal As Strings  ${classdown}  ${expectdown}



