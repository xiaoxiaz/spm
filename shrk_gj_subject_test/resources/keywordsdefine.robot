*** Settings ***
Library  SeleniumLibrary  
Library  String
Library  DateTime
Library  OperatingSystem
Library  Collections
Resource  ../resources/constant.robot
*** Variables ***

#版本切换的xpath
# ${xpath}=   /html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[2]/div/span
#数据查询页面默认状态，“全部”与“综合”的statu
${dqexstatu1}  tab-item active
${dqexstatu2}    ant-tabs-tab ant-tabs-tab-active
#通知模块，激活状态
${noexstatu}   active
*** Keywords ***

#登录高绩网
Login gjplatform
  ${chromeOptions}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
  ${prefs} =    Create Dictionary    download.default_directory=D:\\workspace\\shrk_gj_subject_test\\downfile
  Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
  # Open Browser    Chrome    options=${chromeOptions}

  Open Browser   ${GJ_URL}  chrome   options=${chromeOptions}
  Maximize Browser Window
  Input Text  css= #LoginName  ${username}
  Input Password  css = #Password   ${password}
  Click Button  css = #app > div > div > form > button

#登录学科平台
Login subjectplatform
  Login gjplatform
  #检查text '学科水平动态监控平台管理系统'存在
  Wait Until Element Is Visible  xpath = //*[@id="app"]/div/div[2]/div[1]/div/div[2]  
  #进入学科平台
  Click Image   css = #app > div > div.prd-container > div:nth-child(1) > div > div:nth-child(2) > img
  Wait Until Element Contains  css=#app > section > section > header > div.left-box > div.img-box > div > span  学科监测

