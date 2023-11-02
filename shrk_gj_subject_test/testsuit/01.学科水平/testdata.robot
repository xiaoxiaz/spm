*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers


*** Test Cases ***
subj01017飞鸟图下载图片验证
    @{reslist}   Create List    False  b  True  c  d  a 
    @{remove}   Create List  b   c   d
    ${i}   Set Variable  0
    ${len}  Evaluate  len(${remove})
    WHILE  ${i}<${len}
        Log To Console   ?? ${remove}[${i}]
        Evaluate  $reslist.remove('${remove}[${i}]')
        Run Keyword If  ('${remove}[${i}]' in ${reslist})  Evaluate  ${reslist}.remove("${remove}[${i}]")
        ${i}  Evaluate  ${i}+1
        Log To Console  ${reslist}
    END
    
#     Log To Console  ${reslist}
#     Evaluate  x for x in 


      
#     Evaluate  if True in ${reslist}




      

    
