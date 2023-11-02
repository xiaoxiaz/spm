*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Logout

*** Test Cases ***
subj01011退出登录
  Logout
*** Keywords ***
Logout
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  #鼠标悬浮在用户头像
  Mouse Over  xpath=//*[@id="app"]/section/header/div[3]/div[2]
  Wait Until Element Is Visible   css=body > div:nth-child(4) > div > div > div > ul > li > span
  #点击退出登录
  Click Element  css=body > div:nth-child(4) > div > div > div > ul > li > span
  Wait Until Element Is Visible  xpath=//*[@id="app"]/div/div[1]/div[1]/i
  ${url}  Get Location
  Should Be Equal As Strings   ${url}   https://pp-3f3ab907.gaojidata.com/#/login?logout=1
  Sleep  2