#登录学科平台页面选择学校
Subjchooseschool
  [Arguments]  ${schoolname}
    Wait Until Element Is Visible    xpath=//*[@id="rc_select_0"]
    Input Text  xpath=//*[@id="rc_select_0"]  ${schoolname}
    Wait Until Element Is Visible  xpath=//*[@class="rc-virtual-list"]
    Mouse Over  xpath=//*[@class="rc-virtual-list"]
    Wait Until Element Is Visible  xpath=(//*[@label="${schoolname}"])[1]
    Click Element   xpath=(//*[@label="${schoolname}"])[1]

#新增学校账号
Add schooluser
    [Arguments]   ${schoolname}
    Wait Until Element Is Visible  xpath=//*[@id="app"]/section/section/main/div/div/div[1]/div[2]/button/span[2]
    Click Element  xpath=//*[@id="app"]/section/section/main/div/div/div[1]/div[2]/button/span[2]
    Wait Until Element Is Visible   xpath=//*[@id="rcDialogTitle0"]
    Wait Until Element Is Visible  xpath=//*[@id="univCode"]
    # Click Element   xpath=//*[@id="univCode"]
    Input Text   xpath=//*[@id="univCode"]  ${schoolname}
    Wait Until Element Is Visible    xpath=//*[@class="ant-select-item ant-select-item-option ant-select-item-option-active" and @label="${schoolname}"]
    Mouse Over    xpath=//*[@class="ant-select-item ant-select-item-option ant-select-item-option-active" and @label="${schoolname}"]
    Click Element  xpath=//*[@class="ant-select-item ant-select-item-option ant-select-item-option-active" and @label="${schoolname}"]
    Wait Until Element Is Visible  xpath=//span[contains(text(),"保")]
    Click Element  xpath=//span[contains(text(),"保")]
    Wait Until Element Is Visible  xpath=//td[text()="${schoolname}"]   timeout=3 

#打开xx学校的学科平台页面
Subjopen01
  [Arguments]  ${schoolname}  
  Login subjectplatform
  subjchooseschool  ${schoolname}
  #进行有无学校判断：1.搜索后 有学校对应的账号-选择第一个进行跳转；2.无学校对应的账号-新建-开设权限
  Sleep  2
  ${userres}  Run Keyword And Return Status   Page Should Contain Element   xpath=//*[contains(text(),"暂无数据")]
  IF  ${userres}==True
      Log To Console  该校无学校账号,正在为你新建
      Add schooluser  ${schoolname}
      Wait Until Element Is Visible  xpath=//*[contains(text(),"设置教育部学科权限")]
      Click Element  xpath=//*[contains(text(),"设置教育部学科权限")]
      Wait Until Element Is Visible  xpath=//*[contains(text(),"全选已开设")]
      Click Element  xpath=//*[contains(text(),"全选已开设")]
      Click Element  xpath=//*[contains(text(),"确")]
      Wait Until Element Is Visible  xpath=(//*[contains(text(),"跳转")])[1]
      Click Element  xpath=(//*[contains(text(),"跳转")])[1]
      ${window}   Get Window Handles
      Switch Window  ${window[-1]}
  ELSE
      Wait Until Element Is Visible  xpath=(//*[contains(text(),"跳转")])[1]
      Click Element  xpath=(//*[contains(text(),"跳转")])[1]
      ${window}   Get Window Handles
      Switch Window  ${window[-1]}
      #有无开设权限
      Sleep  2
      ${subjres}  Run Keyword And Return Status  Page Should Contain Element   xpath=//*[@class="ant-modal-body"]
      IF  ${subjres}==True
            Log To Console   尚无对应学位点的权限,将自动开启所有权限
            Close Window
            Switch Window  ${window[0]}
            Wait Until Element Is Visible  xpath=//*[contains(text(),"设置教育部学科权限")]
            Click Element  xpath=//*[contains(text(),"设置教育部学科权限")]
            Wait Until Element Is Visible  xpath=//*[contains(text(),"全选已开设")]
            Click Element  xpath=//*[contains(text(),"全选已开设")]
            Click Element  xpath=//*[contains(text(),"确")]
            Wait Until Element Is Visible  xpath=(//*[contains(text(),"跳转")])[1]
            Click Element  xpath=(//*[contains(text(),"跳转")])[1]
            ${window}   Get Window Handles
            Switch Window  ${window[-1]}
      END
  END
  #确保默认状态进入学科水平页面
  Wait Until Element Is Visible  xpath=//*[@class="title"]   timeout=5
  Page Should Contain Element  xpath=//*[@class="title" and text()="学科水平"]
  #进入学科水平页面，检测左上角的学校名称看是否符合预期
  Wait Until Element Is Visible  xpath=//*[@class="univName"] 
  Element Should Contain   xpath=//*[@class="univName"]  ${schoolname}
  
  

#切换版本
Subjchooseversion
  [Arguments]   ${version}
  #这里选择不到当前版本，如有需要，请直接刷新当前页面
  #获取当前版本
  ${curversion}  Get Text  xpath=//*[@id="header-version"]/div/div/span[2]/span
  # Log To Console   当前版本是${curversion}
  #点击版本，弹出下拉选项框
  Click Element  xpath=//*[@id="header-version"]/div
  Sleep  2
  #获取div[2]和div[8]的值对所有版本进行选择
  ${div2text}  Get Text  xpath =/html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[2]/div/span
  ${div8text}  Get Text  xpath =/html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[8]/div/span
  ${comversion}  Remove String  ${version}   年  月
  ${comdiv2text}  Remove String  ${div2text}  年  月
  ${comdiv8text}  Remove String  ${div8text}  年  月
  ${xpath}  Set Variable   /html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[2]/div/span
  WHILE    ${comdiv2text}!=${comversion}   limit=99999
      Press Keys    None   DOWN = '\ue015' 
      ${div2text}  Get Text  xpath =/html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[2]/div/span
      ${div8text}  Get Text  xpath =/html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[8]/div/span
      ${comdiv2text}  Remove String  ${div2text}  年  月
      ${comdiv8text}  Remove String  ${div8text}  年  月
      IF  ${comdiv8text} == ${comversion}
          ${comdiv2text}  Replace Variables  ${comdiv8text}
          ${xpath}  Replace Variables  /html/body/div[3]/div/div/div/div[2]/div[1]/div/div/div[8]/div/span    
      END
      Sleep  0.05  
  END
  Click Element  xpath = ${xpath}
#检查数据查询功能
Check dataquery
  Click Element   xpath=//*[@id="app"]/section/header/div[3]/span[1]/input
#   Wait Until Page Contains   请输入指标名称、项目、获奖、姓名等关键词，多关键词用空格隔开
  Input Text  xpath=//*[@id="app"]/section/header/div[3]/span[1]/input   1  
  Press Keys  xpath=//*[@id="app"]/section/header/div[3]/span[1]/input   RETURN
  Sleep  2
  #检测当前页面为“数据查询”页面
  Element Should Contain  xpath=//*[@id="main-layout"]/div[1]/div[1]/span   数据查询
  Element Should Contain  xpath=//*[@id="main-layout"]/div[1]/div[3]/div[1]/div[2]/div[1]/div[1]  综合
  Element Should Contain  xpath=//*[@id="rc-tabs-1-tab-All"]    全部
  #监测“全部”“综合”是否被选中
  ${statu1}  Get Element Attribute  xpath=//*[@id="main-layout"]/div[1]/div[3]/div[1]/div[2]/div[1]/div[1]    class
  ${statu2}  Get Element Attribute  xpath=//*[@id="rc-tabs-1-tab-All"]  class
  Should Be Equal As Strings  ${statu1}  ${dqexstatu1}
  Should Be Equal As Strings  ${statu2}  ${dqexstatu2}

#检查通知-功能更新ui页面
Check noticeui1
#检查“通知”位置和文本
    Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]   通知
    #点击功能更新
    Click Element   xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]
    #检查功能更新
    Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]
    Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]   功能更新
    ${statu}   Get Element Attribute    xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]  class
    Should Be Equal As Strings  ${statu}  ${noexstatu} 
    #检查指标更新
    Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
    Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]   指标更新
    #检查一键已读
    Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[2]
    Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[2]  一键已读

    #检查是否有内容，两种状态判断
    ${res}   Run Keyword And Return Status    Page Should Contain   暂无通知
    IF  ${res}==True
      Page Should Contain Image   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div/img
      Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div/div
      Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div/div  暂无通知
    ELSE 
      Page Should Contain   仅展示最近一年 
    END
    Sleep  2

#检查通知-指标更新ui页面
Check noticeui2
  #检查“通知”位置和文本
    Element Should Contain   xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[1]   通知
    #点击“指标更新”
    Wait Until Element Is Visible  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
    # Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
    Click Element   xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
    # /html/body/div[5]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
    #检查功能更新
    Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]
    Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[1]   功能更新
    #检查指标更新
    Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]
    Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]   指标更新
    ${statu}   Get Element Attribute    xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[2]/div/span[2]   class
    Should Be Equal As Strings  ${statu}  ${noexstatu} 
    #检查一键已读
    Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[2]
    Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[1]/div/div/div[1]/span[2]  一键已读

    #检查是否有内容，两种状态判断
    ${res}   Run Keyword And Return Status    Page Should Contain   暂无通知
    IF  ${res}==True
        Page Should Contain Image   xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div/img
        Page Should Contain Element  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div/div
        Element Should Contain  xpath=/html/body/div[3]/div/div[2]/div/div/div[2]/div/div/div  暂无通知
    ELSE 
        Page Should Contain   仅展示最近一年 
    END
    Sleep  2


