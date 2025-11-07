# StuTestWeb

StuTestWeb 是一个基于 **Java Servlet + JSP** 的校园主题答题与成长模拟系统，提供用户注册登录、关卡闯关、随机事件以及后台题库与用户管理等功能。项目以 `WAR` 形式构建，可部署到任意兼容 Servlet 4.0 的应用服务器（如 Apache Tomcat 9+）。

## 功能概览
- 游戏化闯关：用户从 `startgame.jsp` 进入关卡，通过 `game.jsp` 完成问答并影响健康、金钱、天赋等属性。
- 随机事件与剧情：`randomShow.jsp` 等页面结合 `RandomThing` 数据表，为玩家注入随机事件和分支剧情。
- 用户体系：支持普通用户与管理员两种角色，管理员可在 `backmanage.jsp` 等页面维护题库、随机事件和结局内容。
- 数据统计：`rank.jsp` 展示玩家排行，`end*.jsp` 呈现多种结局反馈。
- 会话与权限控制：`LoginFilter`、`RequestEncodingFilter` 确保登陆状态与请求编码一致性。

## 技术栈
- 语言与框架：Java 7/8、Servlet 4.0、JSP、JSTL 1.2
- 构建工具：Maven 3，输出 `StuTestWeb.war`
- 数据库：MySQL 8（默认连接 `jdbc:mysql://localhost:3306/rich`）
- 前端资源：自定义 CSS、Font Awesome、JSP 模板

## 目录结构
```
└── src
    ├── main
    │   ├── java
    │   │   └── com/qst
    │   │       ├── action/           # Servlet 控制器
    │   │       ├── dao/              # DAO 接口与实现
    │   │       ├── entity/           # 实体模型（User、Play、RandomThing）
    │   │       ├── filter/           # 编码与登录过滤器
    │   │       └── service/          # 业务逻辑
    │   ├── resources                 # 预留资源目录
    │   └── webapp
    │       ├── *.jsp                 # 前端视图与页面逻辑
    │       ├── CSS/、images/、js/    # 静态资源
    │       └── WEB-INF/web.xml       # 部署描述符
    └── test
        └── java/com/qst             # 单元测试示例
```

## 快速开始
1. **准备环境**
   - 安装 JDK 8（最低支持 1.7，推荐 1.8）
   - 安装 Maven 3.6+
   - 安装 MySQL 5.7/8，并创建数据库 `rich`

2. **配置数据库**
   - 在 `src/main/java/com/qst/util/JDBCUtil.java` 中调整 `url`、`userName`、`password`
   - 导入数据表结构与初始数据（可根据实体与 JSP 页面自定义建表；常见表包括 `user`、`play`、`randomthing`、`question` 等）

3. **编译打包**
   ```bash
   mvn clean package
   ```
   构建产物位于 `target/StuTestWeb.war`

4. **部署运行**
   - 将 `StuTestWeb.war` 部署至 Tomcat `webapps` 目录，或在 IDE 中配置 Tomcat 直接运行
   - 访问 `http://localhost:8080/StuTestWeb/login.jsp`

## 常见配置
- **字符编码**：项目默认使用 UTF-8，确保服务器和数据库均配置为 UTF-8
- **静态资源路径**：JSP 页面使用相对路径引用 `CSS/`、`images/`、`js/` 下资源；部署至上下文路径非根目录时注意前缀
- **日志与调试**：当前项目采用 `System.out` 与 `printStackTrace` 进行调试，可根据需要接入日志框架

## 开发建议
- 引入连接池（如 HikariCP）提升数据库性能
- 将数据库配置移动到外部化配置文件，避免硬编码凭据
- 使用 Servlet 过滤器扩展跨站请求伪造（CSRF）与会话超时控制
- 为 JSP 页面补充国际化与响应式布局，提升用户体验
- 编写更多 JUnit/集成测试覆盖核心业务逻辑

