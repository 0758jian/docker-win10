### nginx php mysql redis配置步骤 
#### 一、开启BIOS的CPU虚拟化选项
#### 二、在win 10 程序和功能的windows功能，勾选Hyper-V
#### 三、下载Docker Desktop ```https://www.docker.com/products/docker-desktop```
#### 四、 CMD到目录，docker-compose up -d 开启服务或docker-compose down 关闭服务
#### 五、项目的版本控制请直接在win10里完成。
#### 六、 docker-compose exec app /bin/sh 进到容器内 因为dockerfile的php有装composer 所以cd 到相应目录composer install -vvv