Check downfile
  [Arguments]  ${begintime}  ${fileformat}  ${filename}=None  
  #获取当前时间
  @{filelist}   List Files In Directory   D:\\workspace\\shrk_gj_subject_test\\downfile   *.${fileformat}
  ${filetime}  Get Modified Time   D:\\workspace\\shrk_gj_subject_test\\downfile\\${filelist[0]}
  ${currenttime}  Get Current Date   result_format=timestamp
  #文件下载的时间应该比点击前滞后
  ${res1}  Subtract Date From Date  ${filetime}   ${begintime}
  Log To Console  1${res1}
  #当前时间应该比文件下载的时间滞后
  ${res2}  Subtract Date From Date  ${currenttime}  ${filetime}
  Log To Console  2${res2}
  Run Keyword If  ${res1}<0    Fail
  Run Keyword If  ${res2}<0   Fail
 #对名字有规则的下载文件进行名字格式判断
  ${nameres}  Run Keyword And Return Status   Evaluate  ${filename}==None
  IF  ${nameres}==False
      ${name}  Remove String  ${filelist[0]}   .${fileformat}
      Should Contain  ${name}  ${filename}
  END
 #检测该文件大小不为零
  File Should Not Be Empty  D:\\workspace\\shrk_gj_subject_test\\downfile\\${filelist[0]}

Check element status and return
  [Arguments]  ${element}  ${attribute}  ${exceptstatus}   ${text}=None
  #获取 元素某种属性值是否符合预期的结果（不报错返回进行选择判断）
    ${eleres}  Run Keyword And Return Status  Page Should Contain Element  ${element}
    IF  ${eleres}
        IF  '${text}'!='None'
            ${res1}  Run Keyword And Return Status  Element Should Contain  ${element}  ${text}
        ELSE
            ${res1}  Set Variable  True
        END
        ${status}  Get Element Attribute  ${element}  ${attribute}
        ${res2}  Run Keyword And Return Status  Should Be Equal As Strings  ${status}  ${exceptstatus}
        ${res}  Evaluate  ${res1} and ${res2}
    ELSE
        ${res}  Set Variable  False
    END
    RETURN  ${res}
  
