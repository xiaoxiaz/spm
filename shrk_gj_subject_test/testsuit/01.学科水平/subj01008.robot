*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check noticebox

*** Test Cases ***
subj01008通知—指标更新—蓝色链接跳转功能
  Check noticebox
*** Keywords ***
Check noticebox
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span  
  Wait Until Page Contains Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]
  #通知功能
  Check noticeui2
  ${res}   Run Keyword And Return Status   Page Should Contain   展无通知
  IF  ${res}==False
     Sleep   2
     ${i}  Set Variable   1    
     ${res1}    Run Keyword And Return Status    Page Should Contain Element   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div/div/div[1]/span[1]
     WHILE  ${res1}==True  limit=999
       Check ui1  ${i}
       ${i}  Evaluate  ${i}+1
       Log To Console  ${i}
       ${res1}   Run Keyword And Return Status    Page Should Contain Element   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div/div/div[1]/span[1]  
     END
  END
  Sleep   5

Check ui1
  [Arguments]   ${i}
  #检查“新”字样
  Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div/div/div[1]/span[1]
  Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div/div/div[1]/span[1]  新
  #检查"xxxx更新了一个指标"
  Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div/div/div[1]/span[3]
  Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div/div/div[1]/span[3]   更新了1个指标
  #检查“^""
  Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.total-view > div > div.time > svg > use
  #todo  检查时间，时间获取当前时间在一年范围内

  #点击元素弹出子模块信息，包含模块/维度
  Click Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]
  Sleep  2
  Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[1]
  Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]
  Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]  模块
  Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]  维度
  Press Keys  None  ESC
  Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span  




  
