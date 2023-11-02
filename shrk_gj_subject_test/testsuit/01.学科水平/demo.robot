*** Settings ***
Documentation  学科平台学科水平页面表格数据检测
Library   SeleniumLibrary
Library   String
Library  OperatingSystem
Library  Collections
Resource   ../resources/keywordsdefine.robot

*** Variables ***
${schoolname}   清华大学
# &{standarddict2}   
# ...    A+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[1]  
# ...    A=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[2]  
# ...    A-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[3]  
# ...    B+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[1]  
# ...    B=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[2]  
# ...    B-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[3]  
# ...    C+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[1]  
# ...    C=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[2]  
# ...    C-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[3]
*** Test Cases ***
1.调试过程
  # &{relativedict}  Create Dictionary   前5%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]  
  #   ...    前10%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]  
  #   ...    前20%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
  #   ...    前30%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]  
  #   ...    前40%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[5]  
  #   ...    前50%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[6]
  # Log To Console  ${relativedict}
  # Remove From Dictionary  ${relativedict}  前5%
  # Log To Console  ${relativedict}
   
  Subjopen01  ${schoolname}
  Choose rank rule  绝对排名  前5名
#   Sleep  4
#   Page Should Contain Element  css=#y-axis-group > text:nth-child(157)
  Check xy axis ui  学科热度  软科学科排名   绝对排名  前5名  73
  Choose rank rule  相对排名  前30%
  Sleep  3
  Check xy axis ui  学科热度  软科学科排名   相对排名  前30%
#   ${num}  Get Element Count  xpath=//*[contains(@class,"vxe-body--column col_5 col--center body-cell")]
#   ${i}  Set Variable  1
#   @{valuelist}  Create List
#   WHILE  ${i}<${num}
#     ${value}  Get Text  xpath=//*[@id="main-container"]/div[1]/div[2]/div/div[1]/div[2]/div[2]/div[1]/div[2]/table/tbody/tr[${i}]/td[4]/div/div/span  
#     ${value}  Replace String  ${value}  \n  -  
#     ${value}  Convert To String  ${value}
#     ${value}  Evaluate  ${value.split('-')}[0]
#     Append To List  ${valuelist}  ${value}  
#     ${i}  Evaluate  ${i}+1
#   END
#   Log To Console  list${valuelist}
#   ${valuemax}  Evaluate  sorted(${valuelist})[-1]
#   Log To Console  ${valuemax}
#   IF  ${valuemax}>150
#     ${valuemax}  Evaluate  150
#   END

  
  
  # ${count}   Get Element Count  xpath=//*[contains(@x1,"80")]
#   Check element text  xpath=//*[@id="y-axis-group"]/text[1]  1
#           Check element text  xpath=//*[@id="y-axis-group"]/text[3]  5
#           Check element text  xpath=//*[@id="y-axis-group"]/text[4]  25
#           Check element text  xpath=//*[@id="y-axis-group"]/text[5]  50
#           Check element text  xpath=//*[@id="y-axis-group"]/text[6]  150

  # Log To Console  ${count}
  # Page Should Contain Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]/span[1]/input
  # Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]/div[1]/span[1]
  # Page Should Contain Element   xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]/div[1]/span[1]
  # Sleep  2
  # Choose and check xyvalue   学科贡献  第四轮学科评估
  # Sleep  2
  # Clear subjlevel part2 
  # Sleep  5
  # Test1
  # Test2
  # Log To Console  ${standarddict2}

  
*** Keywords ***
# Test1
#     &{dict}  Create Dictionary
#     ${dict}  Remove From Dictionary  ${standarddict2}  B+
#     Log To Console  删除B+${dict}\/n
#     Log To Console  删除B+${standarddict2}\/n
# Test2
#     Remove From Dictionary  ${standarddict2}  C
#     Log To Console  删除C${standarddict2}
Check element status and return
  [Arguments]  ${element}  ${attribute}  ${exceptstatus}   ${text}=None
  Page Should Contain Element  ${element}
  IF  '${text}'!='None'
      ${res1}  Run Keyword And Return Status  Element Should Contain  ${element}  ${text}
  ELSE
      ${res1}  Set Variable  True
  END
  ${status}  Get Element Attribute  ${element}  ${attribute}
  ${res2}  Run Keyword And Return Status  Should Be Equal As Strings  ${status}  ${exceptstatus}
  ${res}  Evaluate  ${res1} and ${res2}
  Log To Console  res:${res}
  RETURN  ${res}

