*** Settings ***
Documentation  学科平台学科水平页面表格数据检测
Library   SeleniumLibrary
Library   String
Resource   ../../resources/keywordsdefine.robot
#sheet_name 如果是字符串类型以字母开头，数字开头好像会识别为int型，会识别不出来
Library    DataDriver  ../../resources/testdata/清华大学.xlsx    sheet_name=版本2023年04月
Test Setup   Setupstep  
Test Teardown   Close All Browsers
Test Template  Check subj01table

*** Variables ***
${schoolname}  清华大学
${version}   2023年04月 
*** Test Cases ***
subj01001版本切换功能
   Check subj01table
*** Keywords ***
Setupstep
  Subjopen01  ${schoolname}
  Subjchooseversion   ${version} 
  Sleep  5
  Element Should Contain  xpath=//*[@id="header-version"]/div   ${version}

Datadeal
  [Arguments]  ${data}
  ${dealdata1}  Remove String  ${data}  \n
#   Log To Console   数据处理前 ${dealdata1} 
  ${dealdata2}  Replace String  ${dealdata1}  ~  -
#   Log To Console   数据处理后 ${dealdata2} 
  RETURN   ${dealdata2}
  
Check subj01table
  [Arguments]  ${row}  ${subjcode}	${subjname}	 ${subjlevel}	${subjranking}	${percentage}	${subjreview}	${subjheat}	${contribute}	${abs5}	${abs10}	${abs25}	${abs50}	${rel5%}	${rel10%}	${rel20%}	${rel30%}	${rel40%}	${rel50%}


  #涉及到排名等，从网页获取到的数据会换行，对其进行处理
  ${value4} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  4
  ${value6} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  6
  ${value7} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  7
  ${value8} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  8
  ${datadeal4}  datadeal  ${value4}
  ${datadeal6}  datadeal  ${value6}
  ${datadeal7}  datadeal  ${value7}
  ${datadeal8}  datadeal  ${value8} 
  Should Be Equal   ${datadeal4}   ${subjranking}
  Should Be Equal   ${datadeal6}   ${subjreview}
  Should Be Equal   ${datadeal7}   ${subjheat}
  Should Be Equal   ${datadeal8}   ${contribute}
  #检测不需要进行数据处理的数据
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  1  ${subjcode}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  2  ${subjname}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  3  ${subjlevel}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  5  ${percentage}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  9  ${orientation5}


  