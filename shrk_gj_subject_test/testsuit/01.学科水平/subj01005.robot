*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=allschool
Test Template     Check noticebox

*** Test Cases ***
subj01005通知功能-功能更新默认ui与切换功能检测
  Check noticebox

*** Keywords ***
Check noticebox
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span  
  Wait Until Page Contains Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]
  #点击功能更新，ui检测
  Check noticeui1
  #点击指标更新，ui检测
  Check noticeui2
  #点击功能更新，ui检测
  Check noticeui1

  