Check element status
  [Arguments]  ${element}  ${attribute}  ${exceptstatus}   ${text}=None
  Page Should Contain Element  ${element}
  IF  '${text}'!='None'
      Element Should Contain  ${element}  ${text}     
  END
  ${status}  Get Element Attribute  ${element}  ${attribute}
  Should Be Equal As Strings  ${status}  ${exceptstatus}

Check element text
    [Arguments]  ${path}  ${text}
    Page Should Contain Element  ${path}
    Element Should Contain   ${path}  ${text}
#选择排名规则
Choose rank rule
  [Arguments]  ${rankmethod}  ${standard}  
  #选择排名方式
  IF  '${rankmethod}'=='绝对排名'
      Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]/span[1]/input
      Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]/span[1]/input
      #选择优势学科标准
      IF  '${standard}'=='前5名'
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]/span[1]/input
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]/span[1]/input
      ELSE IF  '${standard}'=='前10名'
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]/span[1]/input
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]/span[1]/input
      ELSE IF  '${standard}'=='前25名'
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]/span[1]/input
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]/span[1]/input
      ELSE IF  '${standard}'=='前50名'
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]/span[1]/input
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]/span[1]/input
      END
   ELSE IF  '${rankmethod}'=='相对排名'
      Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]/span[1]/input
      Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]/span[1]/input
      #选择优势学科标准
      IF  '${standard}'=='前5%'
          Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]/span[1]/input
          Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]/span[1]/input
      ELSE IF  '${standard}'=='前10%'
          Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]/span[1]/input
          Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]/span[1]/input
      ELSE IF  '${standard}'=='前20%'
          Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]/span[1]/input
          Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]/span[1]/input
      ELSE IF  '${standard}'=='前30%'
          Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]/span[1]/input
          Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]/span[1]/input
      ELSE IF  '${standard}'=='前40%'
          Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[5]/span[1]/input
          Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[5]/span[1]/input
      ELSE IF  '${standard}'=='前50%'
          Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[6]/span[1]/input
          Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[6]/span[1]/input
      END
  END

#选择学科门类 
Choose subj
   [Arguments]  @{subj}
   #去重
   ${subj}  Remove Duplicates  ${subj}
   #清空选择
   Clear subjchoose
   &{subjdict}  Create Dictionary   人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[1]/label/span[1]/input
   ...  哲学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]/div[1]/span[1]
   ...  文学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]/div[2]/span[1]
   ...  历史学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]/div[3]/span[1]
   ...  艺术学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]/div[4]/span[1]
   ...  社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[1]/label/span[1]/input
   ...  经济学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[2]/div[1]/span[1]
   ...  法学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[2]/div[2]/span[1]
   ...  教育学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[2]/div[3]/span[1]
   ...  管理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[2]/div[4]/span[1]
   ...  理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[1]/label/span[1]/input
   ...  理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[2]/div[1]/span[1]
   ...  工学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[2]/div[2]/span[1]
   ...  农学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[2]/div[3]/span[1]
   ...  医学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[2]/div[4]/span[1]
   ...  交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[1]/label/span[1]/input
   ...  交叉学科1=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[2]/div/span[1]
    ${lenth}  Evaluate  len(${subj})
    ${i}  Set Variable  0
    WHILE   ${i}<${lenth}
        Wait Until Element Is Enabled  ${subjdict.${subj[${i}]}}
        Click Element  ${subjdict.${subj[${i}]}}
        ${i}   Evaluate  ${i}+1
    END

#清空学科门类选择
Clear subjchoose
   &{allstatusdict}  Create Dictionary  
   ...    人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[1]/label  
   ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[1]/label 
   ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[1]/label 
   ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[1]/label
   ${notallstatusdict}  Create Dictionary  
   ...    人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[1]/label/span[1]   
   ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[1]/label/span[1] 
   ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[1]/label/span[1]  
   ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[1]/label/span[1]
   @{subjlist}  Create List  人文艺术  社会科学  理工农医  交叉学科
   ${i}  Set Variable  0
   WHILE   ${i}<4
      #检查是否被全部选中
      ${allres}    Check element status and return  ${allstatusdict.${subjlist[${i}]}}   class   ant-checkbox-wrapper ant-checkbox-wrapper-checked
      #是否单个被选中
      ${notallres}    Check element status and return  ${notallstatusdict.${subjlist[${i}]}}  class  ant-checkbox ant-checkbox-indeterminate
      IF  ${allres}==True
          Wait Until Element Is Enabled  ${notallstatusdict.${subjlist[${i}]}}
          Click Element  ${notallstatusdict.${subjlist[${i}]}}
      ELSE
        IF  ${notallres}==True
            Wait Until Element Is Enabled  ${notallstatusdict.${subjlist[${i}]}}
            Click Element  ${notallstatusdict.${subjlist[${i}]}}
            Wait Until Element Is Enabled  ${notallstatusdict.${subjlist[${i}]}}
            Click Element  ${notallstatusdict.${subjlist[${i}]}}
         ELSE
           Log To Console  该学科已处于未选状态     
        END
      END
      ${i}  Evaluate  ${i}+1
   END

