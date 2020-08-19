

Z-BOOT 后端管理平台（前后端分离）
===============


[![AUR](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)


项目介绍：
-----------------------------------

ZBoot 是一个简易后端管理平台！采用前后端分离架构：SpringBoot2.x，Ant Design&Vue，Mybatis-plus，Shiro，JWT。

本项目部分功能代码参考[JEECG](http://www.jeecg.com/)

Overview
----

基于 [Ant Design of Vue](https://vuecomponent.github.io/ant-design-vue/docs/vue/introduce-cn/) 实现的 [Ant Design Pro](https://pro.ant.design/) 

![dashboard](https://static-2.loacg.com/open/static/github/SP1.png)

适用项目
-----------------------------------
可以应用在任何J2EE项目


在线演示
-----------------------------------

- [https://zswzsw.top/z-boot](https://zswzsw.top/z-boot)
 
 
技术架构：
-----------------------------------
#### 开发环境

- 语言：Java 8

- IDE(JAVA)： IDEA安装lombok插件 

- IDE(前端)： WebStorm 或者 IDEA

- 依赖管理：Maven

- 数据库：MySQL5.7+

- 缓存：Redis或本地缓存


#### 后端
- 基础框架：Spring Boot 2.3.1.RELEASE

- 持久层框架：Mybatis-plus_3.3.2

- 安全框架：Apache Shiro 1.5.3，Jwt_3.10.3

- 数据库连接池：阿里巴巴Druid 1.1.17

- 缓存框架：redis?

- 日志打印：logback

- 其他：Swagger-ui，quartz, lombok（简化代码）等。


#### 前端
 
- [Vue 2.6.10](https://cn.vuejs.org/),[Vuex](https://vuex.vuejs.org/zh/),[Vue Router](https://router.vuejs.org/zh/)
- [Axios](https://github.com/axios/axios)
- [ant-design-vue](https://vuecomponent.github.io/ant-design-vue/docs/vue/introduce-cn/)
- [webpack](https://www.webpackjs.com/),[yarn](https://yarnpkg.com/zh-Hans/)
- [vue-cropper](https://github.com/xyxiao001/vue-cropper) - 头像裁剪组件
- [@antv/g2](https://antv.alipay.com/zh-cn/index.html) - Alipay AntV 数据可视化图表
- [Viser-vue](https://viserjs.github.io/docs.html#/viser/guide/installation)  - antv/g2 封装实现
- eslint，[@vue/cli 3.2.1](https://cli.vuejs.org/zh/guide)
- I18n: [多语言支持 (@musnow)](./src/locales/index.js)


### 功能模块
```
├─系统管理
│  ├─用户管理
│  ├─角色管理
│  ├─菜单管理
│  ├─权限设置（支持按钮权限、数据权限）
│  ├─表单权限（控制字段禁用、隐藏）
│  ├─定时任务
│  └─字典管理
├─系统监控
│  │─Tomcat
│  │─jvm
│  │─服务器信息
│  │─请求追踪
│  │─磁盘监控
│  ├─定时任务
│  ├─系统日志
│  ├─SQL监控
│  ├─swagger-ui(在线接口文档)
│─报表示例
│  ├─曲线图
│  ├─饼状图
│  ├─柱状图
│  ├─折线图
│  ├─面积图
│  ├─雷达图
│  ├─仪表图
│  ├─进度条
│  ├─排名列表
│  └─等等
│─更多页面模板
│  ├─结果页面
│  ├─异常页面
|  ├─icon
│  └─个人页面
└─其他模块
   └─更多功能开发中。。
   
```

后台开发环境和依赖
---
- jdk8
- maven
- mysql
- 数据库脚本：docs\z-boot-mysql.sql
- 默认登录账号： test/111111


前端开发环境和依赖
----
- node
- yarn
- webpack
- eslint
- @vue/cli 3.2.1
- [ant-design-vue](https://github.com/vueComponent/ant-design-vue) - Ant Design Of Vue 实现
- [vue-cropper](https://github.com/xyxiao001/vue-cropper) - 头像裁剪组件
- [@antv/g2](https://antv.alipay.com/zh-cn/index.html) - Alipay AntV 数据可视化图表
- [Viser-vue](https://viserjs.github.io/docs.html#/viser/guide/installation)  - antv/g2 封装实现

项目下载和运行
----

- 拉取项目代码
```bash
git clone https://github.com/gold-net/z-boot.git
cd  z-boot/ant-design-vue-pro
```

1. 安装node.js
2. 切换到ant-design-vue-pro文件夹下
```
# 安装yarn
npm install -g yarn

# 下载依赖
yarn install

# 启动
yarn run serve

# 编译项目
yarn run build

# Lints and fixes files
yarn run lint
```

其他说明
----

- 项目使用的 [vue-cli3](https://cli.vuejs.org/guide/), 请更新您的 cli

- 关闭 Eslint (不推荐) 移除 `package.json` 中 `eslintConfig` 整个节点代码

附属文档
----
- [Ant Design Vue](https://github.com/vueComponent/ant-design-vue)
- [Ant Design Pro Layout](https://github.com/vueComponent/pro-layout)
- [viser-vue](https://viserjs.github.io/demo.html#/viser/bar/basic-bar)
- [Vue](https://cn.vuejs.org/v2/guide)

- 其他待补充...


## 捐赠 
...