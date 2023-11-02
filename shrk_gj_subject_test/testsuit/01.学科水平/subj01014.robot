*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Checkball

*** Test Cases ***
subj01014飞鸟图学科球验证
    Checkball  
  
*** Keywords ***
Checkball
    [Arguments]  ${schoolname}
    Subjopen01  ${schoolname}
    Sleep  3
    #获取当前页面球的个数
    ${num}  Get Element Count   xpath=//*[contains(@class,"group-g")]
    ${i}   Set Variable  1   
    WHILE  ${i}<${num}
        ${code}  Get Text   xpath=//*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table/tbody/tr[${i}]/td[1]/div/span
        Log To Console  code${code}
        Checkballinfo   ${code}
        ${i}  Evaluate  ${i}+1
    END
  Sleep  2

Checkballinfo
  #1.若为默认状态，获取球的个数
  #球球的检测点：1.页面存在元素：使用专业代码作为标识
  #球的携带信息监测点：focus on 球元素：弹窗元素出现，检测元素里面
  [Arguments]  ${code}
  Mouse Down  xpath=//*[contains(@code,${code})]
  log to console  实际${code}
  Wait Until Element Is Visible   xpath=//*[@id="svg-modal"]
  ${list}  Get text   xpath=//*[@id="svg-modal"]
  ${list}  Replace String  ${list}  \n  ${SPACE}
  @{list}  Evaluate  $list.split()  
  Log To Console  ${list}
  ${type}  Evaluate  type($list)
  Log To Console  type${type}

  ${info1}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[1]
  ${info2}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[2]
  ${info3}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[3]
  ${info4}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[4]
  ${info5}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[6]
  ${info6}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[7]
  ${info7}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[8]
  ${info8}  Get Text  xpath=//*[@id="svg-modal"]/ul/li[9]