#选择学科层次点
Choose subjlevel
  [Arguments]  @{chooselevel}
  &{leveldict}  Create Dictionary   博士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[1]  硕士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[2]  虚拟点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]  
#   #判断虚拟点是否存在
  #清空选择
  Clear subjlevel
  #去重
  ${chooselevel}  Remove Duplicates  ${chooselevel}
#   &{subjlevel}   Create Dictionary   博士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[1]  硕士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[2]  虚拟点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]  
#   #判断虚拟点是否存在
  ${virtualres}  Run Keyword And Return Status  Page Should Contain Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]
  ${lenth}  Evaluate  len(${chooselevel})
  ${i}  Set Variable  0
  WHILE   ${i}<${lenth}
      Wait Until Element Is Enabled  ${leveldict.${chooselevel[${i}]}}
      Click Element  ${leveldict.${chooselevel[${i}]}}
      ${i}   Evaluate  ${i}+1
   END
#清除选择的学科层次点
Clear subjlevel
  ${virtualres}  Run Keyword And Return Status  Page Should Contain Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]
  Sleep  2
  IF  ${virtualres}==True
      ${chooseres}  Check element status and return  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]  class  level-check-item active
      IF  ${chooseres}==True
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]
     END
   END
   ${chooseres1}  Check element status and return  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[1]  class  level-check-item active
   ${chooseres2}  Check element status and return  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[2]  class  level-check-item active
   IF  ${chooseres1}==True
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[1]
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[1]  
   END
   IF  ${chooseres2}==True
         Wait Until Element Is Enabled  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[2] 
         Click Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[2] 
   END

#检查排名方法
Check rank method
  [Arguments]  ${rankmethod}=None  
  IF  '${rankmethod}'=='None' or '${rankmethod}'=='绝对排名'
      #检查'绝对排名'被选中
      Check element status  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]  class  ant-radio-wrapper ant-radio-wrapper-checked
      #检查'相对排名'没被选中
      Check element status  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]  class  ant-radio-wrapper 
   ELSE IF   '${rankmethod}'=='相对排名' 
        #检查'绝对排名'没被选中
        Check element status  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]  class  ant-radio-wrapper
        #检查'相对排名'被选中
        Check element status  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]  class  ant-radio-wrapper ant-radio-wrapper-checked
   END
   #检查'排名方式：字样
   Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/span  排名方式：
   #检查'绝对排名'
   Page Should Contain Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]/span[1]/input
   Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]/span[2]  绝对排名
   #检查'相对排名'
   Page Should Contain Element  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]/span[1]/input
   Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]/span[2]  相对排名 

