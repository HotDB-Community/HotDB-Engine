# 关于 HotSQL

HotSQL数据库是一款安全可信的集中式事务型数据库，可在普通硬件上流畅运行，具有高安全、轻量化、高兼容、高可用等特性，可作为MySQL的理想可选替换。



# HotSQL核心特性

## 1.高安全

- 数据的传输、存储均支持通过国密SM4对数据进行加密，全方位保障业务数据安全；

- 支持流控功能，启用后，可以根据服务性能表现智能调控SQL流量；

- 支持SQL防火墙，对高危SQL进行拦截，防止业务系统被SQL注入、误操作或恶意操作；

- 支持表回收站功能，被执行DROP/DELETE全表的数据可在设定时间范围内保留并恢复；

- 提供备份文件的加密与远程存储功能，保证数据安全性；

- 修复了所引用的多个组件的安全漏洞。

| 漏洞编号         | 漏洞名称                                  |
| ---------------- | ----------------------------------------- |
| CVE-2013-1779    | Drupal Fresh主题跨站脚本漏洞              |
| CVE-2014-2524    | GNU Readline‘_rl_tropen()’安全漏洞        |
| CVE-2015-1370    | Joyent Node.js marked 不完整黑名单漏洞    |
| CVE-2015-8607    | Perl PathTools 安全漏洞                   |
| CVE-2015-8854    | Joyent Node.js marked 资源管理错误漏洞    |
| CVE-2015-8858    | Joyent Node.js uglify-js 资源管理错误漏洞 |
| CVE-2015-8859    | Joyent Node.js send 信息泄露漏洞          |
| CVE-2016-1000236 | Node-cookie-signature 竞争条件问题漏洞    |
| CVE-2016-10531   | marked 跨站脚本漏洞                       |
| CVE-2016-4986    | CloudBees Jenkins TAP插件路径遍历漏洞     |
| CVE-2017-1000048 | web framework qs模块输入验证漏洞          |
| CVE-2017-1000188 | nodejs ejs 跨站脚本漏洞                   |
| CVE-2017-1000189 | nodejs ejs 安全漏洞                       |
| CVE-2017-1000228 | nodejs ejs 安全漏洞                       |
| CVE-2017-1000427 | marked URI解析器跨站脚本漏洞              |
| CVE-2017-16026   | Request 安全漏洞                          |
| CVE-2017-16114   | marked模块安全漏洞                        |
| CVE-2017-16119   | Fresh 安全漏洞                            |
| CVE-2017-16129   | superagent 安全漏洞                       |
| CVE-2017-16137   | debug模块安全漏洞                         |
| CVE-2017-17461   | marked 安全漏洞                           |
| CVE-2017-18589   | cookie crate for Rust 输入验证错误漏洞    |
| CVE-2017-20165   | debug 安全漏洞                            |
| CVE-2018-16487   | lodash 资源管理错误漏洞                   |
| CVE-2018-25076   | timbuckingham bigtree-events SQL注入漏洞  |
| CVE-2018-3721    | lodash node模块安全漏洞                   |
| CVE-2019-1010266 | lodash 资源管理错误漏洞                   |
| CVE-2019-10744   | lodash 安全漏洞                           |
| CVE-2019-25009   | Rust 资源管理错误漏洞                     |
| CVE-2019-5413    | npm package morgan 安全漏洞               |
| CVE-2020-14343   | PyYAML 输入验证错误漏洞                   |
| CVE-2020-1747    | PyYAML 输入验证错误漏洞                   |
| CVE-2020-25574   | Rust http 输入验证错误漏洞                |
| CVE-2020-26137   | urllib3 注入漏洞                          |
| CVE-2020-28481   | Socketio Socket.io 访问控制错误漏洞       |
| CVE-2020-28493   | Jinja2 资源管理错误漏洞                   |
| CVE-2020-28500   | lodash 安全漏洞                           |
| CVE-2020-35669   | Google Http package For Dart 注入漏洞     |
| CVE-2020-36048   | Socketio Engineio 资源管理错误漏洞        |
| CVE-2020-36049   | Socketio Engineio 资源管理错误漏洞        |
| CVE-2020-36634   | Indeed Engineering util 跨站脚本漏洞      |
| CVE-2020-7598    | minimist 输入验证错误漏洞                 |
| CVE-2020-7729    | grunt 代码注入漏洞                        |
| CVE-2020-8203    | lodash 输入验证错误漏洞                   |
| CVE-2021-20270   | Red Hat Ansible Automation 安全漏洞       |
| CVE-2021-23337   | lodash 代码注入漏洞                       |
| CVE-2021-24772   | WordPress SQL注入漏洞                     |
| CVE-2021-27291   | Matthäus G. Chajdas pygments 安全漏洞     |
| CVE-2021-33503   | urllib3 资源管理错误漏洞                  |
| CVE-2021-42771   | Babel 路径遍历漏洞                        |
| CVE-2021-44906   | minimist 安全漏洞                         |
| CVE-2022-0436    | Grunt 路径遍历漏洞                        |
| CVE-2022-1537    | Grunt 安全漏洞                            |
| CVE-2022-21680   | marked 安全漏洞                           |
| CVE-2022-21681   | marked 安全漏洞                           |
| CVE-2022-23491   | Certifi 数据伪造问题漏洞                  |
| CVE-2022-23602   | Nimforum 授权问题漏洞                     |
| CVE-2022-2421    | Socket.IO SQL注入漏洞                     |
| CVE-2022-24999   | qs 安全漏洞                               |
| CVE-2022-29078   | Github ejs 注入漏洞                       |
| CVE-2022-29361   | Pallets Werkzeug 环境问题漏洞             |
| CVE-2022-41940   | Engine.IO 安全漏洞                        |
| CVE-2022-43490   | WordPress plugin Stream 跨站请求伪造漏洞  |
| CVE-2022-4384    | WordPress plugin Stream 安全漏洞          |
| CVE-2023-23934   | Pallets Werkzeug 安全漏洞                 |
| CVE-2023-25577   | Pallets Werkzeug 安全漏洞                 |
| CVE-2023-28155   | Node.js request 代码问题漏洞              |
| CVE-2023-28370   | Tornado 输入验证错误漏洞                  |
| CVE-2023-30861   | Flask 安全漏洞                            |
| CVE-2023-32681   | Requests 信息泄露漏洞                     |
| CVE-2023-37920   | Certifi 数据伪造问题漏洞                  |



## 2.轻量化

移除不常用的组件，精简代码，优化算法。节省存储空间，降低运行负载，减少资源占用，提升运行速度，降低维护成本

- 移除不常用引擎，包括archive, ndb, blackhole, secondary_engine_mock, example, federated;

- 移除不常用插件，包括replication_observers_example test_plugins, rewrite_example, keyring audit_null, daemon_example keyring_udf, test_service_sql_api, test_services, udf_services, ddl_rewriter innodb_memcached, version_token;

- 移除不常用客户端，包括mysqltest, comp_err, lz4_decompress;

- 移除不常用工具，包括ibd2sdi, innochecksum,  my_print_defaults, perror, mysqlcheck, mysql_client_test.



## 3.高兼容

- 完全兼容MySQL的各项语法和功能；

- 支持大多数常见Oracle用法，包括数据类型、函数、SQL语法、序列等兼容性用法。



## 4.高可用

通过主从或MGR部署多副本，配合本产品提供的代理工具，可以实时感知各副本的可用性，若主副本出现异常，将自动选择可用的副本进行切换。