#   Wait Until Element Is Visible   ${element}   5s
#   Page Should Contain Element  ${element}
#   IF  '${text}'!='None'
#       ${res1}  Run Keyword And Return Status  Element Should Contain  ${element}  ${text}
#   ELSE
#       ${res1}  Set Variable  True
#   END
#   ${status}  Get Element Attribute  ${element}  ${attribute}
#   ${res2}  Run Keyword And Return Status  Should Be Equal As Strings  ${status}  ${exceptstatus}
#   ${res}  Evaluate  ${res1} and ${res2}
#   RETURN  ${res}

Check element status
  #检查元素某种属性值是否符合预期
  [Arguments]  ${element}  ${attribute}  ${exceptstatus}   ${text}=None
  Wait Until Element Is Visible  ${element}  timeout=10s
  Page Should Contain Element  ${element}
  IF  '${text}'!='None'
      Element Should Contain  ${element}  ${text}     
  END
  ${status}  Get Element Attribute  ${element}  ${attribute}
  Should Be Equal As Strings  ${status}  ${exceptstatus}

Check element text
  [Arguments]  ${path}  ${text}
  #检查文本元素存在
  Page Should Contain Element  ${path}
  Element Should Contain   ${path}  ${text}

Check element text and return
    [Arguments]  ${path}  ${text}
    #检测元素是否存在文本并返回值
    ${res}  Run Keyword And Return Status  Element Should Contain  ${path}  ${text}
    RETURN   ${res} 

Choose xyvalue
    #选择飞鸟图坐标轴xy的值
    [Arguments]  ${x}  ${y}
    #检查x轴选中的值
    ${xres}  Check element text and return  xpath=//*[@id="container"]/div[2]/div[2]   ${x}
    #检测y轴选中的值
    ${yres}  Check element text and return  xpath=//*[@id="container"]/div[1]/div[1]   ${y}
    IF  ${xres}==False
        Wait Until Element Is Enabled    xpath=//*[@id="container"]/div[2]/div[2]
        Click Element  xpath=//*[@id="container"]/div[2]/div[1]
    END
    IF  ${yres}==False
        Wait Until Element Is Enabled  xpath=//*[@id="container"]/div[1]/div[1]
        Click Element   xpath=//*[@id="container"]/div[1]/div[2]   
    END

Choose rankmethod
    #y轴为软科，选择排名方式
    [Arguments]  ${rankmethod}
    &{rankdict}  Create Dictionary  
    ...    绝对排名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]  
    ...    相对排名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[2]
    Log To Console   ${rankdict}[${rankmethod}]
    ${res}  Check element status and return   ${rankdict}[${rankmethod}]   class   ant-radio-wrapper ant-radio-wrapper-checked
    IF  ${res}==False
        Click Element  ${rankdict}[${rankmethod}]
    END

Choose subjstandard
    [Arguments]  ${subjstandard}
    &{standarddict}  Create Dictionary   
    #软科学科排名-绝对排名-优势学科标准   
    ...    前5名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]   
    ...    前10名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]   
    ...    前25名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
    ...    前50名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]
    #软科学科排名-相对排名-优势学科标准   
    ...    前5%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1] 
    ...    前10%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]   
    ...    前20%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
    ...    前30%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]  
    ...    前40%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[5]   
    ...    前50%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[6]
    #第四轮学科评估-优势学科标准                
    ...    A+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[1]  
    ...    A=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[2]  
    ...    A-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[3]  
    ...    B+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[1] 
    ...    B=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[2]  
    ...    B-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[3]  
    ...    C+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[1]   
    ...    C=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[2]   
    ...    C-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[3]
    Wait Until Element Is Visible   ${standarddict}[${subjstandard}]   timeout=5
    ${res}  Check element status and return  ${standarddict}[${subjstandard}]  class  ant-radio-wrapper ant-radio-wrapper-checked
    IF  ${res}==False
        Click Element   ${standarddict}[${subjstandard}]
    END

