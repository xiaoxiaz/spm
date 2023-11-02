*** Settings ***
Library  SeleniumLibrary
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Ballsizerule
*** Test Cases ***
subj01015学科球大小展示
    Ballsizerule
*** Keywords ***
Ballsizerule
  [Arguments]  ${schoolname}
  Subjopen01  ${schoolname}
  #先做判断，有无硕士点或者博士点
  #有两者的话，选择硕士点，获取大小，选择博士点获取大小，比较大小，没有就退出
  Choose subjlevel   博士点
  Sleep  2
  ${ballnum1}  Get Element Count   xpath=//*[contains(@class,"group-g")]
  IF  ${ballnum1}!=0
      ${size1}   Get Element Size  xpath=//*[contains(@class,"group-g")][1]
      Log To Console  博士点大小${size1}
  END
  Choose subjlevel   硕士点
  Sleep  2
  ${ballnum2}  Get Element Count   xpath=//*[contains(@class,"group-g")]
  IF  ${ballnum2}!=0
    ${size2}   Get Element Size  xpath=//*[contains(@class,"group-g")][1]
    Log To Console  硕士点大小${size2}
  END
  IF  ${ballnum1}!=0 and ${ballnum2} !=0
      ${res1}  Evaluate  ${size1[0]}<${size2[0]}
      ${res2}  Evaluate  ${size1[1]}>${size2[1]}
      ${res}   Evaluate  str(${res1} or ${res2})
      Should Be Equal As Strings   ${res}  True
  END
  
