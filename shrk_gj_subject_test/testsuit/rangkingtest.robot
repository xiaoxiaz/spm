*** Settings ***
Library  SeleniumLibrary  
Library  String
Library  DateTime
Library  OperatingSystem
Library  Collections
Library    DataDriver  D:/workspace/shrk_gj_subject_test/resources/testdata/arwu.xlsx    sheet_name=Sheet3
Test Setup   setup
Test Teardown   Close All Browsers
Test Template  datatest

*** Variables ***
${URL}  https://www.shanghairanking.cn/
${username}  xiaoxia.zhang
${password}  shanghai0531
#版本切换的xpath
# ${xpath}=   /html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[2]/div/span
#数据查询页面默认状态，“全部”与“综合”的statu
${dqexstatu1}  tab-item active
${dqexstatu2}    ant-tabs-tab ant-tabs-tab-active
#通知模块，激活状态
${noexstatu}   active
*** Test Cases ***
排名数据测试
   datatest

*** Keywords ***
setup
      Open Browser   ${URL}  chrome   
      Maximize Browser Window
      Click Element   xpath=//*[@id="__layout"]/div/div[2]/div[2]/div/div[1]/div[1]/div[2]/div[4]/div[1]
    #   Wait Until Element Is Enabled  xpath=//*[@id="content-box"]/ul/li[9]
      Sleep  5

datatest
  [Arguments]    ${ranking}  ${schoolname}   ${state}  ${rank}
   ${i}  Set Variable  1
   ${j}  Set Variable  1
   WHILE  ${j}<=2
       ${num}   Get Element Count  xpath=//*[contains(@class,"univ-logo")]
        WHILE  ${i}<=${num}
            Element Should Contain   xpath =//*[@id="content-box"]/div[2]/table/tbody/tr[${i}]/td[1]   ${ranking}
            Element Should Contain   xpath =//*[@id="content-box"]/div[2]/table/tbody/tr[${i}]/td[2]    ${schoolname}
            Element Should Contain   xpath =//*[@id="content-box"]/div[2]/table/tbody/tr[${i}]/td[3]    ${state}
            Element Should Contain   xpath =//*[@id="content-box"]/div[2]/table/tbody/tr[${i}]/td[5]    ${rank}  
            ${i}  Evaluate  ${i}+1
            # Element Should Contain   xpath =//*[@id="content-box"]/div[2]/table/tbody/tr[1]/td[6]  ${Score on Award}
            #    ${rangkingpage}  Get Table Cell  xpath=//*[@id="content-box"]/div[2]/table/tbody/tr[1]/td[1]/div  ${row}  1       
        END
        Click Element  xpath=//*[@id="content-box"]/ul/li[9]/a/i/svg
        ${j}  Evaluate  ${j}+1
        Sleep  0.5
   END

pagedeal
  [Arguments]  ${ranking}  ${schoolname}   ${state}  ${rank}
  ${page}  Evaluate   int(${ranking}/30)
  Log To Console  ${page}
  
  
 
   
  