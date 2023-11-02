*** Settings ***
Documentation  学科平台学科水平页面表格数据检测
Library   SeleniumLibrary
Library   String
Resource   ../../resources/keywordsdefine.robot
Library    DataDriver  ../../resources/testdata/${schoolname}.xlsx    sheet_name=版本${version}   
Test Setup   Setupstep  
Test Teardown   Close All Browsers
Test Template  Check subj01table
*** Variables ***
${schoolname}  清华大学
${version}   2023年04月
${yvalue}   软科学科排名
${rankmethod}  绝对排名
${subjstandard}  前25名 

*** Test Cases ***
subj0102_学科平台->学科水平->网页表格数据检测
   [Documentation]
   Check subj01table

*** Keywords ***
Setupstep
  # [Arguments]  ${schoolname}  ${version}  ${yvalue}  
  Subjopen01  ${schoolname}
  Subjchooseversion   ${version} 
  Choose and check xyvalue   软科学科排名  学科热度
  Sleep  3
  Choose rank rule   ${rankmethod}  ${subjstandard}
  Sleep  5
  #选择排名规则

Datadeal
  [Arguments]  ${data}
  ${dealdata1}  Remove String  ${data}  \n  ${SPACE}
#   Log To Console   数据处理前 ${dealdata1} 
  ${dealdata2}  Replace String  ${dealdata1}  ~  -
#   Log To Console   数据处理后 ${dealdata2} 
  RETURN   ${dealdata2}
  
Check subj01table
  [Arguments]  ${row}  ${subjcode}	${subjname}	 ${subjlevel}	${subjranking}  ${drpoint}  ${percentage}	 ${subjreview}	 ${subjheat}	 ${contribute}	 ${abs5}	 ${abs10}	${abs25}	${abs50}	${rel5%}	${rel10%}	 ${rel20%}	 ${rel30%}	 ${rel40%}  ${rel50%}
  &{value}  Create Dictionary  
  ...    前5名=${abs5}
  ...    前10名=${abs10}  
  ...    前25名=${abs25}
  ...    前50名=${abs50}  
  ...    前5%=${rel5%}  
  ...    前10%=${rel10%}  
  ...    前20%=${rel20%}  
  ...    前30%=${rel30%}  
  ...    前40%=${rel40%} 
  ...    前50%=${rel50%}
  
  #涉及到排名等，从网页获取到的数据会换行，对其进行处理
  ${value4} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  4
  ${value7} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  7
  ${value8} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  8
  ${value9} =    Get Table Cell  xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  9
  ${datadeal4}  datadeal  ${value4}
  ${datadeal7}  datadeal  ${value7}
  ${datadeal8}  datadeal  ${value8}
  ${datadeal9}  datadeal  ${value9} 
  Should Be Equal   ${datadeal4}   ${subjranking}
  Should Be Equal   ${datadeal7}   ${subjreview}
  Should Be Equal   ${datadeal8}   ${subjheat}
  Should Be Equal   ${datadeal9}   ${contribute}
  #检测不需要进行数据处理的数据
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  1  ${subjcode}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  2  ${subjname}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  3  ${subjlevel}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  5  ${drpoint}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  6  ${percentage}
  Table Cell Should Contain   xpath = //*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table  ${row}  10  ${value}[${subjstandard}]

  