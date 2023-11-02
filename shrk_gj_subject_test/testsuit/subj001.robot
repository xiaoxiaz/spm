*** Settings ***
Library   SeleniumLibrary
Resource   ../resources/keywordsdefine.robot
Test Setup  Subjopen01  ${schoolname}
*** Variables ***
${schoolname}  清华大学
${version}    202304
${size}  (32, 32)
${link}  "https://www.shanghairanking.cn/_uni/logo/27532357.png"
*** Test Cases ***

subj_ui001_学科水平页面左侧导航栏检测
    #logo和文字检测
    #todo logo检测
    #文字内容检测
    Element Should Contain  xpath=//*[@id="app"]/section/header/div[1]/div[1]/div[2]/span  ${schoolname}
    # ${img}  Get Element Size   xpath=//*[@id="app"]/section/header/div[1]/div[1]/div[1]/img  
    # Log To Console  ${img} 
    # ${textstyle}  Get Element Attribute  xpath = //*[@id="sub_menu_13_$$_overview-all-popup"]/li[1]  style
    # Log To Console  ${textstyle}

    #图片检测
    Sleep   2
    Page Should Contain Image  xpath = //*[@id="app"]/section/header/div[1]/div[1]/div[1]/img

    ${imgsize}  Get Element Size  xpath = //*[@id="app"]/section/header/div[1]/div[1]/div[1]/img

    ${imglink}  Get Element Attribute  xpath = //*[@id="app"]/section/header/div[1]/div[1]/div[1]/img  src
    Log To Console  ${imglink}   
    Log To Console   ${imgsize}
    ${imgsize1}=  Catenate  ${imgsize}
    Should Be Equal   ${imgsize1}  ${size}
    # Should Be Equal  ${imglink}  ${link}
    # ${imglinktype}=   "${imglink.__class__.__name__}"
    # ${is_subclass} =    Evaluate    issubclass($variable.__class__}, ClassNameHere)
    ${imglinktype} =    Evaluate    "${imglink.__class__.__name__}" == "str"
    Log To Console  获取网页类型${imglinktype}
    ${linktype}=  Evaluate  "${link.__class__.__name__}" == "tuple"
    Log To Console  期望类型${linktype}
    ${type string}=    Evaluate  type(${imglink}).__name__
    ${is int}=      Evaluate     isinstance($variable, int)    # will be True
    Log To Console  数据类型为${type string}
    
    
    
  