*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check searchbox

*** Variables ***
${excepttext1}  搜索
${excepttext2}  请输入指标名称、项目、获奖、姓名等关键词，多关键词用空格隔开
${exceptimg}    \#icon-search
${excepttext2}  

*** Test Cases ***
subj01003搜索框样式验证
  Check searchbox

*** Keywords ***
Check searchbox
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  # 1.点击学科水平
  # 2.查看搜索框样式
  #搜索框内有搜索图标、展示默认提示语：搜索
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  #检测文本"搜索"
  Page Should Contain Element  xpath=//*[@id="app"]/section/header/div[3]/span[1]/input 
  ${text1}  Get Element Attribute   xpath=//*[@id="app"]/section/header/div[3]/span[1]/input   placeholder
  Should Be Equal As Strings   ${excepttext1}   ${text1}
  #检测搜索小图标
  Page Should Contain Element   css=#app > section > header > div.user > span.ant-input-affix-wrapper.ant-input-affix-wrapper-borderless.header-search > span.ant-input-prefix > svg > use
  ${img}   Get Element Attribute   css=#app > section > header > div.user > span.ant-input-affix-wrapper.ant-input-affix-wrapper-borderless.header-search > span.ant-input-prefix > svg > use    xlink:href
  Should Be Equal As Strings   ${exceptimg}   ${img}
  #检测搜索框样式
  ${class1}  Get Element Attribute   xpath=//*[@id="app"]/section/header/div[3]/span[1]/input  class
  Log To Console  点击前${class1}
  #点击搜索框
  Click Element   xpath=//*[@id="app"]/section/header/div[3]/span[1]/input
  Sleep  2
  #检测文本“请输入指标名称、项目、获奖、姓名等关键词，多关键词用空格隔开”
  ${text2}  Get Element Attribute  xpath=//*[@id="app"]/section/header/div[3]/span[1]/input   placeholder
  Log To Console  ${text2}
  Should Be Equal As Strings   ${excepttext2}    ${text2} 
  #检测搜索框样式
  ${class2}  Get Element Attribute  xpath=//*[@id="app"]/section/header/div[3]/span[1]/input  class
  #ant-input ant-input-borderless  不知道为什么网页上不一样，但是获取到的是一样的，class1和class2
  Log To Console  点击后${class2}
  

  




