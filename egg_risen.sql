-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: egg_risen
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article_types`
--

DROP TABLE IF EXISTS `article_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `orderNum` int NOT NULL COMMENT '显示排序',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_types`
--

LOCK TABLES `article_types` WRITE;
/*!40000 ALTER TABLE `article_types` DISABLE KEYS */;
INSERT INTO `article_types` VALUES (2,1,'linux','linux',1,'centos','2021-01-22 15:38:00','admin','2021-01-22 16:52:38','admin'),(3,1,'javascript','javascript',2,'javascript','2021-01-22 16:52:31','admin',NULL,NULL),(4,1,'react native','reactNative',3,'react native','2021-01-23 09:33:16','admin','2021-02-26 10:30:47','admin'),(6,2,'test','test',1,NULL,'2021-03-02 11:11:41','test',NULL,NULL);
/*!40000 ALTER TABLE `article_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `subTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '副标题',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `hot` int DEFAULT '0' COMMENT '热度',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (2,1,'docker安装好mysql','docker安装好mysql，Navicat连接报2059错误，解决方法','linux',0,'# docker安装好mysql，Navicat连接报2059错误，解决方法\n\ndocker成功安装了mysql，也正常启动了。\n\n启动命名如下：\n\n> docker run -itd --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql\n\n用docker ps -a 也可以查到容器中mysql也在运行中，\n\n但是在本地用Navicat登录的时候，发现报错了。报错信息\n\n连接Docker启动的mysql出现：**ERROR 2059 (HY000): Authentication plugin \'caching_sha2_password\' cannot be loaded**\n\n解决方案：\n1.进入mysql容器\n\n> docker exec -it mysql /bin/bash\n\n2.进入mysql\n\n> mysql -uroot -p\n\n3.修改密码\n\n> ALTER USER \'root\'@\'%\' IDENTIFIED WITH mysql_native_password BY \'123456\';\n\n修改好了之后，再用Navicat登录就可以了。','2021-01-22 15:39:16','admin','2021-01-23 11:29:48','admin'),(3,1,'centos安装配置','centos安装配置','linux',0,'# centos安装配置\n\n## 安装docker\n\n**设置仓库**\n\n安装所需的软件包。yum-utils 提供了 yum-config-manager ，并且 device mapper 存储驱动程序需要 device-mapper-persistent-data 和 lvm2。\n\n> sudo yum install -y yum-utils \\\n> device-mapper-persistent-data \\\n> lvm2\n\n使用以下命令来设置稳定的仓库。(清华大学源)\n\n> sudo yum-config-manager \\\n>     --add-repo \\\n>     http:**//**mirrors.aliyun.com**/**docker-ce**/**linux**/**centos**/**docker-ce.repo\n\n安装最新版本的 Docker Engine-Community 和 containerd，或者转到下一步安装特定版本：\n\n> sudo yum install docker-ce docker-ce-cli containerd.io\n\n#### 启动 Docker。\n\n> sudo systemctl start docker\n\n#### 开机自启动docker\n\n> su root   #切换用户\n>\n> systemctl enable docker   #开机自启动docker\n>\n> systemctl start docker   #启动docker\n>\n> systemctl restart docker  #重启docker\n\n### Ubuntu16.04+、Debian8+、CentOS7\n\n对于使用 systemd 的系统，请在 /etc/docker/daemon.conf中写入如下内容（如果文件不存在请新建该文件）：\n\n> {\"registry-mirrors\":[\"https://reg-mirror.qiniu.com/\"]}\n\n之后重新启动服务：\n\n> sudo systemctl daemon-reload\n>\n> sudo systemctl restart docker\n\n## Docker Compose 安装\n\n运行以下命令以下载 Docker Compose 的当前稳定版本：\n\n> sudo curl -L \"https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose\n\n要安装其他版本的 Compose，请替换 1.24.1。\n\n将可执行权限应用于二进制文件：\n\n> sudo chmod +x /usr/local/bin/docker-compose\n\n创建软链：\n\n> sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose\n\n测试是否安装成功：\n\n> docker-compose --version\n\n## Docker 安装 MySQL\n\nhttps://www.runoob.com/docker/docker-install-mysql.html\n\n\n\n','2021-01-22 16:20:09','admin','2021-01-23 11:29:24','admin'),(4,1,'安装DOClever','安装DOClever','linux',0,'# 安装DOClever\n\n> mkdir DOClever\n>\n> cd DOClever\n>\n> vim docker-compose.yml\n\ndocker-compose.yml配置：\n\n```\nversion: \"2\"\nservices:\n  DOClever:\n    image: lw96/doclever\n    restart: always\n    container_name: \"DOClever\"\n    ports:\n    - 10000:10000\n    volumes:\n    - ./file:/root/DOClever/data/file\n    - ./img:/root/DOClever/data/img\n    - ./tmp:/root/DOClever/data/tmp\n    environment:\n    - DB_HOST=mongodb://mongo:27017/DOClever\n    - PORT=10000\n    links:\n    - mongo:mongo\n\n  mongo:\n    image: mongo:latest\n    restart: always\n    container_name: \"mongodb\"\n    volumes:\n    - /my/own/datadir:/data/db\n```\n\n启动容器\n\n> docker-compose up -d\n\n访问\n\nhttp://你的ip:10000/\n\n管理员账号：\n\n> DOClever: DOClerve\n\n```\n- /my/own/datadir:/data/db\n```','2021-01-23 11:30:04','admin',NULL,NULL),(5,1,'centos 安装node','centos 安装node','linux',0,'# centos 安装node\n\n```\n// 下载node v14.12.0包，放到/var/local下\ncd /var/local\n// 解压\ntar -xvf node-v14.12.0-linux-x64.tar.xz\n// 进入/usr/local目录\ncd /usr/local/\n// 后面的.表示移动到当前目录\nmv /var/local/node-v14.12.0-linux-x64 .\n// 重命名\nmv node-v14.12.0-linux-x64/ nodejs\n\n// 让npm和node命令全局生效 - 软链接方式\nln -s /usr/local/nodejs/bin/npm /usr/local/bin/\nln -s /usr/local/nodejs/bin/node /usr/local/bin/\n\n// 查看\nnode -v\nnpm -v\n```\n\n','2021-01-23 11:30:24','admin','2021-02-26 10:28:14','admin'),(6,1,'在docker 运行node项目','在docker 运行node项目','javascript',0,'# 在docker 运行node项目\n\n拉取node镜像\n\n```bash\n# 最新版\ndocker pull node:latest\n# 固定版\ndocker pull node:12.13.0\n```\n\n运行镜像并复制当前路径项目到容器/home/www里面\n\n```bash\ndocker run -itd -p 7001:7001 --name node node:12.13.0 && docker cp . node:/home/www/\n```\n\n进入容器\n\n```bash\ndocker exec -it node bash\n// 进入项目\ncd /home/www/cms-api\nnpm install\n// 安装配置其他环境之后，如mysql，redis\nnpm run dev\n```\n\n','2021-01-23 11:30:45','admin',NULL,NULL),(7,1,'React Native搭配夜神模拟器调试(windows)','React Native搭配夜神模拟器调试(windows)','reactNative',0,'# React Native搭配夜神模拟器调试(windows)\n\n### React Native 搭配夜神模拟器进行调试 (windows)\n\n在学习 **React Native** 的过程中，我选择使用了夜神模拟器进行项目调试，接下来就来记录一下在使用模拟器之前的一些准备工作。\n\n首先你得先确保以下几个东西你都安装完成并且环境变量配置完成：\n\n1. Java 8\n2. Python 2.x\n3. node\n4. Android Studio\n5. adb\n\n接下去，win + R 打开命令行，进入到你的夜神安装目录bin文件夹，例如我的安装目录是 **D:\\Program Files\\Nox**，那我就输入如下指令\n\n```command\ncd D:\\Program Files\\Nox\\bin\n```\n\n进入到该目录后， 查询夜神模拟器的端口号，输入以下指令\n\n```command\nnox_adb devices\n```\n\n按回车，得到结果：\n![img](https://img-blog.csdnimg.cn/20190716144132960.jpg)\n红框中就是夜神模拟器的运行端口号，之后我们将adb与模拟器连接在一起\n\n进入android安装目录下的 Sdk\\platform-tools文件夹，默认应该在 **C:\\Users\\你的用户名\\AppData\\Local\\Android\\Sdk\\platform-tools** （此路径根据你自己的android安装路径）\n\n```command\ncd D:\\Android\\SDK\\platform-tools\nadb.exe connect 127.0.0.1:62001\n```\n\n出现 *successfully* 字样代表链接成功\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20190716145355647.jpg)\n接下去，你就可以执行 **react-native run-android** 在模拟器上进行调试了。','2021-02-26 10:31:12','admin',NULL,NULL);
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `deptId` int NOT NULL AUTO_INCREMENT,
  `parentId` int NOT NULL COMMENT '父Id',
  `deptName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名称',
  `orderNum` int NOT NULL COMMENT '显示顺序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '部门状态（1正常 0停用）',
  `isDelete` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`deptId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,0,'总部',1,'1','0','2021-01-08 12:04:02','admin',NULL,NULL),(2,1,'测试部门',1,'1','0','2021-01-08 12:04:02','admin',NULL,NULL),(5,2,'测试一部',2,'1','0','2021-02-02 17:41:01','test',NULL,NULL);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict_datas`
--

DROP TABLE IF EXISTS `dict_datas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict_datas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dictSort` int NOT NULL COMMENT '字典排序',
  `dictLabel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典标签',
  `dictValue` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典键值',
  `dictType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典类型',
  `cssClass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `listClass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `isDefault` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'Y' COMMENT '是否默认（Y是 N否）',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '菜单状态（1正常 0停用）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_datas`
