## asciinema工具使用
#### 按照官网上的方法安装配置asciinema
```bash
#install
sudo apt-get install asciinema
#link account
asciinema auth
```
#### asciinema使用方法
```bash
#start recording
asciinema rec
 ......
#stop recording
exit
```
## vimtutor教程使用
#### Lesson 1
[![asciicast](https://asciinema.org/a/EohEweYCcrPPRMW5t9S7Ic5EW.svg)](https://asciinema.org/a/EohEweYCcrPPRMW5t9S7Ic5EW)
#### Lesson 2
[![asciicast](https://asciinema.org/a/ed08nkG74qRCFRt7qBXGUCqR1.svg)](https://asciinema.org/a/ed08nkG74qRCFRt7qBXGUCqR1)
#### Lesson 3
[![asciicast](https://asciinema.org/a/CmAt8vf3VUxPhxck4ZzPiBR6B.svg)](https://asciinema.org/a/CmAt8vf3VUxPhxck4ZzPiBR6B)
#### Lesson 4
[![asciicast](https://asciinema.org/a/qZohV9kw5GKPloEjAjLM4vBZ2.svg)](https://asciinema.org/a/qZohV9kw5GKPloEjAjLM4vBZ2)
#### Lesson 5
[![asciicast](https://asciinema.org/a/PhyyTcpmo63ho2dWlquvA2blO.svg)](https://asciinema.org/a/PhyyTcpmo63ho2dWlquvA2blO)
#### Lesson 6
[![asciicast](https://asciinema.org/a/MvtEm2f723b8ZZFcPNrbk9mwe.svg)](https://asciinema.org/a/MvtEm2f723b8ZZFcPNrbk9mwe)
#### Lesson 7
[![asciicast](https://asciinema.org/a/uLfeYecHpjvs06OQ6uHp8bNSk.svg)](https://asciinema.org/a/uLfeYecHpjvs06OQ6uHp8bNSk)
- #### 你了解vim有哪几种工作模式？
Normal Mode 普通模式
Visual Mode 可视模式
Insert Mode 插入模式
Command-Line 命令行模式
Ex Mode Ex模式
Select Mode 选择模式
- #### Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？
下移10行 10j
移到开始 gg
移到结束 G
移到N行 Ngg
- #### Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？
删除单字符 x
删除单词 dw
删到行尾 d$
删除单行 dd
删除向下N行 dNd
- #### 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？
插入N个空行 NO ESC
插入80个-  CTRL+O 80i- ESC
- #### 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？
撤销操作 u
重做撤销 CTRL+R
- #### vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？
剪切单字符 x
剪切单词 dw
剪切单行 d$
粘贴 p
- #### 为了编辑一段文本你能想到哪几种操作方式（按键序列）？
插入：
在光标前插入 i
当前文字后插入 a
在光标下新起一行插入 o
删除：
删除光标右边N个字符 Nx
删除N行文本 Ndd
粘贴：
在光标后粘贴 p
- #### 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？
查看文件名及行号 CTRL+G
- #### 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？
搜索关键词 /或?
设置忽略大小写 :set ignorecase
高亮显示结果 :set hlsearsh
批量替换 :%s/词a/词b/g  (词a换为词b)
- #### 在文件中最近编辑过的位置来回快速跳转的方法？
``和`.
- #### 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }
%
- #### 在不退出vim的情况下执行一个外部程序的方法？
:!+指令
- #### 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？
查询快捷键 :help 快捷键
切换窗口 CTRL+W
