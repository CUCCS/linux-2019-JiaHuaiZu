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
    - 443
- dvwa.sec.cuc.edu.cn
    - 8083
    - 5566
VeryNginx
- vn.sec.cuc.edu.cn
    - 8080
## 实验过程

### 软件配置与安装

#### nginx [Ubuntu18.04搭建nginx服务器](https://blog.csdn.net/fengfeng0328/article/details/82828224)
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/nginx.png)
#### verynginx [alexazhou/VeryNginx](https://github.com/alexazhou/VeryNginx/blob/master/readme_zh.md)
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/verynginx.png)
#### DVWA [How to Install and Configure DVWA Lab on Ubuntu 18.04 server](https://kifarunix.com/how-to-setup-damn-vulnerable-web-app-lab-on-ubuntu-18-04-server/)
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/DVWA.png)
#### wordpress [How To Install WordPress with LEMP on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04#step-1-—-creating-a-mysql-database-and-user-for-wordpress)
![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/wordpress.png)
### 实验要求
- 修改nginx配置，wordpress监听80端口，dvwa监听5566端口
- 在verynginx中配置端口转发
  - Basic_Matcher
  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/Basic_Matcher.png)
  - Backend_Proxy Pass
  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/Backend_Proxy.png)
  - 配置文件
  
  - 使用Wordpress搭建的站点对外提供访问的地址为： https://wp.sec.cuc.edu.cn 和 http://wp.sec.cuc.edu.cn
  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/forward_wp.png)
  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/forward_swp.png)
  - 使用[Damn Vulnerable Web Application (DVWA)](http://www.dvwa.co.uk/)搭建的站点对外提供访问的地址为： http://dvwa.sec.cuc.edu.cn
  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/forward_dvwa.png)

### 安全加固要求

- 使用IP地址方式均无法访问上述任意站点，并向访客展示自定义的友好错误提示信息页面-1

	- Basic_Matcher
  
	   ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/ip_request.png)
    
	- Basic_Response
  
	   ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/ip_refuse.png)
    
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/ip_request2.png)
    
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/-1.png)


- DVWA只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-2
	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_white_ip.png)
    
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_white.png)
    
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_white_ip2.png)
    
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/-2.png)



- 在不升级Wordpress版本的情况下，通过定制VeryNginx的访问控制策略规则，热修复WordPress < 4.7.1 - Username Enumeration
	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/wp4.1.7.png)
  
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/wp4.1.7_refuse.png)
  
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/wp4.1.7_2.png)
  
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/wp4.1.7_page.png)



- 通过配置VeryNginx的Filter规则实现对Damn Vulnerable Web Application (DVWA)的SQL注入实验在低安全等级条件下进行防护
	- Basic_Matcher
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_sql.png)
  
	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_sql_refuse.png)
  
	- Custom Action_Filter
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_sql2.png)
  
	- 结果
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/dvwa_sql_page.png)
  


### VERYNGINX配置要求

- VeryNginx的Web管理页面仅允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-3
	- Basic_Matcher
   
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/vn_white_ip.png)
	
  	- Basic_Response
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/vn_white_ip_refuse.png)
  
 	- Custom Action_Filter
    
    	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/vn_white_ip2.png)
  
  - 结果
  
	  ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/-3.png)

 - 通过定制VeryNginx的访问控制策略规则实现：
 
    - 限制DVWA站点的单IP访问速率为每秒请求数 < 50
    - 限制Wordpress站点的单IP访问速率为每秒请求数 < 20
    - 超过访问频率限制的请求直接返回自定义错误提示信息页面-4
	  
      ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/speed.png)
      ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/speed2.png)
  
    - 禁止curl访问
  
      ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/curl_stop.png)
      ![](https://github.com/CUCCS/linux-2019-JiaHuaiZu/blob/5th/5th/images/curl_stop2.png)
