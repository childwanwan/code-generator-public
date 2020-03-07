# code-generator-public
代码生成器


此代码生成器可以生成基本后台的增删改查。
因所有框架不一致，可能读者所需要生成的代码模板与此代码生成器不符，可修改文件resource下的tetemplates下的模板文件；
如果不会ftl 模板的 可联系本人进行代码处理

本代码生成器尚存在的问题：
1、如果数据表的id不为varchar，生成的代码可能会报错，因此建议把id设置为varchar类型

2、此生成器目前只针对MySQL数据库进行了测试操作，对其他数据库是否支持，可自行探索

3、此生成器目前只针对单表进行了测试操作，如果需要多表关联进行生成，可自行探索

4、此生成器暂时不支持MySQL的blob类型，生成的代码可以运行，但是测试未通过


运行方式：
1、导入maven依赖

2、在application.yml和CodeGenerator中设置好需要连接的数据库(此数据库版本为8以上，如果是老版本，需要把驱动器设置成老版本的驱动器)

3、在CodeGenerator中设置好需要文件生成的模块和表名，截图如下

4、运行CodeGenerator生成代码

5、运行DemoApplication（如果报错，可自行查看springboot所配置包是否有问题，如果出现其他问题，可联系本人进行处理）
![image](https://github.com/childwanwan/code-generator-public/blob/master/images/tables.jpg)
![image](https://github.com/childwanwan/code-generator-public/blob/master/images/jdbc.jpg)