--

LOCK TABLES `dict_datas` WRITE;
/*!40000 ALTER TABLE `dict_datas` DISABLE KEYS */;
INSERT INTO `dict_datas` VALUES (1,1,'正常','1','sys_show_hide',NULL,NULL,'Y','1','正常','2020-11-25 15:49:13','admin','2021-01-05 15:07:27','admin'),(2,2,'停用','0','sys_show_hide',NULL,NULL,'Y','1','停用','2020-11-25 15:49:13','admin','2021-01-05 15:07:29','admin'),(3,1,'正常','1','sys_normal_disable',NULL,NULL,'Y','1','正常','2020-11-25 15:49:13','admin','2021-01-05 15:07:36','admin'),(4,2,'停用','0','sys_normal_disable',NULL,NULL,'Y','1','停用','2020-11-25 15:49:13','admin','2021-01-05 15:07:39','admin'),(5,2,'男','1','sys_user_sex',NULL,NULL,'Y','1','男','2020-11-25 15:49:13','admin','2021-01-05 15:07:46','admin'),(6,1,'女','0','sys_user_sex',NULL,NULL,'Y','1','女','2020-11-25 15:49:13','admin','2021-01-05 15:07:44','admin'),(7,1,'公告','1','sys_notice_type',NULL,NULL,'Y','1','公告','2021-01-05 13:49:04','admin','2021-01-05 15:07:17','admin'),(8,2,'通知','2','sys_notice_type',NULL,NULL,'Y','1','通知','2021-01-05 13:49:18','admin','2021-01-05 15:07:20','admin'),(16,1,'启用','1','sys_notice_status',NULL,NULL,'Y','1','启用','2021-01-05 14:43:51','admin','2021-01-05 15:07:09','admin'),(17,2,'停用','2','sys_notice_status',NULL,NULL,'Y','1','停用','2021-01-05 14:44:07','admin','2021-01-05 15:07:12','admin');
/*!40000 ALTER TABLE `dict_datas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict_types`
--

DROP TABLE IF EXISTS `dict_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dictName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典名称',
  `dictType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典类型',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '菜单状态（1正常 2停用）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_types`
--

LOCK TABLES `dict_types` WRITE;
/*!40000 ALTER TABLE `dict_types` DISABLE KEYS */;
INSERT INTO `dict_types` VALUES (1,'显示状态','sys_show_hide','1','显示状态','2020-11-25 15:49:13','admin','2021-01-05 15:06:44','admin'),(2,'状态数据','sys_normal_disable','1','状态数据','2020-11-25 15:49:13','admin','2021-01-05 15:06:47','admin'),(3,'性别','sys_user_sex','1','性别','2020-11-25 15:49:13','admin','2021-01-05 15:06:49','admin'),(4,'公告类型','sys_notice_type','1','公告类型','2021-01-05 13:47:27','admin','2021-01-05 15:06:41','admin'),(5,'公告状态','sys_notice_status','1','公告状态','2021-01-05 13:48:00','admin','2021-01-05 15:06:37','admin');
/*!40000 ALTER TABLE `dict_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `ownerId` int DEFAULT '0' COMMENT '用户ID, 0：表示公共收藏。',
  `parentId` int DEFAULT '0' COMMENT '父级，目前限制3级目录创建。',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `orderNum` int NOT NULL DEFAULT '1' COMMENT '显示顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,'首页',1,0,'2022-02-23 11:04:10','2022-03-01 16:25:48','2022-02-23 11:04:19',1),(2,'导航',1,0,'2022-02-23 11:06:35','2022-03-01 16:37:27','2022-02-23 11:06:35',1),(27,'内部系统',1,2,'2022-02-25 08:06:25','2022-03-11 08:10:55',NULL,1),(31,'外部网址',1,2,'2022-03-07 14:16:43','2022-03-11 08:11:15',NULL,1),(32,'报表平台',1,2,'2022-03-10 15:16:53','2022-03-11 08:11:33',NULL,1),(33,'低代码平台',1,2,'2022-03-11 08:12:02',NULL,NULL,1),(99,'favorite',4,2,NULL,NULL,NULL,1),(102,'favorite',16,2,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites_group`
--

DROP TABLE IF EXISTS `favorites_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `favoriteId` int DEFAULT '0' COMMENT '收藏夹ID',
  `createdAt` datetime DEFAULT NULL,
  `orderNum` int DEFAULT NULL COMMENT '显示顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites_group`
--

LOCK TABLES `favorites_group` WRITE;
/*!40000 ALTER TABLE `favorites_group` DISABLE KEYS */;
INSERT INTO `favorites_group` VALUES (1,'信息类',31,NULL,1),(2,'生产类',27,NULL,2),(4,'办公类',27,NULL,1),(5,'信息类',27,NULL,3),(6,'技术类',27,NULL,4),(8,'银行类',31,NULL,2),(9,'Java',35,NULL,1),(10,'工具类',27,NULL,5),(11,'报表平台',32,NULL,1),(12,'信息类',33,NULL,2),(13,'应用类',33,NULL,1),(86,'favorite',99,NULL,1),(91,'favorite',102,NULL,1);
/*!40000 ALTER TABLE `favorites_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites_home`
--

DROP TABLE IF EXISTS `favorites_home`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites_home` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `groupId` int DEFAULT NULL COMMENT '分组id',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图标路径',
  `linkType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '类型：LINK,FILE',
  `linkUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '链接路径',
  `docUrl` varchar(255) DEFAULT NULL COMMENT '文档路径',
  `docName` varchar(255) DEFAULT NULL COMMENT '文档名称',
  `createdAt` datetime DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `daleteAt` datetime DEFAULT NULL,
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fileLink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `roleSort` int DEFAULT NULL COMMENT '显示顺序',
  `roleNote` varchar(255) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites_home`
--

LOCK TABLES `favorites_home` WRITE;
/*!40000 ALTER TABLE `favorites_home` DISABLE KEYS */;
INSERT INTO `favorites_home` VALUES (1,'新员工入职',19,'/uploads/undefined/CHP_1648627288331_rz@3x.jpg',NULL,'https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ',NULL,'rz@3x.jpg','2022-03-30 15:29:24',NULL,NULL,NULL,NULL,0,NULL),(2,'网盘使用',18,'/uploads/undefined/CHP_1648627445714_wp@3x.jpg',NULL,'',NULL,'wp@3x.jpg','2022-03-30 15:39:38',NULL,NULL,'网盘使用.pdf','/uploads/undefined/CHP_1648629986874_网盘使用.pdf',1,NULL),(3,'邮箱使用',18,'/uploads/undefined/CHP_1648627414445_yx@3x.jpg',NULL,'',NULL,'yx@3x.jpg','2022-03-30 15:39:58',NULL,NULL,'邮箱使用.pdf','/uploads/undefined/CHP_1648629998280_邮箱使用.pdf',2,NULL),(4,'打印机使用',18,'/uploads/undefined/CHP_1648627473184_dyj@3x.jpg',NULL,'',NULL,'dyj@3x.jpg','2022-03-30 15:40:16',NULL,NULL,'打印机使用.pdf','/uploads/undefined/CHP_1648630009497_打印机使用.pdf',3,NULL),(5,'无线网络设置',18,'/uploads/undefined/CHP_1648627387956_wx@3x.jpg',NULL,'',NULL,'wx@3x.jpg','2022-03-30 15:40:28',NULL,NULL,'无线网络设置.pdf','/uploads/undefined/CHP_1648630030319_无线网络设置.pdf',4,NULL),(6,'OA使用',19,'/uploads/undefined/CHP_1648627342014_oa@3x.jpg',NULL,'https://oa.risenenergy.com:333/',NULL,'oa@3x.jpg','2022-03-30 15:40:37',NULL,NULL,'','',5,NULL),(7,'云桌面使用',18,'/uploads/undefined/CHP_1648627682143_yzm@3x.jpg',NULL,'',NULL,'yzm@3x.jpg','2022-03-30 15:40:52',NULL,NULL,'云桌面使用.pdf','/uploads/undefined/CHP_1648630040348_云桌面使用.pdf',6,NULL),(8,'SSLVPN使用',18,'/uploads/undefined/CHP_1648627693711_vpn@3x.jpg',NULL,'',NULL,'vpn@3x.jpg','2022-03-30 15:41:04',NULL,NULL,'SSLVPN使用.pdf','/uploads/undefined/CHP_1648630050050_SSLVPN使用.pdf',7,NULL),(9,'分子公司资料汇总',19,'/uploads/undefined/CHP_1648627711954_gszl@3x.jpg',NULL,'https://tqs0cvli0t.jiandaoyun.com/dash/5fe42a5d2f9d920007d688b2',NULL,'gszl@3x.jpg','2022-03-30 15:41:15',NULL,NULL,'','',8,NULL);
/*!40000 ALTER TABLE `favorites_home` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites_home_group`
--

DROP TABLE IF EXISTS `favorites_home_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites_home_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `className` varchar(255) DEFAULT NULL,
  `roleSort` int DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites_home_group`
--

LOCK TABLES `favorites_home_group` WRITE;
/*!40000 ALTER TABLE `favorites_home_group` DISABLE KEYS */;
INSERT INTO `favorites_home_group` VALUES (18,'文件',2,'2022-04-12 14:22:45'),(19,'外部链接',1,'2022-04-12 14:22:51');
/*!40000 ALTER TABLE `favorites_home_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites_links`
--

DROP TABLE IF EXISTS `favorites_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `linkType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'LINK' COMMENT '链接类型，默认：‘LINK’',
  `groupId` int DEFAULT NULL COMMENT '分组ID',
  `groupName` varchar(255) DEFAULT NULL COMMENT '收藏分组',
  `ownerId` int NOT NULL COMMENT 'ownerId',
  `favoriteId` int DEFAULT NULL COMMENT '收藏夹ID',
  `url` varchar(500) DEFAULT NULL COMMENT '链接地址',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称，标题',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `logo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'logo地址',
  `orderNum` int DEFAULT NULL COMMENT '排序',
  `status` varchar(255) DEFAULT '1' COMMENT '状态，1：启用，0：禁用',
  `linkId` int DEFAULT NULL COMMENT '公共收藏ID，用于显示是否公共收藏。',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `parentId` int DEFAULT NULL COMMENT 'parentId 当复制到个人导航中是复制id到parentId',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites_links`
--

LOCK TABLES `favorites_links` WRITE;
/*!40000 ALTER TABLE `favorites_links` DISABLE KEYS */;
INSERT INTO `favorites_links` VALUES (52,'LINK',2,NULL,1,27,'https://docs.risenenergy.com','东方日升 - Powered by 东方日升','东方日升文档共享平台为在线文档管理和办公平台，协同操作更加便捷，存储环境安全可控；界面延用windows风格、保留用户操作习惯，简单培训就可快速上手；支持常用办公文件在线预览、播放和编辑，格式兼容性强，运行顺畅，功能强大。','https://docs.risenenergy.com/https://docs.risenenergy.com/static/images/icon/fav.png?v=1.23.0923',3,'1',NULL,'2022-03-11 09:15:42',NULL,NULL,NULL),(56,'LINK',4,NULL,1,27,'http://www.rsztb.com/','东方日升采购与招标网','东方日升采购与招标网','http://www.rsztb.com/undefined',6,'1',NULL,'2022-03-28 15:31:52','2022-03-31 10:03:52',NULL,NULL),(57,'LINK',9,NULL,3,35,'https://www.python.org/','Welcome to Python.org','The official home of the Python Programming Language','https://www.python.org/undefined',1,'1',NULL,'2022-03-29 15:32:53','2022-04-01 08:20:02',NULL,NULL),(58,'LINK',4,NULL,1,27,'https://report.risen.com/','Risen Data Visualization Platform',NULL,'https://report.risen.com/undefined',5,'1',NULL,'2022-03-29 15:34:28','2022-03-31 10:03:52',NULL,NULL),(59,'LINK',4,NULL,1,27,'https://edu.risenenergy.com/','东方日升培训中心管理系统',NULL,'https://edu.risenenergy.com/undefined',4,'1',NULL,'2022-03-29 15:36:16','2022-03-31 10:03:52',NULL,NULL),(61,'LINK',2,NULL,1,27,'http://diandian.cloud/','点点云中台系统——Sunallies Center',NULL,'http://diandian.cloud/undefined',1,'1',NULL,'2022-03-29 16:27:37',NULL,NULL,NULL),(63,'LINK',1,NULL,1,31,'https://www.aliyun.com/','阿里云-上云就上阿里云','阿里云——阿里巴巴集团旗下公司，是全球领先的云计算及人工智能科技公司。提供免费试用、云服务器、云数据库、云安全、云企业应用等云计算服务，以及大数据、人工智能服务、精准定制基于场景的行业解决方案。免费备案，7x24小时售后支持，助企业无忧上云。','https://www.aliyun.com/undefined',1,'1',NULL,'2022-03-30 09:19:09',NULL,NULL,NULL),(64,'LINK',4,NULL,1,27,'https://www.risenenergy.com/','东方日升新能源股份有限公司','东方日升新能源股份有限公司始创于1986年，注册资本904,616,941元。 2010年9月，成功在深交所创业板上市，股票代码300118。 公司主要从事光伏并网发电系统、光伏独立供电系统、太阳能电池片、组件等的研发、生产和销售。','https://www.risenenergy.com/undefined',2,'1',NULL,'2022-03-30 12:55:19','2022-03-31 10:03:52',NULL,NULL),(68,'LINK',4,NULL,1,27,'https://oa.risenenergy.com:333/','OA','泛微“智能化、平台化、全程电子化”移动办公平台','https://oa.risenenergy.com:333/favicon.ico',1,'1',NULL,'2022-03-30 13:08:20','2022-03-31 10:03:52',NULL,NULL),(69,'LINK',4,NULL,1,27,'https://srm.risenenergy.com/','东方日升企业采购系统',NULL,'https://srm.risenenergy.com/undefined',0,'1',NULL,'2022-03-30 13:49:09','2022-03-31 10:03:52',NULL,NULL),(70,'LINK',4,NULL,1,27,'http://web.risenenergy.com:555/anonymous/index2.jsp','总裁信箱','总裁信箱','http://web.risenenergy.com:555/favicon.ico',3,'1',NULL,'2022-03-30 13:51:36','2022-03-31 10:03:52',NULL,NULL),(71,'LINK',2,NULL,1,27,'http://10.80.1.22:8088/mycim2/login/login.html','义乌MES','车间mes系统','http://10.80.1.22:8088/undefined',1,'1',NULL,'2022-03-30 14:03:14','2022-03-30 14:04:34',NULL,NULL),(72,'LINK',2,NULL,1,27,'http://mesinfo.risenenergy.com/','生产数据统计','Web site created using create-react-app','http://mesinfo.risenenergy.com/undefined',1,'1',NULL,'2022-03-30 14:05:21',NULL,NULL,NULL),(73,'LINK',5,NULL,1,27,'https://pan.risenenergy.com:5001/','东方日升.企业网盘','Synology NAS 提供功能完整的网络存储 (NAS) 解决方案，可让您轻松管理及备份数据，并在 Windows、Mac 及 Linux 计算机之间分享数据。','https://pan.risenenergy.com:5001/undefined',1,'1',NULL,'2022-03-30 14:12:06',NULL,NULL,NULL),(74,'LINK',5,NULL,1,27,'http://dvs.risenenergy.com/','Risen Data Visualization Platform',NULL,'http://dvs.risenenergy.com/undefined',1,'1',NULL,'2022-03-30 14:12:35',NULL,NULL,NULL),(75,'LINK',5,NULL,1,27,'https://mail.risenenergy.com/','邮件','邮件','https://mail.risenenergy.com/favicon.ico',1,'1',NULL,'2022-03-30 14:13:05',NULL,NULL,NULL),(76,'LINK',6,NULL,1,27,'http://task.risen.com/','需求记录',NULL,'http://task.risen.com/favicon.ico',1,'1',NULL,'2022-03-30 14:18:14','2022-03-30 14:37:19',NULL,NULL),(77,'LINK',6,NULL,1,27,'http://gitlab.risenenergy.com/','Sign in · GitLab','GitLab Community Edition','http://gitlab.risenenergy.com//assets/favicon-7901bd695fb93edb07975966062049829afb56cf11511236e61bcf425070e36e.png',1,'1',NULL,'2022-03-30 14:28:09',NULL,NULL,NULL),(78,'LINK',6,NULL,1,27,'http://gitlab.risenenergy.com/','Sign in · GitLab','GitLab Community Edition','http://gitlab.risenenergy.com//assets/favicon-7901bd695fb93edb07975966062049829afb56cf11511236e61bcf425070e36e.png',1,'1',NULL,'2022-03-30 14:28:09',NULL,NULL,NULL),(79,'LINK',6,NULL,1,27,'http://gitlab.risenenergy.com/','Sign in · GitLab','GitLab Community Edition','http://gitlab.risenenergy.com//assets/favicon-7901bd695fb93edb07975966062049829afb56cf11511236e61bcf425070e36e.png',1,'1',NULL,'2022-03-30 14:28:13',NULL,NULL,NULL),(80,'LINK',6,NULL,1,27,'http://nexus.risenenergy.com:8081/','Nexus Repository Manager','Nexus Repository Manager','http://nexus.risenenergy.com:8081/./static/rapture/resources/favicon.ico?_v=3.37.3-02&_e=OSS',1,'1',NULL,'2022-03-30 14:28:39',NULL,NULL,NULL),(81,'LINK',6,NULL,1,27,'https://oma.risenenergy.com/','登录-明御运维审计与风险控制系统',NULL,'https://oma.risenenergy.com/undefined',1,'1',NULL,'2022-03-30 14:29:52',NULL,NULL,NULL),(82,'LINK',10,NULL,1,27,'http://guide.risenenergy.com/src/color.html','网页设计常用色彩搭配表 - 配色表\"','色彩搭配看似复杂，但并不神秘。既然每种色彩在印象空间中都有自己的位置，那么色彩搭配得到的印象可以用加减法来近似估算。将网页设计中常见的色彩搭配按照色相的顺序归类。搭配起来就会得到千变万化的感觉。','http://guide.risenenergy.com/favicon.ico',1,'1',NULL,'2022-03-30 14:35:03','2022-03-30 14:36:19',NULL,NULL),(83,'LINK',1,NULL,1,31,'https://www.jiandaoyun.com/','「简道云官网」零代码轻量级应用搭建平台','简道云是零代码的应用搭建平台，可以帮助各行业人员在不使用代码的情况下搭建个性化的CRM、ERP、OA、项目管理、进销存等系统，产品包含自定义表单、自定义报表、自定义流程引擎、知识库、团队协作等功能，适用于各种业务场景。','https://www.jiandaoyun.com//favicon.ico',1,'1',NULL,'2022-03-30 14:47:21',NULL,NULL,NULL),(84,'LINK',8,NULL,1,31,'https://inv-veri.chinatax.gov.cn/index.html','增值税发票查验平台','国家税务总局全国增值税发票查验平台','https://inv-veri.chinatax.gov.cn/favicon.ico',1,'1',NULL,'2022-03-30 14:48:45','2022-03-30 14:51:20',NULL,NULL),(85,'LINK',8,NULL,1,31,'https://www.abchina.com/cn/','中国农业银行','中国农业银行','https://www.abchina.com/undefined',1,'1',NULL,'2022-03-30 14:49:18','2022-03-30 14:50:38',NULL,NULL),(86,'LINK',11,NULL,1,32,'http://dvs.risenenergy.com/datav/z3/','智能制造[组3]','组三生产车间智能制造入口','http://dvs.risenenergy.com/undefined',1,'1',NULL,'2022-03-30 14:55:28','2022-03-30 15:18:15',NULL,NULL),(88,'LINK',13,NULL,1,33,'https://esbtest.risen.com/dev/v1/jdy_equipment_management_index','设备管理与巡检平台','设备管理与巡检平台','https://esbtest.risen.com/favicon.ico',1,'1',NULL,'2022-03-30 14:58:24','2022-03-30 15:13:06',NULL,NULL),(89,'LINK',13,NULL,1,33,'https://esbtest.risen.com/dev/v1/jdy_resource_management','虚拟化资源管理平台','虚拟化资源管理平台','https://esbtest.risen.com/favicon.ico',1,'1',NULL,'2022-03-30 14:59:11','2022-03-30 15:12:39',NULL,NULL),(90,'LINK',13,NULL,1,33,'https://esbtest.risen.com/dev/v1/jdy_power_facilities','义乌动力设施巡检平台','义乌动力设施巡检平台','https://esbtest.risen.com/favicon.ico',1,'1',NULL,'2022-03-30 14:59:45','2022-03-30 15:11:31',NULL,NULL),(91,'LINK',12,NULL,1,33,'https://esbtest.risen.com/dev/v1/jdy_price_comparison','采购询比价','采购询比价','https://esbtest.risen.com/favicon.ico',1,'1',NULL,'2022-03-30 15:01:16','2022-03-30 15:05:13',NULL,NULL),(92,'LINK',12,NULL,1,33,'https://esbtest.risen.com/dev/v1/jdy_dormitory_manage','宿舍管理平台','宿舍管理平台','https://esbtest.risen.com/favicon.ico',1,'1',NULL,'2022-03-30 15:02:03','2022-03-30 15:05:37',NULL,NULL),(197,'LINK',86,NULL,4,99,'https://juejin.cn/post','掘金 - 代码不止，掘金不停','掘金是一个帮助开发者成长的社区,是给开发者用的 Hacker News,给设计师用的 Designer News,和给产品经理用的 Medium。掘金的技术文章由稀土上聚集的技术大牛和极客共同编辑为你筛选出最优质的干货,其中包括：Android、iOS、前端、后端等方面的内容。用户每天都可以在这里找到技术世界的头条内容。与此同时,掘金内还有沸点、掘金翻译计划、线下活动、专栏文章等内容。即使你是 GitHub、StackOverflow、开源中国的用户,我们相信你也可以在这里有所收获。','https://juejin.cn/favicon.ico',10,'1',NULL,'2022-04-12 15:24:18','2022-04-25 08:13:18',NULL,NULL),(204,'LINK',86,NULL,4,99,'https://www.zhihu.com/','知乎 - 有问题，就会有答案','知乎，中文互联网高质量的问答社区和创作者聚集的原创内容平台，于 2011 年 1 月正式上线，以「让人们更好的分享知识、经验和见解，找到自己的解答」为品牌使命。知乎凭借认真、专业、友善的社区氛围、独特的产品机制以及结构化和易获得的优质内容，聚集了中文互联网科技、商业、影视、时尚、文化等领域最具创造力的人群，已成为综合性、全品类、在诸多领域具有关键影响力的知识分享社区和创作者聚集的原创内容平台，建立起了以社区驱动的内容变现商业模式。','https://static.zhihu.com/heifetz/favicon.ico',5,'1',NULL,'2022-04-13 10:55:19','2022-04-25 08:13:17',NULL,NULL),(205,'LINK',86,NULL,4,99,'https://vuex.vuejs.org/','What is Vuex? | Vuex','Centralized State Management for Vue.js','https://vuex.vuejs.org/favicon.ico',2,'1',NULL,'2022-04-13 10:58:30','2022-04-25 08:13:17',NULL,NULL),(206,'LINK',86,NULL,4,99,'https://vitepress.vuejs.org/','What is VitePress? | VitePress','Vite & Vue powered static site generator.','https://vitepress.vuejs.org/favicon.ico',6,'1',NULL,'2022-04-15 10:14:05','2022-04-25 08:13:18',NULL,NULL),(209,'LINK',86,NULL,4,99,'https://oa.risenenergy.com:333/','OA','泛微“智能化、平台化、全程电子化”移动办公平台','https://oa.risenenergy.com:333/favicon.ico',8,'1',NULL,'2022-04-18 10:53:14','2022-04-25 08:13:18',NULL,68),(212,'LINK',86,NULL,4,99,'https://www.haorooms.com/post/xmlhttprequest_responseurl','Haorooms博客-前端博客-前端技术，记录web前端开发的技术博客','Haorooms，Aaron个人博客。记录本人工作中遇到的问题，以及经验总结和分享！','https://www.haorooms.com/favicon.ico',0,'1',NULL,'2022-04-20 07:32:36','2022-04-25 08:13:17',NULL,NULL),(219,'LINK',91,NULL,16,102,'https://oma.risenenergy.com/index.php/','登录-明御运维审计与风险控制系统',NULL,'https://oma.risenenergy.com/favicon.ico',1,'1',NULL,'2022-04-22 09:15:34',NULL,NULL,NULL),(220,'LINK',86,NULL,4,99,'https://oma.risenenergy.com/index.php','登录-明御运维审计与风险控制系统',NULL,'https://oma.risenenergy.com/favicon.ico',1,'1',NULL,'2022-04-25 08:24:44',NULL,NULL,NULL),(221,'LINK',86,NULL,4,99,'https://juejin.cn/post','掘金 - 代码不止，掘金不停','掘金是一个帮助开发者成长的社区,是给开发者用的 Hacker News,给设计师用的 Designer News,和给产品经理用的 Medium。掘金的技术文章由稀土上聚集的技术大牛和极客共同编辑为你筛选出最优质的干货,其中包括：Android、iOS、前端、后端等方面的内容。用户每天都可以在这里找到技术世界的头条内容。与此同时,掘金内还有沸点、掘金翻译计划、线下活动、专栏文章等内容。即使你是 GitHub、StackOverflow、开源中国的用户,我们相信你也可以在这里有所收获。','https://juejin.cn/favicon.ico',1,'1',NULL,'2022-04-25 09:25:45',NULL,NULL,NULL);
/*!40000 ALTER TABLE `favorites_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendly_links`
--

DROP TABLE IF EXISTS `friendly_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendly_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '链接',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendly_links`
--

LOCK TABLES `friendly_links` WRITE;
/*!40000 ALTER TABLE `friendly_links` DISABLE KEYS */;
INSERT INTO `friendly_links` VALUES (3,1,'baidu','https://www.baidu.com/?tn=78000241_22_hao_pg','baidu','2021-01-23 13:35:18','admin','2021-01-23 14:08:40','admin');
/*!40000 ALTER TABLE `friendly_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网址',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip地址',
  `favorite` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'favorite',
  `favoriteGroup` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'favorite分类',
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日期',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (15,'guest','LINK','https://srm.risenenergy.com/','211.91.61.115','内部系统','办公类','2022-4-14',NULL),(16,'R-69261','LINK','https://srm.risenenergy.com/','211.91.61.115','内部系统','办公类','2022-4-14',NULL),(17,'R-69261','LINK','https://oa.risenenergy.com:333/','211.91.61.115','内部系统','办公类','2022-4-14',NULL),(18,'R-69261','LINK','https://edu.risenenergy.com/','211.91.61.115','内部系统','办公类','2022-4-14','2022-04-14 12:41:12'),(19,'R-69261','LINK','https://e-cloudstore.com/','211.91.61.115','favorite','favorite','2022-4-14','2022-04-14 12:56:17'),(20,'R-69261','LINK','https://juejin.cn/post','211.91.61.115','favorite','favorite','2022-4-14','2022-04-14 13:00:48'),(21,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-14','2022-04-14 14:06:25'),(22,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-14','2022-04-14 14:08:36'),(23,'guest','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-14','2022-04-14 14:08:36'),(24,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-14','2022-04-14 14:09:08'),(25,'guest','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-14','2022-04-14 14:09:17'),(26,'guest','LINK','https://oa.risenenergy.com:333/','211.91.61.115','home','外部链接','2022-4-14','2022-04-14 14:09:19'),(27,'guest','LINK','https://tqs0cvli0t.jiandaoyun.com/dash/5fe42a5d2f9d920007d688b2','211.91.61.115','home','外部链接','2022-4-14','2022-04-14 14:10:39'),(28,'R-69261','LINK','https://vitepress.vuejs.org/','211.91.61.115','favorite','favorite','2022-4-15','2022-04-15 10:14:19'),(29,'R-69261','LINK','https://www.jiandaoyun.com/','211.91.61.115','外部网址','信息类','2022-4-18','2022-04-18 10:07:05'),(30,'R-69261','LINK','https://srm.risenenergy.com/','211.91.61.115','内部系统','办公类','2022-4-18','2022-04-18 10:17:02'),(31,'R-69261','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-18','2022-04-18 10:52:47'),(32,'R-69261','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-18','2022-04-18 10:52:54'),(33,'R-69261','LINK','http://web.risenenergy.com:555/anonymous/index2.jsp','211.91.61.115','内部系统','办公类','2022-4-18','2022-04-18 14:31:52'),(34,'R-69261','LINK','https://srm.risenenergy.com/','211.91.61.115','内部系统','办公类','2022-4-18','2022-04-18 14:31:53'),(35,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:07:37'),(36,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:07:40'),(37,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:01'),(38,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:02'),(39,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:02'),(40,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:02'),(41,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:02'),(42,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:03'),(43,'guest','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:03'),(44,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:04'),(45,'guest','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:04'),(46,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:04'),(47,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:05'),(48,'guest','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:05'),(49,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:17'),(50,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:21'),(51,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:22'),(52,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:24'),(53,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:26'),(54,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:27'),(55,'guest','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:34'),(56,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:09:41'),(57,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:10:08'),(58,'guest','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:10:10'),(59,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:10:12'),(60,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:10:16'),(61,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:11:22'),(62,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:11:24'),(63,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:17:01'),(64,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:17:01'),(65,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:17:01'),(66,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:17:02'),(67,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:17:03'),(68,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:17:03'),(69,'guest','LINK','https://tqs0cvli0t.jiandaoyun.com/dash/5fe42a5d2f9d920007d688b2','122.227.174.42','home','外部链接','2022-4-20','2022-04-20 13:17:14'),(70,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:54'),(71,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:54'),(72,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:54'),(73,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:55'),(74,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:55'),(75,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:56'),(76,'guest','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:56'),(77,'guest','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:57'),(78,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-20','2022-04-20 13:18:57'),(79,'guest','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-20','2022-04-20 13:18:58'),(80,'admin','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:12:12'),(81,'admin','FILE','打印机使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:12:48'),(82,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:21:21'),(83,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:21:23'),(84,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:24:54'),(85,'admin','LINK','test','211.91.61.115','home','外部链接','2022-4-20','2022-04-20 16:40:23'),(86,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:40:36'),(87,'admin','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-20','2022-04-20 16:40:40'),(88,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','211.91.61.115','home','外部链接','2022-4-20','2022-04-20 16:40:43'),(89,'admin','LINK','test','211.91.61.115','home','外部链接','2022-4-21','2022-04-21 09:26:23'),(90,'admin','LINK','http://www.baidu.com','211.91.61.115','home','外部链接','2022-4-21','2022-04-21 09:26:55'),(91,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 11:11:29'),(92,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 11:11:38'),(93,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 11:11:38'),(94,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 11:11:38'),(95,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 11:11:40'),(96,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 11:11:43'),(97,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 13:24:08'),(98,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 14:24:24'),(99,'guest','FILE','云桌面使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 14:30:31'),(100,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 14:41:16'),(101,'admin','FILE','打印机使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 14:41:23'),(102,'admin','FILE','云桌面使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 14:41:45'),(103,'admin','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:42:36'),(104,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:42:40'),(105,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:42:49'),(106,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:42:52'),(107,'admin','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:42:57'),(108,'admin','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:43:03'),(109,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:43:07'),(110,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:48:23'),(111,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:48:23'),(112,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:49:34'),(113,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:50:53'),(114,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:51:15'),(115,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:53:16'),(116,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:53:26'),(117,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:53:47'),(118,'admin','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:53:52'),(119,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-21','2022-04-21 14:53:56'),(120,'admin','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:54:10'),(121,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:54:15'),(122,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:55:01'),(123,'guest','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:55:03'),(124,'guest','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:55:05'),(125,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:55:30'),(126,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:55:39'),(127,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 14:56:17'),(128,'admin','LINK','https://tqs0cvli0t.jiandaoyun.com/dash/5fe42a5d2f9d920007d688b2','211.91.61.115','home','外部链接','2022-4-21','2022-04-21 14:59:31'),(129,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:06:51'),(130,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:18'),(131,'admin','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:21'),(132,'admin','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:27'),(133,'admin','FILE','云桌面使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:29'),(134,'admin','FILE','无线网络设置.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:31'),(135,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:34'),(136,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:42'),(137,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:44'),(138,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:45'),(139,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:45'),(140,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:45'),(141,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:46'),(142,'guest','FILE','打印机使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:46'),(143,'guest','FILE','打印机使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:47'),(144,'guest','FILE','无线网络设置.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:48'),(145,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:54'),(146,'admin','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:57'),(147,'admin','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:08:59'),(148,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:43'),(149,'guest','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:47'),(150,'guest','FILE','打印机使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:51'),(151,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:52'),(152,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:52'),(153,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:52'),(154,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:53'),(155,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:53'),(156,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:53'),(157,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:53'),(158,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:54'),(159,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:54'),(160,'guest','FILE','云桌面使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:55'),(161,'guest','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:56'),(162,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:10:56'),(163,'guest','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:11:01'),(164,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:11:40'),(165,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:28'),(166,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:29'),(167,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:29'),(168,'guest','FILE','云桌面使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:29'),(169,'guest','FILE','SSLVPN使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:30'),(170,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:30'),(171,'guest','FILE','邮箱使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:30'),(172,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:12:47'),(173,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-21','2022-04-21 15:13:22'),(174,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:13:39'),(175,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:15:26'),(176,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:16:17'),(177,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:17:44'),(178,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:17:55'),(179,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:18:09'),(180,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:21:01'),(181,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:21:12'),(182,'R-69261','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:21:26'),(183,'guest','LINK','https://oa.risenenergy.com:333/','122.227.174.42','home','外部链接','2022-4-21','2022-04-21 15:22:32'),(184,'guest','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:39'),(185,'guest','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:41'),(186,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:44'),(187,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:44'),(188,'guest','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:45'),(189,'guest','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:46'),(190,'guest','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:46'),(191,'guest','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:48'),(192,'guest','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:49'),(193,'guest','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:22:50'),(194,'R-69261','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:26:37'),(195,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:26:45'),(196,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:26:56'),(197,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:27:04'),(198,'admin','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:27:07'),(199,'R-69261','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:27:14'),(200,'R-69261','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:27:19'),(201,'R-70298','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:27:36'),(202,'R-70298','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-21','2022-04-21 15:27:39'),(203,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:28:06'),(204,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:28:07'),(205,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:28:31'),(206,'guest','LINK','https://oa.risenenergy.com:333/','122.227.174.42','home','外部链接','2022-4-21','2022-04-21 15:30:04'),(207,'guest','LINK','https://tqs0cvli0t.jiandaoyun.com/dash/5fe42a5d2f9d920007d688b2','122.227.174.42','home','外部链接','2022-4-21','2022-04-21 15:30:07'),(208,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:30:11'),(209,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:35:23'),(210,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:35:26'),(211,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:36:10'),(212,'guest','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:36:21'),(213,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:49:35'),(214,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:49:46'),(215,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:49:49'),(216,'admin','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:49:58'),(217,'admin','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:50:05'),(218,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:50:23'),(219,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:50:32'),(220,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:50:47'),(221,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:52:46'),(222,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:52:54'),(223,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:53:03'),(224,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:56:58'),(225,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:04'),(226,'admin','FILE','打印机使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:07'),(227,'admin','FILE','无线网络设置.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:09'),(228,'admin','FILE','云桌面使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:13'),(229,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:14'),(230,'admin','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:21'),(231,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:57:24'),(232,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:59:00'),(233,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 15:59:07'),(234,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-21','2022-04-21 16:02:38'),(235,'admin','FILE','网盘使用.pdf','0.0.0.0','home','文件','2022-4-21','2022-04-21 16:21:31'),(236,'admin','FILE','网盘使用.pdf','0.0.0.0','home','文件','2022-4-21','2022-04-21 16:22:40'),(237,'R-69530','LINK','https://oma.risenenergy.com/index.php/om?asset_search=&asset_search_type=&ruleid=&vpcid=&osid=&encoding=&astgroup_id=&offset=0&limit=20&count=&ctoken=6126ec861073ea5502b91328e0288739306a8132','211.91.61.115','favorite','favorite','2022-4-22','2022-04-22 09:13:07'),(238,'R-69530','LINK','https://oma.risenenergy.com/index.php/om','211.91.61.115','favorite','favorite','2022-4-22','2022-04-22 09:14:11'),(239,'R-69530','LINK','https://oma.risenenergy.com/index.php/om','122.227.174.42','favorite','favorite','2022-4-22','2022-04-22 09:15:09'),(240,'R-69530','LINK','https://oma.risenenergy.com/index.php/','122.227.174.42','favorite','favorite','2022-4-22','2022-04-22 09:15:37'),(241,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-22','2022-04-22 11:44:28'),(242,'R-69530','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-22','2022-04-22 13:26:11'),(243,'guest','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-22','2022-04-22 13:58:28'),(244,'guest','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-22','2022-04-22 13:58:33'),(245,'admin','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-22','2022-04-22 17:06:44'),(246,'R-69261','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-24','2022-04-24 08:16:00'),(247,'R-69261','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-24','2022-04-24 08:16:04'),(248,'guest','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-24','2022-04-24 09:01:23'),(249,'guest','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-24','2022-04-24 09:01:27'),(250,'R-70298','FILE','网盘使用.pdf','211.91.61.115','home','文件','2022-4-24','2022-04-24 09:02:26'),(251,'R-70298','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-24','2022-04-24 09:03:25'),(252,'R-70298','FILE','SSLVPN使用.pdf','122.227.174.42','home','文件','2022-4-24','2022-04-24 09:03:33'),(253,'R-70298','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-24','2022-04-24 16:37:57'),(254,'R-70298','LINK','https://oa.risenenergy.com:333/','122.227.174.42','home','外部链接','2022-4-24','2022-04-24 16:38:27'),(255,'R-69261','LINK','https://vuex.vuejs.org/','122.227.174.42','favorite','favorite','2022-4-24','2022-04-24 16:53:31'),(256,'R-69261','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-25','2022-04-25 08:15:45'),(257,'R-69261','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-25','2022-04-25 08:15:50'),(258,'R-69261','LINK','https://www.haorooms.com/post/xmlhttprequest_responseurl','122.227.174.42','favorite','favorite','2022-4-25','2022-04-25 08:36:14'),(259,'R-69261','LINK','https://juejin.cn/post','122.227.174.42','favorite','favorite','2022-4-25','2022-04-25 09:25:35'),(260,'R-69261','LINK','https://oma.risenenergy.com/index.php/dashboard','122.227.174.42','favorite','favorite','2022-4-25','2022-04-25 14:13:02'),(261,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-27','2022-04-27 10:02:12'),(262,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-27','2022-04-27 10:02:20'),(263,'admin','FILE','网盘使用.pdf','122.227.174.42','home','文件','2022-4-27','2022-04-27 10:02:35'),(264,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','home','外部链接','2022-4-27','2022-04-27 10:08:37'),(265,'admin','FILE','邮箱使用.pdf','122.227.174.42','home','文件','2022-4-27','2022-04-27 10:08:52'),(266,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-27','2022-04-27 10:09:43'),(267,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-27','2022-04-27 10:10:40'),(268,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','211.91.61.115','home','外部链接','2022-4-27','2022-04-27 11:15:22'),(269,'admin','LINK','https://oa.risenenergy.com:333/','211.91.61.115','home','外部链接','2022-4-27','2022-04-27 11:33:27'),(270,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','211.91.61.115','home','外部链接','2022-4-27','2022-04-27 15:55:48'),(272,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','211.91.61.115','home','外部链接','2022-4-27','2022-04-27 16:37:28'),(273,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:53:20'),(274,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:55:12'),(275,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:55:23'),(276,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:57:53'),(277,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:59:18'),(278,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:59:21'),(279,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:59:24'),(280,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 15:59:35'),(281,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:00:04'),(282,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:00:48'),(283,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:01:27'),(284,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:01:34'),(285,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:04:09'),(286,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:05:02'),(287,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:06:51'),(288,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:07:27'),(289,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:08:39'),(290,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:10:27'),(291,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:11:46'),(292,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:11:56'),(293,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:15:11'),(294,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:15:50'),(295,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:15:54'),(296,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:15:59'),(297,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:16:12'),(298,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:16:31'),(299,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-29','2022-04-29 16:17:55'),(300,'admin','LINK','https://mp.weixin.qq.com/s/eoypPeXcfw1xHfyX3jLjRQ','122.227.174.42','home','外部链接','2022-4-29','2022-04-29 16:20:28'),(301,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:20:52'),(302,'admin','LINK','https://srm.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:22:12'),(303,'admin','LINK','https://www.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:23:02'),(304,'admin','LINK','https://www.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:23:26'),(305,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:23:45'),(306,'admin','LINK','http://web.risenenergy.com:555/anonymous/index2.jsp','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:24:09'),(307,'admin','LINK','https://www.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:24:50'),(308,'admin','LINK','https://edu.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:25:41'),(309,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:26:04'),(310,'admin','LINK','https://edu.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:26:11'),(311,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:26:33'),(312,'admin','LINK','https://edu.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:27:18'),(313,'admin','LINK','https://edu.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:27:31'),(314,'admin','LINK','https://edu.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:28:02'),(315,'admin','LINK','https://edu.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:29:10'),(316,'admin','LINK','https://www.risenenergy.com/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:29:20'),(317,'admin','LINK','http://web.risenenergy.com:555/anonymous/index2.jsp','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:29:27'),(318,'admin','LINK','http://web.risenenergy.com:555/anonymous/index2.jsp','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:42:54'),(319,'admin','LINK','https://oa.risenenergy.com:333/','122.227.174.42','内部系统','办公类','2022-4-29','2022-04-29 16:47:16');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int NOT NULL COMMENT '父Id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单路径',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '组件路径',
  `isFrame` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '是否为外链（1是 0否）',
  `menuType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'M' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '菜单显示状态（1显示 0隐藏）',
  `orderNum` int NOT NULL COMMENT '显示顺序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '菜单状态（1正常 0停用）',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '#' COMMENT '图标',
  `isDelete` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,0,'首页','/layout/home','Home','Home','1','C','1',1,'1','','nav-home','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 16:09:57','admin'),(2,0,'系统管理','/system','Layout','Layout','1','M','1',20,'1','','system','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 15:08:36','admin'),(3,2,'用户中心','user','User','User','1','C','1',1,'1','','#','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 15:10:51','admin'),(4,2,'角色管理','role','Role','Role','1','C','1',2,'1','','#','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 15:11:01','admin'),(5,2,'菜单管理','menu','Menu','Menu','1','C','1',3,'1','','#','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 15:10:57','admin'),(6,2,'部门管理','dept','Dept','Dept','1','C','1',4,'1','','#','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 15:11:06','admin'),(7,2,'字典管理','dict','Dict','Dict','1','C','1',6,'1','','#','0',NULL,'2020-11-25 15:49:13','admin','2021-01-05 15:11:11','admin'),(8,0,'博客管理','/article','Layout','Layout','1','M','1',10,'1',NULL,'article','0',NULL,'2021-01-04 15:52:39','admin','2021-01-06 14:57:16','admin'),(9,8,'文章列表','articleList','ArticleList','ArticleList','1','C','1',2,'1',NULL,'#','0',NULL,'2021-01-04 16:09:36','admin','2021-01-25 14:07:08','admin'),(13,3,'查询',NULL,NULL,NULL,'1','F','0',1,'1','system:user:list','#','0',NULL,'2021-01-04 16:46:28','admin','2021-01-23 09:58:27','admin'),(14,3,'新增',NULL,NULL,NULL,'1','F','0',2,'1','system:user:add','#','0',NULL,'2021-01-04 16:47:31','admin','2021-01-23 09:58:36','admin'),(15,3,'修改',NULL,NULL,NULL,'1','F','0',3,'1','system:user:update','#','0',NULL,'2021-01-04 16:47:51','admin','2021-01-23 09:58:40','admin'),(16,3,'删除',NULL,NULL,NULL,'1','F','0',4,'1','system:user:delete','#','0',NULL,'2021-01-04 16:48:37','admin','2021-01-23 09:58:48','admin'),(17,4,'查询',NULL,NULL,NULL,'1','F','0',1,'1','system:role:list','#','0',NULL,'2021-01-04 18:05:57','admin','2021-01-23 09:58:54','admin'),(18,4,'新增',NULL,NULL,NULL,'1','F','0',2,'1','system:role:add','#','0',NULL,'2021-01-04 18:06:38','admin','2021-01-23 09:58:58','admin'),(19,4,'修改',NULL,NULL,NULL,'1','F','0',3,'1','system:role:update','#','0',NULL,'2021-01-04 18:07:04','admin','2021-01-23 09:59:01','admin'),(20,4,'删除',NULL,NULL,NULL,'1','F','0',4,'1','system:role:delete','#','0',NULL,'2021-01-04 18:07:21','admin','2021-01-23 09:59:05','admin'),(21,5,'查询',NULL,NULL,NULL,'1','F','0',1,'1','system:menu:list','#','0',NULL,'2021-01-04 18:08:20','admin','2021-01-23 09:59:30','admin'),(22,5,'新增',NULL,NULL,NULL,'1','F','0',2,'1','system:menu:add','#','0',NULL,'2021-01-04 18:08:37','admin','2021-01-23 09:59:33','admin'),(23,5,'修改',NULL,NULL,NULL,'1','F','0',3,'1','system:menu:update','#','0',NULL,'2021-01-04 18:08:55','admin','2021-01-23 09:59:37','admin'),(24,5,'删除',NULL,NULL,NULL,'1','F','0',4,'1','system:menu:delete','#','0',NULL,'2021-01-04 18:09:12','admin','2021-01-23 09:59:40','admin'),(25,6,'查询',NULL,NULL,NULL,'1','F','0',1,'1','system:department:list','#','0',NULL,'2021-01-04 18:09:31','admin','2021-02-02 14:19:13','admin'),(26,6,'新增',NULL,NULL,NULL,'1','F','0',2,'1','system:department:add','#','0',NULL,'2021-01-04 18:10:12','admin','2021-02-02 14:19:20','admin'),(27,6,'修改',NULL,NULL,NULL,'1','F','0',3,'1','system:department:update','#','0',NULL,'2021-01-04 18:10:27','admin','2021-02-02 14:19:28','admin'),(28,6,'删除',NULL,NULL,NULL,'1','F','0',4,'1','system:department:delete','#','0',NULL,'2021-01-04 18:10:42','admin','2021-02-02 14:19:33','admin'),(29,7,'查询字典类型',NULL,NULL,NULL,'1','F','0',1,'1','system:dictType:list','#','0',NULL,'2021-01-04 18:14:06','admin','2021-01-23 10:00:04','admin'),(30,7,'新增字典类型',NULL,NULL,NULL,'1','F','0',2,'1','system:dictType:add','#','0',NULL,'2021-01-04 18:14:52','admin','2021-01-23 10:00:07','admin'),(31,7,'修改字典类型',NULL,NULL,NULL,'1','F','0',3,'1','system:dictType:update','#','0',NULL,'2021-01-04 18:15:34','admin','2021-01-23 10:00:11','admin'),(32,7,'删除字典类型',NULL,NULL,NULL,'1','F','0',4,'1','system:dictType:delete','#','0',NULL,'2021-01-04 18:15:49','admin','2021-01-23 10:00:14','admin'),(33,7,'查询字典数据',NULL,NULL,NULL,'1','F','0',5,'1','system:dictData:list','#','0',NULL,'2021-01-04 18:16:33','admin','2021-01-23 10:00:20','admin'),(34,7,'新增字典数据',NULL,NULL,NULL,'1','F','0',6,'1','system:dictData:add','#','0',NULL,'2021-01-04 18:16:52','admin','2021-01-23 10:00:24','admin'),(35,7,'修改字典数据',NULL,NULL,NULL,'1','F','0',7,'1','system:dictData:update','#','0',NULL,'2021-01-04 18:17:10','admin','2021-01-23 10:00:27','admin'),(36,7,'删除字典数据',NULL,NULL,NULL,'1','F','0',8,'1','system:dictData:delete','#','0',NULL,'2021-01-04 18:17:24','admin','2021-01-23 10:00:34','admin'),(37,2,'通知公告','notice','Notice','Notice','1','C','1',10,'1',NULL,'#','0',NULL,'2021-01-05 13:43:26','admin','2021-01-05 15:11:15','admin'),(38,37,'查询',NULL,NULL,NULL,'1','F','0',1,'1','system:notice:list','#','0',NULL,'2021-01-05 14:06:12','admin','2021-01-23 10:00:40','admin'),(39,37,'新增',NULL,NULL,NULL,'1','F','0',2,'1','system:notice:add','#','0',NULL,'2021-01-05 14:06:51','admin','2021-01-23 10:00:43','admin'),(40,37,'修改',NULL,NULL,NULL,'1','F','0',3,'1','system:notice:update','#','0',NULL,'2021-01-05 14:07:10','admin','2021-01-23 10:00:47','admin'),(41,37,'删除',NULL,NULL,NULL,'1','F','0',4,'1','system:notice:delete','#','0',NULL,'2021-01-05 14:07:28','admin','2021-01-23 10:00:51','admin'),(42,8,'文章类型','articleType','ArticleType','ArticleType','1','C','1',3,'1',NULL,'#','0',NULL,'2021-01-06 15:05:31','admin',NULL,NULL),(43,9,'新增',NULL,NULL,NULL,'1','F','1',2,'1','blog:article:add','#','0',NULL,'2021-01-23 10:04:07','test','2021-01-23 10:08:56','test'),(44,9,'修改',NULL,NULL,NULL,'1','F','1',3,'1','blog:article:update','#','0',NULL,'2021-01-23 10:07:04','test','2021-01-23 10:09:03','test'),(45,9,'查询',NULL,NULL,NULL,'1','F','1',1,'1','blog:article:list','#','0',NULL,'2021-01-23 10:07:34','test','2021-01-23 10:08:50','test'),(46,9,'删除',NULL,NULL,NULL,'1','F','1',4,'1','blog:article:delete','#','0',NULL,'2021-01-23 10:08:13','test','2021-01-23 10:09:11','test'),(47,42,'查询',NULL,NULL,NULL,'1','F','1',1,'1','blog:articleType:list','#','0',NULL,'2021-01-23 10:09:33','test',NULL,NULL),(48,42,'新增',NULL,NULL,NULL,'1','F','1',2,'1','blog:articleType:add','#','0',NULL,'2021-01-23 10:09:46','test',NULL,NULL),(49,42,'修改',NULL,NULL,NULL,'1','F','1',3,'1','blog:articleType:update','#','0',NULL,'2021-01-23 10:10:00','test',NULL,NULL),(50,42,'删除',NULL,NULL,NULL,'1','F','1',4,'1','blog:articleType:delete','#','0',NULL,'2021-01-23 10:10:16','test',NULL,NULL),(51,8,'友情链接','friendlyLink','FriendlyLink','FriendlyLink','1','C','1',10,'1',NULL,'#','0',NULL,'2021-01-23 10:21:00','admin',NULL,NULL),(53,3,'状态显示',NULL,NULL,NULL,'1','F','1',10,'1','system:user:showStatus','#','0',NULL,'2021-01-29 14:02:59','admin',NULL,NULL),(54,4,'状态显示',NULL,NULL,NULL,'1','F','1',10,'1','system:role:showStatus','#','0',NULL,'2021-01-29 14:03:47','admin',NULL,NULL),(55,3,'修改头像',NULL,NULL,NULL,'1','F','1',11,'1','system:user:updateUserImg','#','0',NULL,'2021-02-02 14:53:56','admin',NULL,NULL),(56,3,'重置密码',NULL,NULL,NULL,'1','F','1',12,'1','system:user:resetPwd','#','0',NULL,'2021-02-02 14:54:23','admin',NULL,NULL),(57,3,'修改密码',NULL,NULL,NULL,'1','F','1',13,'1','system:user:updateUserPwd','#','0',NULL,'2021-02-02 14:54:55','admin',NULL,NULL),(58,3,'修改角色状态',NULL,NULL,NULL,'1','F','1',14,'1','system:role:changeRoleStatus','#','0',NULL,'2021-02-02 14:55:27','admin',NULL,NULL),(59,51,'查询',NULL,NULL,NULL,'1','F','1',1,'1','blog:friendlyLink:list','#','0',NULL,'2021-02-02 17:47:55','admin',NULL,NULL),(60,51,'新增',NULL,NULL,NULL,'1','F','1',2,'1','blog:friendlyLink:add','#','0',NULL,'2021-02-02 17:48:12','admin',NULL,NULL),(61,51,'修改',NULL,NULL,NULL,'1','F','1',3,'1','blog:friendlyLink:update','#','0',NULL,'2021-02-02 17:48:26','admin',NULL,NULL),(62,51,'删除',NULL,NULL,NULL,'1','F','1',4,'1','blog:friendlyLink:delete','#','0',NULL,'2021-02-02 17:48:39','admin',NULL,NULL),(63,42,'查询全部类型',NULL,NULL,NULL,'1','F','1',5,'1','blog:articleType:getAllType','#','0',NULL,'2021-03-02 11:18:10','admin',NULL,NULL),(64,0,'导航管理','/navigator','111','Layout','1','M','1',30,'1',NULL,'list','0',NULL,'2022-02-18 13:48:08','admin','2022-02-18 15:01:46','admin'),(65,64,'首页管理','favoriteshome','111','FavoritesHome','1','C','1',10,'1',NULL,'#','0',NULL,'2022-02-18 13:49:46','admin','2022-02-28 10:18:05','admin'),(67,64,'收藏夹管理','favarites','Favarites','Favarites','1','C','1',12,'1',NULL,'#','0',NULL,'2022-02-18 15:41:19','admin','2022-02-18 15:49:31','admin'),(68,8,'博客管理','blogManage','BlogManage','BlogManage','1','C','1',15,'1',NULL,'#','0',NULL,'2022-02-18 15:41:19','admin','2022-02-18 15:49:31','admin'),(69,67,'收藏夹查询',NULL,NULL,NULL,'1','F','1',1,'1','navigator:favorites:list','#','0',NULL,'2022-03-17 10:10:09','admin',NULL,NULL),(71,67,'收藏夹修改',NULL,NULL,NULL,'1','F','1',3,'1','navigator:favorites:update','','0',NULL,'2022-03-17 10:39:23','admin','2022-03-17 10:43:15','admin'),(72,67,'收藏夹新增',NULL,NULL,NULL,'1','F','1',4,'1','navigator:favorites:add','#','0',NULL,'2022-03-17 10:39:56','admin','2022-03-17 10:43:23','admin'),(73,67,'收藏夹删除',NULL,NULL,NULL,'1','F','1',2,'1','navigator:favorites:delete','#','0',NULL,'2022-03-17 10:40:37','admin',NULL,NULL),(74,67,'收藏夹网页查询',NULL,NULL,NULL,'1','F','1',5,'1','navigator:favoriteLink:list','#','0',NULL,'2022-03-17 10:41:40','admin',NULL,NULL),(75,67,'收藏夹网页修改',NULL,NULL,NULL,'1','F','1',6,'1','navigator:favoriteLink:update','#','0',NULL,'2022-03-17 10:42:16','admin',NULL,NULL),(76,67,'收藏夹网页新增',NULL,NULL,NULL,'1','F','1',7,'1','navigator:favoriteLink:add','#','0',NULL,'2022-03-17 10:42:40','admin',NULL,NULL),(77,67,'收藏夹网页删除',NULL,NULL,NULL,'1','F','1',8,'1','navigator:favoriteLink:delete','#','0',NULL,'2022-03-17 10:43:07','admin',NULL,NULL),(78,67,'收藏夹分类查询',NULL,NULL,NULL,'1','F','1',9,'1','navigator:favoriteGroup:list','#','0',NULL,'2022-03-17 10:45:32','admin',NULL,NULL),(79,67,'收藏夹分类更新',NULL,NULL,NULL,'1','F','1',10,'1','navigator:favoriteGroup:update','#','0',NULL,'2022-03-17 10:46:01','admin',NULL,NULL),(80,67,'收藏夹分类新增',NULL,NULL,NULL,'1','F','1',11,'1','navigator:favoriteGroup:add','#','0',NULL,'2022-03-17 10:46:29','admin',NULL,NULL),(81,67,'收藏夹分类删除',NULL,NULL,NULL,'1','F','1',12,'1','navigator:favoriteGroup:delete','#','0',NULL,'2022-03-17 10:46:56','admin',NULL,NULL),(82,64,'图表管理','charts','Charts','Charts','1','C','1',15,'1',NULL,'#','0',NULL,'2022-04-25 10:28:39','admin','2022-04-25 13:14:05','admin');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `noticeTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `noticeType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '公告类型（1通知 2公告）',
  `noticeContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '公告状态（1正常 0停用）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notices`
--

LOCK TABLES `notices` WRITE;
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
INSERT INTO `notices` VALUES (3,'公告','1','只是一个公告','1',NULL,'2021-01-29 14:49:56','admin','2022-01-06 22:26:07','admin');
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menus`
--

DROP TABLE IF EXISTS `role_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roleId` int NOT NULL COMMENT '角色roleId',
  `menuId` int NOT NULL COMMENT '菜单menuId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3098 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menus`
--

LOCK TABLES `role_menus` WRITE;
/*!40000 ALTER TABLE `role_menus` DISABLE KEYS */;
INSERT INTO `role_menus` VALUES (2923,8,64),(2924,8,65),(2925,8,67),(2994,2,1),(2995,2,13),(2996,2,15),(2997,2,53),(2998,2,55),(2999,2,56),(3000,2,57),(3001,2,17),(3002,2,54),(3003,2,25),(3004,2,67),(3005,2,69),(3006,2,73),(3007,2,71),(3008,2,72),(3009,2,74),(3010,2,75),(3011,2,76),(3012,2,77),(3013,2,78),(3014,2,79),(3015,2,80),(3016,2,81),(3017,2,2),(3018,2,3),(3019,2,4),(3020,2,6),(3021,2,64),(3022,1,1),(3023,1,8),(3024,1,9),(3025,1,45),(3026,1,43),(3027,1,44),(3028,1,46),(3029,1,42),(3030,1,47),(3031,1,48),(3032,1,49),(3033,1,50),(3034,1,63),(3035,1,51),(3036,1,59),(3037,1,60),(3038,1,61),(3039,1,62),(3040,1,68),(3041,1,2),(3042,1,3),(3043,1,13),(3044,1,14),(3045,1,15),(3046,1,16),(3047,1,53),(3048,1,55),(3049,1,56),(3050,1,57),(3051,1,58),(3052,1,4),(3053,1,17),(3054,1,18),(3055,1,19),(3056,1,20),(3057,1,54),(3058,1,5),(3059,1,21),(3060,1,22),(3061,1,23),(3062,1,24),(3063,1,6),(3064,1,25),(3065,1,26),(3066,1,27),(3067,1,28),(3068,1,7),(3069,1,29),(3070,1,30),(3071,1,31),(3072,1,32),(3073,1,33),(3074,1,34),(3075,1,35),(3076,1,36),(3077,1,37),(3078,1,38),(3079,1,39),(3080,1,40),(3081,1,41),(3082,1,64),(3083,1,65),(3084,1,67),(3085,1,69),(3086,1,73),(3087,1,71),(3088,1,72),(3089,1,74),(3090,1,75),(3091,1,76),(3092,1,77),(3093,1,78),(3094,1,79),(3095,1,80),(3096,1,81),(3097,1,82);
/*!40000 ALTER TABLE `role_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `roleKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `roleSort` int NOT NULL COMMENT '显示顺序',
  `dataScope` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '数据范围（1：本部门及以下数据权限 2：本部门数据权限 3：仅本人权限）',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '角色状态（1正常 0停用）',
  `isDelete` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'超级管理员','admin',0,'1','1','0',NULL,'2021-01-08 12:04:02','admin','2022-04-25 10:29:30','admin'),(2,'测试','navigator',2,'3','1','0',NULL,'2021-01-23 09:40:29','admin','2022-04-18 09:27:22','admin'),(8,'test','test',3,'3','1','0',NULL,'2022-03-02 14:51:35','admin','2022-04-18 09:17:42','admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequelizemeta` (
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequelizemeta`
--

LOCK TABLES `sequelizemeta` WRITE;
/*!40000 ALTER TABLE `sequelizemeta` DISABLE KEYS */;
INSERT INTO `sequelizemeta` VALUES ('20200831061523-create-article-type.js'),('20200831061523-create-articles.js'),('20200831061523-create-friendlyLink.js'),('20200831061523-create-notices.js'),('20200831061523-create-roles.js'),('20200831061618-create-departments.js'),('20200831061653-create-menus.js'),('20200831061739-create-dict-data.js'),('20200831061747-create-dict-type.js'),('20200831061953-create-role-menu.js'),('20200831062016-create-user-role.js'),('20201113071642-init-users.js');
/*!40000 ALTER TABLE `sequelizemeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL COMMENT '用户id',
  `roleId` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (18,2,2),(19,3,2),(21,5,2),(22,1,1),(23,6,2),(24,7,2),(25,8,2),(26,4,2),(27,9,2),(28,10,2),(29,11,2),(30,12,2),(31,13,2),(32,14,2),(33,15,2),(34,16,2),(35,17,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deptId` int NOT NULL COMMENT '部门deptId',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `nickName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '昵称',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '性别（0代表女 1代表男）',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号',
  `isDelete` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '帐号状态（1正常 0停用）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `createdAt` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `updatedAt` datetime DEFAULT NULL COMMENT '更新时间',
  `updatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `userName` (`userName`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'admin','admin','1','$2a$10$DASIjFwPy4yRRcPnWtx0/OT.t9M6ZF8zt963vnPgDdhiCtjEuSqee','http://dev.risen.com:7001/uploads/undefined/CHP_1648630591284_1.jpeg',NULL,NULL,'0','1','','2021-01-08 12:04:02','admin','2022-03-30 16:56:33','admin'),(2,2,'test','test','0','$2a$10$eV0xA14rp33w5Ai0HEzn..7eG6GY7Bq9iFvRRqVivZ50CVYXUMXXK','/uploads/2/CHP_1612249060086_16f194d7b8580d2950c33ab2c9e549d2.jpg',NULL,NULL,'0','1',NULL,'2021-01-23 09:36:27','admin','2021-02-02 17:10:14','test'),(4,5,'R-69261','忠忠','1','$2a$10$Og.VYwxU/z0Wdgm/FoHOdO8g7Z2tQzsIghQB0zpzmzlb6e8ZCfVq.','/uploads/2/lADPGqGobMaQd7zNAijNAig_552_552.jpg','',NULL,'0','1',NULL,'2022-03-29 14:47:54',NULL,'2022-04-18 09:20:57','admin'),(8,5,'R-70298',NULL,'1','$2a$10$xS6mrP03Wv9qa6VRA9w9pex67bjs.6bgYFsXkvy2O1QTC29nzwdOS','/uploads/2/lADPDgQ90dyOj_bNAlDNAk8_591_592.jpg','',NULL,'0','1',NULL,'2022-04-15 16:50:38',NULL,NULL,NULL),(16,5,'R-69530',NULL,'1','$2a$10$ObqlkVCGJJ75aZAd9g2MNeqZq9fb2IBRcWgtYoHr.Yjp7K2lt/T5K','/uploads/2/lADPD26ePj-wJ33NAenNAek_489_489.jpg','',NULL,'0','1',NULL,'2022-04-22 09:12:19',NULL,NULL,NULL),(17,5,'R-70014',NULL,'1','$2a$10$3YJ97x2AwAa.jbRCiK2GZ.SCCpG883Vv49a8SaHISL7eu8rgV/.9y','/uploads/2/lADPD3lGvEdgWEbNAfzNAZs_411_508.jpg','',NULL,'0','1',NULL,'2022-04-26 14:43:25',NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-29 21:19:41