Clear all subj
    #1.清空所有学科  2.取消选中某几个学科
    @{subj}  Create List   人文艺术   社会科学   理工农医   交叉学科
    #y轴软科-判断是否为全选
    &{rank_subjalldict}  Create Dictionary  
    ...    人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[1]/label
    ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[1]/label 
    ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[1]/label  
    ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[1]/label
    #y轴软科-当不为全选时判断该项是否此学科下有选中的选项
    &{rank_subjordict}  Create Dictionary  
    ...    人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[1]/label/span[1]
    ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[1]/label/span[1] 
    ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[1]/label/span[1]  
    ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[1]/label/span[1]
    #y轴第四轮-判断是否为全选
    &{fourth_subjalldict}  Create Dictionary  
    ...    人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[1]/label
    ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[1]/label 
    ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[1]/label  
    ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[1]/label
    #y轴第四轮-当不为全选时判断该项是否此学科下有选中的选项
    &{fourth_subjordict}  Create Dictionary  
    ...    人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[1]/label/span[1]
    ...    社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[1]/label/span[1]
    ...    理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[1]/label/span[1]  
    ...    交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[1]/label/span[1]
    #先判断y轴value
    ${yres}  Check element text and return   xpath=(//*[@class="words isactive"])[1]  软科学科排名
    IF  ${yres}==True
        ${subjalldict}   Copy Dictionary  ${rank_subjalldict}
        ${subjordict}   Copy Dictionary  ${rank_subjordict}
    ELSE
        ${subjalldict}  Copy Dictionary  ${fourth_subjalldict}
        ${subjordict}  Copy Dictionary  ${fourth_subjordict}
    END
    ${i}  set variable  0
    ${len}  Evaluate  len(@{subj})
    WHILE  ${i}<${len}
        #如果为全选，点一次
        ${allres}   Check element status and return  ${subjalldict}[${subj[${i}]}]   class    ant-checkbox-wrapper ant-checkbox-wrapper-checked
        IF  ${allres}==True
            Click Element    ${subjalldict}[${subj[${i}]}]
        ELSE
            ${orres}  Check element status and return  ${subjordict}[${subj[${i}]}]   class  ant-checkbox ant-checkbox-indeterminate
            IF  ${orres}==True
            Click Element  ${subjordict}[${subj}[${i}]]
            Sleep  2
            Click Element  ${subjordict}[${subj}[${i}]]  
            END
            
        END
        ${i}  Evaluate  (${i}+1)
    END
    
Choose subj
#勾选学科
    [Arguments]  @{subj}
    #根据纵坐标的值选择dict
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    #获取当前页面纵坐标维度
    ${rankres}   Get text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  "${rankres}"=="软科学科排名"
        ${subjdict}  Copy Dictionary  ${rank_subjdict}
    ELSE IF  "${rankres}"=="第四轮学科评估"
        ${subjdict}   Copy Dictionary  ${fourth_subjdict}
    ELSE
        Log  未捕捉到纵坐标元素
        Fail
    END
    ${lenth}  Evaluate  len(${subj})
    ${i}  Set Variable  0
    WHILE   ${i}<${lenth}
        ${stateres1}  Check element status and return  ${subjdict.${subj[${i}]}}  class   ant-checkbox-wrapper ant-checkbox-wrapper-checked
        ${stateres2}  Check element status and return  ${subjdict.${subj[${i}]}}  class   custom-check select-check
        ${res}  Evaluate  (${stateres1} or ${stateres2})
        # Log To Console  res ${res}
        IF  ${res}== False
            Click Element  ${subjdict.${subj[${i}]}} 
        END
        ${i}   Evaluate  ${i}+1
    END

Cancel choose subj
#取消勾选学科
    [Arguments]  @{subj}
    #字典作为常量，在接口里进行增删操作的时候需要要接口里面先copy一份，不然顺序执行的时候会改变该字典；   
    ${i}  Set Variable  0
    ${len}  Evaluate  len(${subj})
     #根据纵坐标的值选择dict
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    #获取当前页面纵坐标维度
    ${rankres}   Get text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  "${rankres}"=="软科学科排名"
        ${subjdict}  Copy Dictionary  ${rank_subjdict}
    ELSE IF  "${rankres}"=="第四轮学科评估"
        ${subjdict}   Copy Dictionary  ${fourth_subjdict}
    ELSE
        Log  未捕捉到纵坐标元素
        Fail
    END
    WHILE  ${i}<${len}
        ${nores}  Check element status and return   ${subjdict}[${subj}[${i}]]   class   ant-checkbox ant-checkbox-indeterminate
        IF  ${nores}==True
            Wait Until Element Is Enabled  ${subjdict}[${subj}[${i}]]  
            Click Element   ${subjdict}[${subj}[${i}]]
            Wait Until Element Is Enabled  ${subjdict}[${subj}[${i}]]
            Click Element   ${subjdict}[${subj}[${i}]]
        ELSE
            ${allres}  Check element status and return   ${subjdict}[${subj}[${i}]]  class  ant-checkbox ant-checkbox-checked  #全选
            ${cres}  Check element status and return   ${subjdict}[${subj}[${i}]]  class  custom-check select-check  #选中状态
            ${res}  Evaluate  (${allres} or ${cres})
            IF  ${res}==True
                Wait Until Element Is Enabled  ${subjdict}[${subj}[${i}]]  
                Click Element   ${subjdict}[${subj}[${i}]]     
            END
        END
        ${i}  Evaluate  ${i}+1
    END

#选择学科层次点
Choose subjlevel
  [Arguments]  @{chooselevel}
    #软科学科排名-学科点层次
    #去重
    ${chooselevel}  Remove Duplicates  ${chooselevel}
    #先判断选择的是哪个，然后再使用相对的dict
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    #获取当前页面纵坐标维度
    ${res}   Get text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  "${res}"=="软科学科排名"
        ${leveldict}  Copy Dictionary  ${rank_leveldict}
    ELSE IF  "${res}"=="第四轮学科评估"
        ${leveldict}   Copy Dictionary  ${fourth_leveldict}
    ELSE
        Log  未捕捉到纵坐标元素
        Fail
    END
    #判断虚拟点是否存在
    ${virtualres}  Run Keyword And Return Status  Page Should Contain Element  xpath=//*[text()="虚拟点"]
    IF  ${virtualres}==False
        Remove From List   ${chooselevel}   虚拟点
    END
    IF  ${chooselevel}==None
        Log To Console   该学校没有虚拟点
    ELSE
        ${lenth}  Evaluate  len(${chooselevel})
        ${i}  Set Variable  0
        WHILE   ${i}<${lenth}
            ${res}  Check element status and return   ${leveldict}[${chooselevel}[${i}]]   class  level-check-item active
            IF  ${res}==False
                Wait Until Element Is Enabled    ${leveldict}[${chooselevel}[${i}]]
                Click Element   ${leveldict}[${chooselevel}[${i}]]
            END
            ${i}   Evaluate  ${i}+1
        END 
    END

#清除选择的学科层次点
Clear subjlevel
    #先判断选择的是哪个，然后再使用相对的dict
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    #获取当前页面纵坐标维度
    ${res}   Get text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  "${res}"=="软科学科排名"
        ${leveldict}  Copy Dictionary  ${rank_leveldict}
    ELSE IF  "${res}"=="第四轮学科评估"
        ${leveldict}   Copy Dictionary  ${fourth_leveldict}
    ELSE
        Log  未捕捉到纵坐标元素
        Fail
    END
    #todo 根据版本判断是否有虚拟点
    #todo优化点 虚拟点的出现不是很丝滑，这里可能与实际有差异
    Sleep   3
    ${virtualres}  Run Keyword And Return Status  Page Should Contain Element    xpath=//*[text()="虚拟点"]
    @{levellist}   Get Dictionary Keys   ${leveldict}
    ${type}  Evaluate  type(${levellist})
    Log To Console  ${type}    
    Log To Console  ${levellist}
    IF  ${virtualres}==False
        Evaluate  $levellist.remove("虚拟点")
    END
    ${len}  Evaluate  len(${levellist})
    ${i}  Set Variable  0
    WHILE  ${i}<${len}
        ${res}  Check element status and return   ${rank_leveldict}[${levellist}[${i}]]  class  level-check-item active
        IF  ${res}==True
            Wait Until Element Is Enabled   ${rank_leveldict}[${levellist}[${i}]]
            Click Element   ${rank_leveldict}[${levellist}[${i}]]            
        END
       ${i}  Evaluate  ${i}+1
    END


Check xyvalue
#检测xy轴的值
    [Arguments]  ${X}  ${Y}
    @{Xvalue}  Create List  学科贡献  学科热度
    @{Yvalue}  Create List  软科学科排名   第四轮学科评估
    Remove Values From List  ${Xvalue}  ${X}
    Remove Values From List  ${Yvalue}  ${Y}
    #1.检测纵坐标尖角、高亮和置灰的value
    Wait Until Element Is Visible  xpath=(//*[@class="icon-svg-icon toRight"])[1]  timeout=5
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    Check element status  xpath=//*[@id="container"]/div[1]/div[1]  class  words isactive  ${Y}
    Check element status  xpath=//*[@id="container"]/div[1]/div[2]  class  words  ${Yvalue}[0]
    #2.检测横坐标尖角、高亮和置灰的value
    Wait Until Element Is Visible  xpath=(//*[@class="icon-svg-icon toRight"])[2]  timeout=5
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[2]/div[2]
    Check element status  xpath=//*[@id="container"]/div[2]/div[2]  class  words isactive  ${X}
    Check element status  xpath=//*[@id="container"]/div[2]/div[1]  class  words  ${Xvalue}[0]

Check rankmethod
#软科学科排名-检测排名方法，默认状态下为'绝对排名'
  [Arguments]  ${rankmethod}=None  
  #1.检测纵坐标为'软科学科排名'
  Check element status  xpath=//*[@id="container"]/div[1]/div[1]  class  words isactive  软科学科排名
  Sleep  2
  #2.检测对应排名被选中
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
    #默认情况下，选择其中的一个
    [Arguments]  ${standard}=None
    #软科学科排名-绝对排名
    &{rank_absolutedict}  Create Dictionary  
    ...    前5名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]  
    ...    前10名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]  
    ...    前25名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
    ...    前50名=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4] 
    #软科学科排名-相对排名
    &{rank_relativedict}  Create Dictionary  
    ...    前5%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[1]  
    ...    前10%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[2]  
    ...    前20%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[3]  
    ...    前30%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[4]  
    ...    前40%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[5]  
    ...    前50%=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/div/div/label[6]
    #第四轮学科评估
    &{fourth_dict}  Create Dictionary  
    ...    A+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[1]  
    ...    A=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[2]  
    ...    A-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[1]/label[3]  
    ...    B+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[1]  
    ...    B=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[2]  
    ...    B-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[2]/label[3]  
    ...    C+=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[1]  
    ...    C=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[2]  
    ...    C-=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/div/div/div[3]/label[3]
     
    ${menthodres}  Check element status and return  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]  class  ant-radio-wrapper ant-radio-wrapper-checked
    #1.判断排名方式，再进分支
    ${yvalue}  Get Text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  '${yvalue}' == '第四轮学科评估'
        Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[1]/span   优势学科标准：
        ${dict}  Copy Dictionary  ${fourth_dict}
    ELSE
        Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[3]/span  优势学科标准：
        ${rankres}  Check element status and return  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[1]/div/div/label[1]   class  ant-radio-wrapper ant-radio-wrapper-checked
        IF  ${rankres}==True
            ${dict}  Copy Dictionary  ${rank_absolutedict}
        ELSE
            ${dict}  Copy Dictionary  ${rank_relativedict}
        END
    END
    #如果输入为None
    ${keylist}  Get Dictionary Keys  ${dict}
    ${i}  Set Variable  ${0}  
    IF  ${standard}==None
        ${reslist}  Create List
        ${len}  Evaluate  len(${keylist})
        WHILE  ${i}<${len}
            ${res}  Check element status and return  ${dict}[${keylist}[${i}]]  class  ant-radio-wrapper ant-radio-wrapper-checked
            ${res}  Convert To String  ${res}
            ${res}  Remove String  ${res}  ${SPACE}
            Append To List  ${reslist}  ${res}
            ${i}  Evaluate  ${i}+1
        END
        ${exceptres}   Count Values In List  ${reslist}  True
        Should Be Equal As Integers  ${exceptres}  1
    ELSE
        Check element status   ${dict}[${keylist}[${i}]]  class   ant-radio-wrapper ant-radio-wrapper-checked  ${standard}
        Evaluate   $keylist.remove(${standard})
        ${len}  Evaluate  len(${keylist})
        WHILE   ${i}<${len} 
            Check element status  ${dict}[${keylist}[${i}]]  class  ant-radio-wrapper  ${keylist}[${i}]
            ${i}  Evaluate  ${i}+1
        END 
    END
   