#检查优势学科标准
Check subjstandard
    [Arguments]  ${standard}=None
    #1.判断排名方式，再进分支
    &{absolutedict}  Create Dictionary  
    ...    前5名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]  
    ...    前10名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]  
    ...    前25名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
    ...    前50名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4] 
    &{relativedict}  Create Dictionary  
    ...    前5%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]  
    ...    前10%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]  
    ...    前20%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
    ...    前30%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]  
    ...    前40%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[5]  
    ...    前50%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[6]
    ${i}  Set Variable  0  
    ${menthodres}  Check element status and return  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]  class  ant-radio-wrapper ant-radio-wrapper-checked
    #绝对排名下优势学科标准
    IF  ${menthodres}==True
        #不做选择
        IF  '${standard}'=='None'
            ${valuelist}  Get Dictionary Values  ${absolutedict}
            ${len}  Get Length  ${valuelist}
            ${reslist}  Create List
            WHILE  ${i}<${len}
                ${res}  Check element status and return  ${valuelist[${i}]}  class  ant-radio-wrapper ant-radio-wrapper-checked
                ${res}  Convert To String  ${res}
                ${res}  Remove String  ${res}  ${SPACE}
                Append To List  ${reslist}  ${res}
                ${i}  Evaluate  ${i}+1
            END
            ${exceptres}   Count Values In List  ${reslist}  True
            Should Be Equal As Integers  ${exceptres}  1  
        ELSE
        #做选择,检查被选中的选项状态
            Check element status   ${absolutedict.${standard}}  class   ant-radio-wrapper ant-radio-wrapper-checked  ${standard}
            Remove From Dictionary  ${absolutedict}  ${standard}
            ${keylist}  Get Dictionary Keys  ${absolutedict}
            ${len}  Evaluate  len(${keylist})
            WHILE   ${i}<${len}
                ${key}  Set Variable  ${keylist[${i}]}  
                Check element status  ${absolutedict}[${key}]  class  ant-radio-wrapper  ${key}
                ${i}  Evaluate  ${i}+1
            END   
        END
    #绝对排名下优势学科部标准
    ELSE
        IF  '${standard}'=='None'
            ${valuelist}  Get Dictionary Values  ${relativedict}
            ${len}  Get Length  ${valuelist}
            ${reslist}  Create List
            WHILE  ${i}<${len}
                ${res}  Check element status and return  ${valuelist[${i}]}  class  ant-radio-wrapper ant-radio-wrapper-checked
                ${res}  Convert To String  ${res}
                ${res}  Remove String  ${res}  ${SPACE}
                Append To List  ${reslist}  ${res}
                ${i}  Evaluate  ${i}+1
            END
            ${exceptres}   Count Values In List  ${reslist}  True
            Should Be Equal As Integers  ${exceptres}  1  
        ELSE
        #做选择,检查被选中的选项状态
            Check element status   ${relativedict}[${standard}]   class    ant-radio-wrapper ant-radio-wrapper-checked
            Log To Console  test ${relativedict}[${standard}]
            Remove From Dictionary   ${relativedict}    ${standard}
           
            Log To Console  ${relativedict}
            ${valuelist}  Get Dictionary Values  ${relativedict}
            Log To Console  ${valuelist}
            ${len}  Evaluate  len(${valuelist})
            WHILE   ${i}<${len}
                ${res}  Check element status  ${valuelist[${i}]}  class  ant-radio-wrapper
                ${i}  Evaluate  ${i}+1
            END   
        END
    END    
    Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/span  优势学科标准：

Choose standard part2
    [Arguments]  ${standard}
    &{standarddict2}  Create Dictionary  
    ...    A+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[1]  
    ...    A=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[2]  
    ...    A-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[3]  
    ...    B+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[1]  
    ...    B=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[2]  
    ...    B-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[3]  
    ...    C+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[1]  
    ...    C=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[2]  
    ...    C-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[3]
    Wait Until Element Is Enabled  ${standarddict2}[${standard}]
    Click Element  ${standarddict2}[${standard}]

Check subjstandard part2
    [Arguments]  ${standard}=None
    &{standarddict2}   Create Dictionary
...    A+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[1]  
...    A=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[2]  
...    A-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[3]  
...    B+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[1]  
...    B=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[2]  
...    B-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[3]  
...    C+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[1]  
...    C=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[2]  
...    C-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[3]
    Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/span  优势学科标准：  
    ${keylist}  Get Dictionary Keys  ${standarddict2}
    ${listlen}  Evaluate  len(${keylist})
    ${i}  Set Variable  0
    @{reslist}  Create List
    #检查默认状态
    IF  '${standard}'=='None'
        WHILE  ${i}<${listlen}
            #检查元素存在仅仅有一个元素被选中
            ${res}  Check element status and return  ${standarddict2}[${keylist[${i}]}]   class   ant-radio-wrapper ant-radio-wrapper-checked  ${keylist[${i}]}
            # Log To Console  ${standarddict2}[${keylist[${i}]}]
            ${res}  Convert To String  ${res}
            ${res}  Remove String  ${res}  ${SPACE}
            Append To List  ${reslist}  ${res}
            ${i}  Evaluate  ${i}+1
        END
        Log To Console  ${reslist} 
        ${trueres}  Count Values In List  ${reslist}  True
        Should Be Equal As Integers  ${trueres}  1 
    ELSE
        #检查选中的元素
        Check element status  ${standarddict2}[${standard}]  class  ant-radio-wrapper ant-radio-wrapper-checked  ${standard}
        Remove From Dictionary  ${standarddict2}  ${standard}  
        @{keylist}  Get Dictionary Keys  ${standarddict2}
        ${len}  Get Length  ${keylist}
        WHILE  ${i}<${len}
            Log To Console  ${i}
            ${key}  Set Variable  ${keylist[${i}]}
            Check element status  ${standarddict2}[${key}]  class  ant-radio-wrapper  ${key}
            ${i}  Evaluate  ${i}+1     
        END
    END
