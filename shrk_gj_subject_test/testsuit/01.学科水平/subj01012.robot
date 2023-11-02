*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Data export
*** Test Cases ***
subj01012数据导出功能验证
    Data export
*** Keywords ***
Data export
  [Arguments]  ${schoolname}
  ${time}   Get Current Date    result_format=timestamp
  #清空文件夹
   Run Keyword And Ignore Error    Empty Directory  D:\\workspace\\shrk_gj_subject_test\\downfile
  Subjopen01  ${schoolname}
  Element Should Contain   xpath=//*[@id="main-layout"]/div[1]/div[1]/span  学科水平
  Click Button  xpath=//*[@id="main-layout"]/div[1]/div[1]/div/button
  Sleep  3
  Check downfile   ${time}   xlsx   ${schoolname}-学术学位-学科水平