Check subj
    [Arguments]  @{subj}
    #参数为勾选状态的学科，如果传值为None，默认状态下，全部勾选
    #根据纵坐标的值选择dict
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    #获取当前页面纵坐标维度
    ${rankres}   Get text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  "${rankres}"=="软科学科排名"
        Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/span   学科门类： 
        ${subjdict}  Copy Dictionary  ${rank_subjdict}
    ELSE IF  "${rankres}"=="第四轮学科评估"
        Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/span   学科门类：
        ${subjdict}   Copy Dictionary  ${fourth_subjdict}
    ELSE
        Log  未捕捉到纵坐标元素
        Fail
    END
    ${len}  Evaluate  len(${subj})
    ${i}  Set Variable  0
    IF  ${subj}==[]
        ${subjlist}  Get Dictionary Keys  ${subjdict}
        ${len}  Evaluate  len(${subjdict})
        WHILE  ${i}<${len}
            Wait Until Element Is Visible   ${subjdict}[${subjlist}[${i}]]
            ${allres}  Check element status and return  ${subjdict}[${subjlist}[${i}]]   class  ant-checkbox ant-checkbox-checked
            ${rankres}  Check element status and return  ${subjdict}[${subjlist}[${i}]]   class  custom-check select-check
            ${res}   Evaluate  ${allres} or ${rankres}
            Convert To String  ${res}
            Should Be Equal As Strings  True  ${res}
            ${i}  Evaluate  ${i}+1
        END
    ELSE
        ${subjlist}  Get Dictionary Keys  ${subjdict}
        Convert To List  ${subjlist}
        #对需要检查的元素进行一个数据处理，若父级勾选则子级勾选
        IF  '人文艺术' in ${subj}
            Append To List  ${subj}  哲学  文学  历史学  艺术学
        ELSE IF  '社会科学' in ${subj}
            Append To List   ${subj}  经济学  法学  教育学  管理学
        ELSE IF  '理工农医' in ${subj}
            Append To List  ${subj}  理学  工学  农学  医学
        END
        ${subj}  Remove Duplicates  ${subj}
        
        #检测被选中的
        ${len1}  Evaluate  len(${subj})
        WHILE  ${i}<${len1}
            Check element multiple status   ${subjdict}[${subj}[${i}]]  class   ant-checkbox ant-checkbox-checked   custom-check select-check
            Run Keyword If  ('${subj}[${i}]' in ${subjlist})  Evaluate  $subjlist.remove('${subj}[${i}]')
            Log To Console  ${subjlist}
            ${i}  Evaluate  ${i}+1
        END
        #检测未被选中的
        ${len2}  Evaluate  len(${subjlist})
        ${i}  Set Variable  0
        WHILE  ${i}<${len2}
            Log To Console  正在检查${subjlist}[${i}]元素
            Check element multiple status   ${subjdict}[${subjlist}[${i}]]   class   ant-checkbox   custom-check   ant-checkbox ant-checkbox-indeterminate
            ${i}  Evaluate  ${i}+1
        END
    END