Choose subj part2
  [Arguments]  @{subj}
  #todo  需要做 门类和以下包含的判断
  #去重
  ${subj}  Remove Duplicates  ${subj}
  #清空选择，存在逻辑//进行选择，判断是否为选中状态/然后再做选择/有空做优化/目前每次选择之前会清空选择，不方便顺序执行
  Clear subjchoose part2
  &{subjdict}  Create Dictionary  人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[1]/label
   ...  哲学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[2]/div[1]
   ...  文学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[2]/div[2]
   ...  历史学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[2]/div[3]
   ...  艺术学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[2]/div[4]
   ...  社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[1]/label
   ...  经济学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[2]/div[1]
   ...  法学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[2]/div[2]
   ...  教育学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[2]/div[3]
   ...  管理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[2]/div[4]
   ...  理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[1]/label
   ...  理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[2]/div[1]
   ...  工学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[2]/div[2]
   ...  农学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[2]/div[3]
   ...  医学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[2]/div[4]
   ...  交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[1]/label
   ...  交叉学科1=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[2]/div
  ${lenth}  Evaluate  len(${subj})
  ${i}  Set Variable  0
  WHILE   ${i}<${lenth}
      Wait Until Element Is Enabled  ${subjdict.${subj[${i}]}}
      Click Element  ${subjdict.${subj[${i}]}}
      ${i}   Evaluate  ${i}+1
  END
Clear subjchoose part2
    #区分全部选中状态以及其他
    &{alldict}  Create Dictionary  人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[1]/label  
    ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[1]/label  
    ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[1]/label  
    ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[1]/label
    #区分是否选中但并非全部选中状态和未选中状态
    &{notalldict}  Create Dictionary   人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[1]/label/span[1]  
    ...    社会学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[1]/label/span[1]     
    ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[1]/label/span[1]  
    ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[1]/label/span[1]
    @{subjlist}  Get Dictionary Keys  ${alldict}
    ${len}  Evaluate  len(${subjlist})
    ${i}  Set Variable  0
    WHILE   ${i}<${len}
        #检查是否被全部选中
        ${allres}    Check element status and return  ${alldict.${subjlist[${i}]}}   class   ant-checkbox-wrapper ant-checkbox-wrapper-checked
        #是否非全部被选中
        ${notallres}    Check element status and return  ${notalldict.${subjlist[${i}]}}  class  ant-checkbox ant-checkbox-indeterminate
        #如果全部选中，则点击一次
        IF  ${allres}==True
            Wait Until Element Is Enabled  ${alldict.${subjlist[${i}]}}
            Click Element  ${alldict.${subjlist[${i}]}}
        ELSE
          #非全部选中，则点击两次
          IF  ${notallres}==True
              Wait Until Element Is Enabled  ${alldict.${subjlist[${i}]}}
              Click Element  ${alldict.${subjlist[${i}]}}
              Wait Until Element Is Enabled  ${alldict.${subjlist[${i}]}}
              Click Element  ${alldict.${subjlist[${i}]}}
          ELSE
            Log To Console  该学科已处于未选状态     
          END
        END
        ${i}  Evaluate  ${i}+1
    END
  
Choose subjlevel part2
    [Arguments]  @{chooselevel}
    #清空选择
    Clear subjlevel part2
    &{leveldict}  Create Dictionary   
    ...    博士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[1]  
    ...    硕士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[2]  
    ...    虚拟点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[3]  
    #去重
    ${chooselevel}  Remove Duplicates  ${chooselevel}
    #判断虚拟点是否存在
    ${virtualres}  Run Keyword And Return Status  Page Should Contain Element  ${leveldict}[虚拟点]
    ${lenth}  Evaluate  len(${chooselevel})
    ${i}  Set Variable  0
    WHILE   ${i}<${lenth}
        Wait Until Element Is Enabled  ${leveldict.${chooselevel[${i}]}}
        Click Element  ${leveldict.${chooselevel[${i}]}}
        ${i}   Evaluate  ${i}+1
    END
