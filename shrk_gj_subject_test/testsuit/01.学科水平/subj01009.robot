*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check noticeread

*** Test Cases ***
subj01009通知功能-一键已读功能验证
  Check noticeread
*** Keywords ***
Check noticeread
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  #判断是否有通知红点
  ${statu}  Run Keyword And Return Status  Page Should Contain Element  xpath=//*[@data-show="true"]
  Log To Console    ${statu} 
  ${number}  Get Text   css=#app > section > header > div.user > div.notice > span
  ${number}  Remove String  ${number}  通知
  Log To Console  ${number}
  IF  ${statu}==True
      #检查通知红点数字和通知页包含红点的子项个数是否相等
      Check numbers  ${number}
      #点击一键已读
      Click Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[2]
      Press Keys  None   ESC
      Sleep  2
      Page Should Not Contain  xpath=//*[@data-show="true"]
      Check numbers  0
  ELSE
      Log To Console  该用户无新消息
      Check numbers  0
  END
  Sleep  2

Check numbers
  [Arguments]  ${sum}
  Page Should Contain Element  css=#app > section > header > div.user > div.notice > span > span
  Wait until element is visible  css=#app > section > header > div.user > div.notice > span > span
  Click Element   css=#app > section > header > div.user > div.notice > span > span
  Sleep  1
  Click Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]
  Sleep  1
  ${number1}  Get Element Count   xpath=//*[class,"circle fun-circle")]
  Log To Console  圆圈的个数为${number1}
  Click Element   xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
  Sleep  2
  ${number2}  Get Element Count  xpath=//*[contains(@class,"circle")]
  Log To Console  ${number2}
  ${res}  Evaluate  ${number1}+${number2}
  Should Be Equal As Integers  ${res}  ${sum}




  