Check element multiple status
    [Arguments]   ${element}  ${attribute}   @{status}
    Wait Until Element Is Visible  ${element}   timeout=10
    Page Should Contain Element  ${element}
    ${len}  Evaluate  len(${status})
    ${i}  Set Variable  0
    @{reslist}  Create List
    WHILE  ${i}<${len}
        ${res}  Run Keyword And Return Status   Element Attribute Value Should Be  ${element}  ${attribute}  ${status}[${i}]
        ${res}  Convert To String  ${res}
        Append To List  ${reslist}  ${res}
        ${i}  Evaluate  ${i}+1
    END
    Run Keyword If  ('True' not in ${reslist})  Fail

Check subjlevel
    [Arguments]  @{subjlevel}
    Wait Until Element Is Visible   xpath=//*[@id="container"]/div[1]/div[1]
    #获取当前页面纵坐标维度
    ${res}   Get text  xpath=//*[@id="container"]/div[1]/div[1]
    IF  "${res}"=="软科学科排名"
        Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/span  学科点层次：
        ${leveldict}  Copy Dictionary  ${rank_leveldict}
    ELSE IF  "${res}"=="第四轮学科评估"
        Check element text  xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/span  学科点层次：
        ${leveldict}   Copy Dictionary  ${fourth_leveldict}
    ELSE
        Log  未捕捉到纵坐标元素
        Fail
    END
    ${levellist}  Get Dictionary Keys  ${leveldict}
    #默认状态 None
    IF  ${subjlevel}==[]
        ${len}  Evaluate  len(${levellist})
        ${i}  Set Variable  0
        WHILE  ${i}<${len}
            Check element status  ${leveldict}[${levellist}[${i}]]  class  level-check-item active  ${levellist}[${i}]
            ${i}  Evaluate  ${i}+1
        END
    ELSE
        ${len}  Evaluate  len(${subjlevel})
        ${i}  Set Variable  0
        WHILE  ${i}<${len}
            Check element status  ${leveldict}[${subjlevel}[${i}]]  class  level-check-item active  ${subjlevel}[${i}]
            Run Keyword If  ${subjlevel}[${i}] in ${levellist}  Evaluate  $levellist.remove('${subjlevel}[${i}]')
            ${i}  Evaluate  ${i}+1
        END
        ${len}  Evaluate  len(${levellist})
        ${i}  Set Variable  0
        WHILE  ${i}<${len}
            Check element status  ${leveldict}[${levellist}[${i}]]  class    level-check-item  ${levellist}[${i}]
            ${i}  Evaluate  ${i}+1
        END
    END
    
    
    
    
    
  
  
    


  

  


  

  
    
    
  


  