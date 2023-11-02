*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Resource   ../../resources/keywordsdefine.robot
Test Setup  
Test Teardown  Close All Browsers
Library    DataDriver  ../../resources/testdata/学校样本.xlsx    sheet_name=testschool
Test Template     Choose and Check xy and sort 

*** Test Cases ***
飞鸟图横纵坐标默认状态与切换功能检测
    Choose and Check xy and sort  

*** Keywords ***
Choose and Check xy and sort
    [Arguments]  ${schoolname}
    Subjopen01  ${schoolname}
    #1.默认状态
    Check xy and sort  学科热度  软科学科排名
    #2.检测-学科贡献/软科学科排名
    Choose xyvalue  学科贡献  软科学科排名
    Check xy and sort   学科贡献  软科学科排名
    #3.检测-学科贡献/软科学科排名/相对排名
    Choose rankmethod  相对排名
    Check xy and sort  学科贡献   软科学科排名  相对排名
    #4.检测-学科热度/软科学科排名
    Choose xyvalue  学科热度  软科学科排名
    Check xy and sort  学科热度  软科学科排名  相对排名
    #5.检测-学科热度/第四轮学科评估
    Choose xyvalue  学科热度  第四轮学科评估
    Check xy and sort  学科热度  第四轮学科评估
    #6.检测-学科贡献/第四轮学科评估
    Choose xyvalue  学科贡献  第四轮学科评估
    Check xy and sort  学科贡献  第四轮学科评估
Check xy and sort
    [Arguments]  ${xvalue}  ${yvalue}   ${rankmethod}=None
    IF  '${yvalue}'=='软科学科排名'
        Check rankmethod  ${rankmethod} 
    END
    Check xyvalue  ${xvalue}  ${yvalue}
    Check subjstandard
    Check subj
    Check subjlevel