Clear subjlevel part2 
    &{leveldict}  Create Dictionary   
    ...    博士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[1]  
    ...    硕士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[2]  
    ...    虚拟点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[3]  
    # ${virtualres}  Run Keyword And Return Status  Page Should Contain Element   ${leveldict}[虚拟点]
    ${pathlist}  Get Dictionary Values  ${leveldict}
    Log To Console  ${pathlist}
    ${len}  Evaluate  len(${pathlist})
    ${i}  Set Variable  0
    WHILE  ${i}<${len}
        ${res}  Run Keyword And Return Status  Page Should Contain Element   ${pathlist[${i}]}
        Log To Console  ${res}
        Log To Console  ${pathlist[${i}]}
        IF  ${res}==True
            ${statures}  Check element status and return   ${pathlist[${i}]}  class  level-check-item active
            IF  ${statures}==True
                Wait Until Element Is Enabled  ${pathlist[${i}]}
                Click Element  ${pathlist[${i}]}          
            END
        END
    ${i}  Evaluate  ${i}+1
    END



Choose and check xyvalue
    [Arguments]   ${xvalue}=None  ${yvalue}=None
    &{xyvaluedict}  Create Dictionary   
    ...    软科学科排名=xpath=//*[@id="container"]/div[1]/div[1]   
    ...    第四轮学科评估=xpath=//*[@id="container"]/div[1]/div[2]   
    ...    学科热度=xpath=//*[@id="container"]/div[2]/div[2]   
    ...    学科贡献=xpath=//*[@id="container"]/div[2]/div[1]
    #检查横坐标'尖角'
    Check element status  css=#container > div.text-Y > svg > use  xlink:href  \#icon-toRight
    #检查纵坐标'尖角'
    Check element status  css=#container > div.text-X > svg > use   xlink:href  \#icon-toRight
    #判断y轴当前状态选择的是否为软科学科排名
    ${Yvalueres}  Check element status and return  xpath=//*[@id="container"]/div[1]/div[1]  class  words isactive  软科学科排名
    #判断x轴当前状态选择的是否为学科热度
    ${Xvalueres}  Check element status and return  xpath=//*[@id="container"]/div[2]/div[2]  class  words isactive  学科热度
    #默认状态下检查
    IF  '${xvalue}'=='None' and '${yvalue}'=='None'
        Check element status  xpath=//*[@id="container"]/div[1]/div[1]  class  words isactive  软科学科排名
        Check element status  xpath=//*[@id="container"]/div[1]/div[2]  class  words  第四轮学科评估
        Check element status  xpath=//*[@id="container"]/div[2]/div[2]  class  words isactive  学科热度
        Check element status  xpath=//*[@id="container"]/div[2]/div[1]  class  words  学科贡献
    ELSE
        #进行选择
        IF  '${yvalue}'=='软科学科排名'
            IF  ${Yvalueres}!=True
                Click Element  xpath=//*[@id="container"]/div[1]/div[2]
            END
        ELSE IF  '${yvalue}'=='第四轮学科评估'
            IF  ${Yvalueres}==True
                Click Element  xpath=//*[@id="container"]/div[1]/div[2]
            END
        END
        IF  '${xvalue}'=='学科热度'
            IF  ${Xvalueres}!=True
                Click Element  xpath=//*[@id="container"]/div[2]/div[1]
            END
        ELSE IF  '${xvalue}'=='学科贡献'
            IF  ${Xvalueres}==True
                Click Element  xpath=//*[@id="container"]/div[2]/div[1]
            END
        END
        #进行检查
        # @{x}  Create List  学科热度  学科贡献
        # @{y}  Create List  软科学科排名  第四轮学科评估
        # Evaluate  ${x}.remove('${xvalue}')
        # Log To Console  xxx${x}  
        Check element status   ${xyvaluedict}[${xvalue}]  class   words isactive  ${xvalue}
        Check element status   ${xyvaluedict}[${yvalue}]  class   words isactive  ${yvalue}
    END


