*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check noticebox

*** Test Cases ***
subj01006通知—功能更新—模块名称蓝色链接跳转功能
  Check noticebox

*** Keywords ***
Check noticebox
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  #点击通知
  Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span  
  Wait Until Page Contains Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]
  #通知功能
  Check noticeui1
  ${res}   Run Keyword And Return Status   Page Should Contain   展无通知
  # Page Should Contain   学科演化功能更新
  # Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(1) > div > div
  IF  ${res}==False
     Sleep   2
     ${i}  Set Variable   1    
     ${res1}    Run Keyword And Return Status    Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div > div
     WHILE  ${res1}==True
       ${name}   Check ui1  ${i}
       #点击元素弹出子模块信息，包含功能更新 - name 已上线    功能介绍
       Click Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div > div
       Sleep  2
       Check ui2  ${i}  ${name}
       Check jump   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.module-ul > div > div > span:nth-child(1)   ${name}
       ${i}  Evaluate  ${i}+1
       ${res1}   Run Keyword And Return Status    Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div > div
     END
  END
  Sleep   3

Check jump
  [Arguments]      ${xpath}   ${text}
  ${text1}   Get Text   ${xpath}
  #一致性检查
  Should Be Equal As Strings    ${text}   ${text1}
  Click Element   ${xpath}
  Sleep  2
  Page Should Contain Element  xpath=//*[@id="main-layout"]/div[1]/div[1]/span
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  ${text1}
  Press Keys   None  ESC
  Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span  
  Wait Until Page Contains Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]
  Sleep  2

Check ui1
  [Arguments]   ${i}
  #检查new图标
  Page Should Contain Element  css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.total-view > div > div.title > svg > use
  #检查"xxxx功能更新"
  Element Should Contain  css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.total-view > div > div.title > span   功能更新
  ${name}  Get Text  css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.total-view > div > div.title > span
  ${name}   Remove String   ${name}    功能更新
  #检查“^""
  Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.total-view > div > div.time > svg > use
  #todo  检查时间，时间获取当前时间在一年范围内
  RETURN  ${name}


Check ui2
  [Arguments]  ${i}  ${name}
  Check ui1  ${i}
  #检查是否有功能介绍
  Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]/div/div/span[2]   功能介绍 
  #检查文本 功能更新 - name 已上线存在
  Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.module-ul > div > div > span:nth-child(1)
  Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]/div/div   功能更新 - ${name} 已上线
  

  
