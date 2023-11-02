*** Variables ***
#-----xx-----
#-----cg平台-----
${GJ_URL}  https://cg-3f3ab907.gaojidata.com/login
${username}  2365237282
${password}  shanghai0306

#-----学科水平-----
#软科学科排名-学科门类
&{rank_subjdict}
...  人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[1]/label/span[1]  
...  哲学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[2]
...  文学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[3]
...  历史学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[4]
...  艺术学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[1]/div[5]

...  社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[1]/label/span[1]
...  经济学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[2]
...  法学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[3]
...  教育学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[4]
...  管理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[2]/div[5]

...  理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[1]/label/span[1]
...  理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[2]
...  工学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[3]
...  农学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[4]
...  医学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[3]/div[5]

...  交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[5]/div/ul/li[4]/div[1]/label/span[1]
#第四轮学科评估-学科门类
&{fourth_subjdict}
...  人文艺术=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[1]/label/span[1]
...  哲学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[2]
...  文学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[3]
...  历史学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[4]
...  艺术学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[1]/div[5]

...  社会科学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[1]/label/span[1]
...  经济学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[2]
...  法学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[3]
...  教育学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[4]
...  管理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[2]/div[5]

...  理工农医=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[1]/label/span[1]
...  理学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[2]
...  工学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[3]
...  农学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[4]
...  医学=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[3]/div[5]

...  交叉学科=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[2]/div/ul/li[4]/div[1]/label/span[1]

#软科学科排名-学科点层次
&{rank_leveldict}    
...    博士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[1]  
...    硕士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[2]  
...    虚拟点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[1]/li[7]/div/div/div[3]  

#第四轮学科评估-学科点层次
&{fourth_leveldict}  
...    博士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[1]  
...    硕士点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[2]  
...    虚拟点=xpath=//*[@id="main-container"]/div[1]/div[1]/div[2]/div/ul[2]/li[3]/div/div/div[3]