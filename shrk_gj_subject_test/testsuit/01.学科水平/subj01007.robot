*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check noticebox

*** Test Cases ***
subj01007通知—功能更新—功能介绍功能
  Check noticebox

*** Keywords ***
Check noticebox
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span  
  Wait Until Page Contains Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]
  #1.点开通知，检查默认ui
  Check noticeui1
  ${res}   Run Keyword And Return Status   Page Should Contain   展无通知
  IF  ${res}==False
     Sleep   1
     ${i}  Set Variable   1    
     ${res1}    Run Keyword And Return Status    Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div > div
     WHILE  ${res1}==True   
       ${name}   Check ui1  ${i}
       #2.点开详细内容，检查ui一致性
       Click Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div > div
       Sleep  1
       Check ui2  ${i}  ${name}
       #3.点击立即体验，ui检查
       Click Element  css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.module-ul > div > div > span:nth-child(2)
       Sleep  1
       Check ui3  ${name}
       # 4.点击立即体验并跳转
       Click Element  css=body > div:nth-child(5) > div > div.ant-modal-wrap > div > div.ant-modal-content > div > div.notice-modal-foot > div
       Page Should Contain Element   xpath=//*[@id="main-layout"]/div[1]/div[1]/span
       Element Should Contain  xpath=//*[@id="main-layout"]/div[1]/div[1]/span  ${name}
       Click Element  xpath=//*[@id="app"]/section/header/div[3]/div[1]/span/span
       Sleep  1 
      #  Check jump   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.module-ul > div > div > span:nth-child(1)   ${name}
       ${i}  Evaluate  ${i}+1
       ${res1}   Run Keyword And Return Status    Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div > div
     END
  END
  Sleep  2

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
  #点击关闭立即体验页面，页面仍处于学科水平页面，且通知页面处于展开状态，详细内容收起。
  Sleep  2

#检查new行
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

#检查新行
Check ui2
  [Arguments]  ${i}  ${name}
  Check ui1  ${i}
  #检查是否有功能介绍
  Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]/div/div/span[2]   功能介绍 
  #检查文本 功能更新 - name 已上线存在
  Page Should Contain Element   css=body > div:nth-child(4) > div > div.ant-drawer-content-wrapper > div > div > div.ant-drawer-body > div > div:nth-child(${i}) > div.module-ul > div > div > span:nth-child(1)
  Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div[${i}]/div[2]/div/div   功能更新 - ${name} 已上线

#检查立即体验弹窗ui
Check ui3
  [Arguments]  ${text}
  #检查功能更新
  Page Should Contain Element  xpath=/html/body/div[4]/div/div[2]/div/div[2]/div/div[1]/h1
  ${i}  Get Text  xpath=/html/body/div[4]/div/div[2]/div/div[2]/div/div[1]/h1
  Log To Console  ${i}
  Element Should Contain  xpath=/html/body/div[4]/div/div[2]/div/div[2]/div/div[1]/h1  功能更新
  #检查文本一致
  Page Should Contain Element  xpath=/html/body/div[4]/div/div[2]/div/div[2]/div/div[1]/div[1]
  Element Should Contain  xpath=/html/body/div[4]/div/div[2]/div/div[2]/div/div[1]/div[1]  ${text}
  #检查'X'
  Page Should Contain Element  xpath=/html/body/div[4]/div/div[2]/div/div[2]/button/span/span
  #检查'立即体验'button
  Page Should Contain Element  css=body > div:nth-child(5) > div > div.ant-modal-wrap > div > div.ant-modal-content > div > div.notice-modal-foot > div
  Element Should Contain  css=body > div:nth-child(5) > div > div.ant-modal-wrap > div > div.ant-modal-content > div > div.notice-modal-foot > div  立即体验

  
