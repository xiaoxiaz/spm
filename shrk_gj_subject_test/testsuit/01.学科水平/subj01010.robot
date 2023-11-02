*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Check helpinfo

*** Test Cases ***
subj01010帮助功能
  Check helpinfo
*** Keywords ***
Check helpinfo
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  #获取当前页面是哪个页面
  ${pagename}   Get Text   xpath=//*[@id="main-layout"]/div[1]/div[1]/span
  #点击右上角“帮助”
  Click Element   xpath=//*[@id="app"]/section/header/div[3]/span[2]
  ${window}  Get Window Handles
  Switch Window  ${window[-1]}
  Wait Until Element Is Visible   xpath=//*[@id="app"]/div[1]/aside/ul/li[1]/section/ul/li[1]/a
#   ${attribute}  Get Element Attribute   xpath=//*[@id="app"]/div[1]/aside/ul/li[1]/section/ul/li[1]/a   class
#   Log To Console  ${attribute}
  Check element status  xpath=//*[@id="app"]/div[1]/aside/ul/li[1]/section/ul/li[1]/a   class  active sidebar-link
  Element Should Contain  xpath=//*[@id="app"]/div[1]/aside/ul/li[1]/section/ul/li[1]   ${pagename}
  Element Should Contain  xpath=//*[@id="学科水平"]   ${pagename}
  Sleep  2





  