Check xy axis ui
  [Arguments]  ${xvalue}  ${yvalue}  ${rankmethod}  ${subjstandard}  ${valuemax}=None
  #因为每个学校的
  #绝对排名前5名
  &{abspath5}  Create Dictionary  
  ...    1=css=#y-axis-group > text:nth-child(2)  
  ...    5=css=#y-axis-group > text:nth-child(9)  
  ...    25=css=#y-axis-group > text:nth-child(30)  
  ...    50=css=#y-axis-group > text:nth-child(56)  
  ...    ${valuemax}=css=#y-axis-group > text:nth-child(157)
  &{absy5}  Create Dictionary  
  ...    1=70  
  ...    5=315  
  ...    25=348.7931034482759  
  ...    50=391.0344827586207  
  ...    ${valuemax}=560
  #绝对排名前10\25\25名
  &{abspath10}  Create Dictionary  
  ...    1=css=#y-axis-group > text:nth-child(2) 
  ...    5=css=#y-axis-group > text:nth-child(7) 
  ...    10=css=#y-axis-group > text:nth-child(15)  
  ...    25=css=#y-axis-group > text:nth-child(31)  
  ...    50=css=#y-axis-group > text:nth-child(57)  
  ...    ${valuemax}=css=#y-axis-group > text:nth-child(158)
  &{absy10}  Create Dictionary  
  ...    1=70  
  ...    5=178.88888888888889  
  ...    10=315  
  ...    25=341.25  
  ...    50=385  
  ...    ${valuemax}=560
  &{absy25}  Create Dictionary  
  ...    1=70  
  ...    5=110.83333333333333  
  ...    10=161.875  
  ...    25=315  
  ...    50=364  
  ...    ${valuemax}=560
  &{absy50}  Create Dictionary  
  ...    1=70  
  ...    5=90  
  ...    10=115 
  ...    25=190  
  ...    50=315  
  ...    ${valuemax}=560
  #相对排名前5%
  &{relpath5}  Create Dictionary  
  ...    1%=css=#y-axis-group > text:nth-child(2)  
  ...    5%=css=#y-axis-group > text:nth-child(9)  
  ...    20%=css=#y-axis-group > text:nth-child(25)  
  ...    30%=css=#y-axis-group > text:nth-child(36)  
  ...    40%=css=#y-axis-group > text:nth-child(47)  
  ...    50%=css=#y-axis-group > text:nth-child(58)  
  ...    100%=#y-axis-group > text:nth-child(109)
  &{rel5}  Create Dictionary  
  ...    1%=70  
  ...    5%=315  
  ...    20%=353.6842105263158  
  ...    30%=379.4736842105263  
  ...    40%=405.2631578947368  
  ...    50%=431.05263157894734  
  ...    100%=560
  #相对排名前10%/20%/30%/40%/50%
  &{relpath10}  Create Dictionary
  ...    1%=css=#y-axis-group > text:nth-child(2)  
  ...    5%=css=#y-axis-group > text:nth-child(7) 
  ...    20%=css=#y-axis-group > text:nth-child(24)  
  ...    30%=css=#y-axis-group > text:nth-child(35)  
  ...    40%=css=#y-axis-group > text:nth-child(46)  
  ...    50%=css=#y-axis-group > text:nth-child(57)  
  ...    100%=css=#y-axis-group > text:nth-child(108)
  &{relpath20}  Create Dictionary  
  ...    1%=css=#y-axis-group > text:nth-child(2)  
  ...    5%=css=#y-axis-group > text:nth-child(7) 
  ...    20%=css=#y-axis-group > text:nth-child(25)  
  ...    30%=css=#y-axis-group > text:nth-child(36)  
  ...    40%=css=#y-axis-group > text:nth-child(47)  
  ...    50%=css=#y-axis-group > text:nth-child(58)  
  ...    100%=css=#y-axis-group > text:nth-child(109)
  &{relpath30}  Create Dictionary  
  ...    1%=css=#y-axis-group > text:nth-child(2)  
  ...    5%=css=#y-axis-group > text:nth-child(7) 
  ...    20%=css=#y-axis-group > text:nth-child(23)  
  ...    30%=css=#y-axis-group > text:nth-child(36)  
  ...    40%=css=#y-axis-group > text:nth-child(47)  
  ...    50%=css=#y-axis-group > text:nth-child(58)  
  ...    100%=css=#y-axis-group > text:nth-child(109)
  &{relpath40}  Create Dictionary  
  ...    1%=css=#y-axis-group > text:nth-child(2)  
  ...    5%=css=#y-axis-group > text:nth-child(7) 
  ...    20%=css=#y-axis-group > text:nth-child(23)  
  ...    30%=css=#y-axis-group > text:nth-child(34)  
  ...    40%=css=#y-axis-group > text:nth-child(47)  
  ...    50%=css=#y-axis-group > text:nth-child(58)  
  ...    100%=css=#y-axis-group > text:nth-child(109)
  &{relpath50}  Create Dictionary  
  ...    1%=css=#y-axis-group > text:nth-child(2)  
  ...    5%=css=#y-axis-group > text:nth-child(7) 
  ...    20%=css=#y-axis-group > text:nth-child(23)  
  ...    30%=css=#y-axis-group > text:nth-child(34)  
  ...    40%=css=#y-axis-group > text:nth-child(45)  
  ...    50%=css=#y-axis-group > text:nth-child(58)  
  ...    100%=css=#y-axis-group > text:nth-child(109)
  &{rel10}  Create Dictionary  
  ...    1%=70  
  ...    5%=178.88888888888889  
  ...    20%=342.22222222222223  
  ...    30%=369.44444444444446  
  ...    40%=396.66666666666663  
  ...    50%=423.8888888888889  
  ...    100%=560
  &{rel20}  Create Dictionary  
  ...    1%=70  
  ...    5%=121.57894736842104  
  ...    20%=315  
  ...    30%=345.625  
  ...    40%=376.25  
  ...    50%=406.875  
  ...    100%=560
  &{rel30}  Create Dictionary  
  ...    1%=70  
  ...    5%=103.79310344827587  
  ...    20%=230.51724137931035  
  ...    30%=315  
  ...    40%=350  
  ...    50%=385  
  ...    100%=560 
  &{rel40}  Create Dictionary  
  ...    1%=70  
  ...    5%=95.12820512820512  
  ...    20%=189.35897435897436  
  ...    30%=252.17948717948718  
  ...    40%=315  
  ...    50%=355.8333333333333  
  ...    100%=560 
  &{rel50}  Create Dictionary  
  ...    1%=70  
  ...    5%=90  
  ...    20%=165  
  ...    30%=215  
  ...    40%=265  
  ...    50%=315  
  ...    100%=560  
  #检查横坐标
  Page Should Contain Element  css=#overview > line
  #检查纵坐标
  Wait Until Element Is Visible  xpath=//*[@id="y-axis-group"]
  Page Should Contain Element  xpath=//*[@id="y-axis-group"]
  ${i}  Set Variable  0
  #根据横纵坐标选择以及排名方式与优势学科标准 变化的横纵坐标UI
  IF  '${yvalue}'=='软科学科排名'
      IF  '${rankmethod}'=='绝对排名'
          IF  '${subjstandard}'=='前5名' 
              #y轴元素
              ${ydict}  Set Variable  ${abspath5} 
              #纵坐标y值
              ${y}  Set Variable  ${absy5}
          ELSE IF  '${subjstandard}'=='前10名'
              ${ydict}  Set Variable  ${abspath10}
              ${y}  Set Variable  ${absy10}
          ELSE IF  '${subjstandard}'=='前25名'
              ${ydict}  Set Variable  ${abspath10}
              ${y}  Set Variable  ${absy10}
          ELSE IF  '${subjstandard}'=='前50名'
              ${ydict}  Set Variable  ${abspath10}
              ${y}  Set Variable  ${absy10}    
          END
      ELSE IF  '${rankmethod}'=='相对排名'
          IF  '${subjstandard}'=='5%'
              ${ydict}  Set Variable  ${relpath5}
              ${y}  Set Variable  ${rel5}
          ELSE IF  '${subjstandard}'=='前10%'
              ${ydict}  Set Variable  ${relpath10}
              ${y}  Set Variable  ${rel10}
          ELSE IF  '${subjstandard}'=='前20%'
              ${ydict}  Set Variable  ${relpath20}
              ${y}  Set Variable  ${rel20}
          ELSE IF  '${subjstandard}'=='前30%'
              ${ydict}  Set Variable  ${relpath30}
              ${y}  Set Variable  ${rel30}
          ELSE IF  '${subjstandard}'=='前40%'
              ${ydict}  Set Variable  ${relpath40}
              ${y}  Set Variable  ${rel40}
          ELSE IF  '${subjstandard}'=='前50%'
              ${ydict}  Set Variable  ${relpath50}
              ${y}  Set Variable  ${rel50}
          END
      END 
  END
  #获取长度
  ${len}  Evaluate  len(${ydict})
  Log To Console  len${len}
  #预期元素包含文本
  @{ytext}  Get Dictionary Keys  ${ydict}
  #预期元素的y轴坐标值
  @{ypath}  Get Dictionary Values  ${ydict}
  Log To Console  text${ytext}  ypath${ypath}
  WHILE  ${i}<${len}
      Wait Until Element Is Visible  ${ypath[${i}]}   10
      Check element text  ${ypath[${i}]}  ${ytext[${i}]}
      ${y1}  Get Element Attribute  ${ypath[${i}]}  y
      Log To Console  当前y${y1}
      Log To Console  y${y}
      Should Be Equal As Strings  ${y}[${ytext[${i}]}]  ${y1}
      ${i}  Set Variable  ${i}+1
  END
  
  
  

  
  
    


  

  

