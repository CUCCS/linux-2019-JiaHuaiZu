# 高级Web服务器配置


### 虚拟机环境

Ubuntu 18.04 Server
- NAT
- Host-Only：192.168.221.130

### 网站设置

Nginx
- wp.sec.cuc.edu.cn
    - wordpress
    - 8082
- dvwa.sec.cuc.edu.cn
    - 8083

VeryNginx
- vn.sec.cuc.edu.cn
    - 8080
## 实验过程

### 软件配置与安装

#### nginx [Ubuntu18.04搭建nginx服务器](https://blog.csdn.net/fengfeng0328/article/details/82828224)


#### verynginx [alexazhou/VeryNginx](https://github.com/alexazhou/VeryNginx/blob/master/readme_zh.md)

#### DVWA [How to Install and Configure DVWA Lab on Ubuntu 18.04 server](https://kifarunix.com/how-to-setup-damn-vulnerable-web-app-lab-on-ubuntu-18-04-server/)

#### wordpress [How To Install WordPress with LEMP on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04#step-1-—-creating-a-mysql-database-and-user-for-wordpress)

### 实验要求
- 修改nginx配置，wordpress监听80端口，dvwa监听5566端口
- 在verynginx中配置端口转发
  - Basic_Matcher
  
  - Backend_Proxy Pass
  
  - 配置文件
  
  - 使用Wordpress搭建的站点对外提供访问的地址为： https://wp.sec.cuc.edu.cn 和 http://wp.sec.cuc.edu.cn
  
  - 使用[Damn Vulnerable Web Application (DVWA)](http://www.dvwa.co.uk/)搭建的站点对外提供访问的地址为： http://dvwa.sec.cuc.edu.cn。

  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa：8080.png)

### 安全加固要求

- 使用IP地址方式均无法访问上述任意站点，并向访客展示自定义的友好错误提示信息页面-1

	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/ip_matcher.png)
    
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/ip_response.png)
    
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/ip_filter.png)
    
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/ip_result.png)


- DVWA只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-2
	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_whiteip_matcher.png)
    
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_whiteip_response.png)
    
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_whiteip_filter.png)
    
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_whiteip_result.png)



- 在不升级Wordpress版本的情况下，通过定制VeryNginx的访问控制策略规则，热修复WordPress < 4.7.1 - Username Enumeration
	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/wp_matcher.png)
  
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/wp_response.png)
  
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/wp_filter.png)
  
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/wp_result.png)



- 通过配置VeryNginx的Filter规则实现对Damn Vulnerable Web Application (DVWA)的SQL注入实验在低安全等级条件下进行防护
	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_matcher.png)
  
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_response.png)
  
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_filter.png)
  
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/dvwa_result.png)
  


### VERYNGINX配置要求

- VeryNginx的Web管理页面仅允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-3

	- Basic_Matcher
   
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/vn_matcher.png)
	
  - Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/vn_response.png)
  
  - Custom Action_Filter
    
    ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/vn_filter.png)
  
  - 结果
  
	  ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/vn_result.png)


 - 通过定制VeryNginx的访问控制策略规则实现：
 
	  - 限制DVWA站点的单IP访问速率为每秒请求数 < 50
	  - 限制Wordpress站点的单IP访问速率为每秒请求数 < 20
    - 超过访问频率限制的请求直接返回自定义错误提示信息页面-4
	  
      ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/speed.png)
      ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/speed_limit.png)
  
    - 禁止curl访问
  
	    ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/curt.png)
      ![](https://github.com/CUCCS/linux-2019-QRiddle/blob/homework5/img/curt_stop.png)
