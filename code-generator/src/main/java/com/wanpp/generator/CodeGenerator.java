package com.wanpp.generator;

import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.*;

// 演示例子，执行 main 方法控制台输入模块表名回车自动生成对应项目目录中
public class CodeGenerator {

    public static void main(String[] args) {
        //模块名,如果一致则生成在同一级目录下，建议一致
        String moduleNameArray[] = {"test","test"};

        //表名,注意需要与模块名对应
        String tableNameArray[] = {"user","data_main"};

        for (int i = 0;i<moduleNameArray.length;i++){
            // 代码生成器
            AutoGenerator mpg = new AutoGenerator();

            // 全局配置
            GlobalConfig gc = new GlobalConfig();
            //当前工程路径
            String projectPath = System.getProperty("user.dir");
            gc.setOutputDir(projectPath + "/code-generator/src/main/java");//生成文件的输出目录【默认 D 盘根目录】
            gc.setAuthor("wanpp");//开发人员
            gc.setOpen(false);//是否打开输出目录
            gc.setFileOverride(true);// 是否覆盖已有同名文件，默认是false
            gc.setActiveRecord(true);// 开启 ActiveRecord 模式，默认是false
            gc.setEnableCache(false);// 是否在xml中添加二级缓存配置，默认是false
            gc.setBaseResultMap(true);// 开启 BaseResultMap，默认是false
            gc.setBaseColumnList(true);// 开启 baseColumnList，默认是false
            /*
             * 各层文件名称方式，例如： %sAction 生成 UserAction
             * %s 为占位符，注意 %s 会自动填充表实体属性！
             */
            //gc.setMapperName("%sDao");//默认UserMapper.xml
            //gc.setXmlName("%sDao");//默认UserMapper.xml
            //gc.setServiceName("MP%sService");//默认IUserService.java
            //gc.setServiceImplName("%sServiceDiy");//默认UserServiceImpl.java
            //gc.setControllerName("%sAction");//默认UserController.java
            mpg.setGlobalConfig(gc);

            // 数据源配置
            DataSourceConfig dsc = new DataSourceConfig();
            dsc.setUrl("jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC");
            //dsc.setSchemaName("public");//PostgreSQL schemaName
            //dsc.setDriverName("com.mysql.jdbc.Driver");
            dsc.setDriverName("com.mysql.cj.jdbc.Driver");
            dsc.setUsername("root");
            dsc.setPassword("1234");
            mpg.setDataSource(dsc);

            // 包配置
            PackageConfig pc = new PackageConfig();
            pc.setModuleName(moduleNameArray[i]);//父包模块名,默认null
            //父包名。如果为空，将下面子包名必须写全部， 否则就只需写子包名
            String packageName ="com.wanpp";
            pc.setParent(packageName);
            //pc.setController("liuxzhController");//默认controller
            //pc.setService("liuxzhService");//默认service
            //pc.setServiceImpl("liuxzhService.impl");//默认service.impl
            //pc.setEntity("liuxzhEntity");//默认entity
            //pc.setMapper("liuxzhMapper");//默认mapper
            //pc.setXml("liuxzhMapper.xml");//默认mapper.xml
            mpg.setPackageInfo(pc);

            // 自定义配置
            InjectionConfig cfg = new InjectionConfig() {
                @Override
                public void initMap() {
                    Map<String, Object> map = new HashMap<>();
                    map.put("dtopackage", packageName+"."+pc.getModuleName());
                    map.put("utils",packageName+".utils");
                    this.setMap(map);
                }
            };

            // 如果模板引擎是 freemarker
            String templatePath = "/templates/myMapper.xml.ftl";
            // 如果模板引擎是 velocity
//         String templatePath = "/templates/mapper.xml.vm";

            // 自定义输出配置
            List<FileOutConfig> focList = new ArrayList<>();
            // 自定义配置会被优先输出
            focList.add(new FileOutConfig(templatePath) {
                @Override
                public String outputFile(TableInfo tableInfo) {
                    // 自定义输出文件名
                    return projectPath + "/code-generator/src/main/resources/mapper/" + pc.getModuleName()
                            + "/" + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
                }
            });
            String packagePath = packageName.replaceAll("\\.","/")+"/";
            String templateDtoPath = "/templates/myEntityDto.java.ftl";
            focList.add(new FileOutConfig(templateDtoPath) {
                @Override
                public String outputFile(TableInfo tableInfo) {
                    // 自定义输出文件名
                    return projectPath + "/code-generator/src/main/java/" +packagePath+pc.getModuleName()

                            + "/dto/" + tableInfo.getEntityName() + "DTO.java";
                }
            });

//        String templateUtilsPath = "/templates/myUtil.java.ftl";
//        focList.add(new FileOutConfig(templateUtilsPath) {
//            @Override
//            public String outputFile(TableInfo tableInfo) {
//                // 自定义输出文件名
//                return projectPath + "/code-generator/src/main/java/" +packagePath
//                        + "/utils/"  + "InitExampleOrderByUtils.java";
//            }
//        });

            cfg.setFileOutConfigList(focList);
            mpg.setCfg(cfg);

            // 配置模板
            TemplateConfig templateConfig = new TemplateConfig();

            // 配置自定义输出模板
            //templateConfig.setEntityKt("");
            templateConfig.setEntity("/templates/myEntity.java");
            templateConfig.setMapper("/templates/myMapper.java");
            templateConfig.setService("/templates/myService.java");
            templateConfig.setServiceImpl("/templates/myServiceImpl.java");
            templateConfig.setController("/templates/myController.java");

            templateConfig.setXml(null);
            mpg.setTemplate(templateConfig);

            mpg.setTemplateEngine(new FreemarkerTemplateEngine());

            // 策略配置
            StrategyConfig strategy = new StrategyConfig();
            //数据库表映射到实体的命名策略，默认：不做任何改变，原样输出
            strategy.setNaming(NamingStrategy.underline_to_camel);
            //数据库表字段映射到实体的命名策略，未指定按照 naming 执行
            strategy.setColumnNaming(NamingStrategy.underline_to_camel);
            //【实体】是否为lombok模型（默认 false）
            //strategy.setEntityLombokModel(true);
            //生成@RestController 控制器
            strategy.setRestControllerStyle(true);
            //自定义继承的Controller类全称，带包名
            //strategy.setSuperControllerClass("com.mybatisplus.demo.common.BaseController");
            //strategy.setSuperServiceClass();
            //strategy.setSuperServiceImplClass();
            //strategy.setSuperMapperClass("com.mybatisplus.demo.common.BaseMapper");
            //strategy.setSuperEntityClass("com.mybatisplus.demo.common.BaseEntity");//自定义继承的Entity类全称，带包名

            strategy.setInclude(tableNameArray[i]);//表明String数组
            strategy.setSuperEntityColumns("id");
            // 驼峰转连字符:
            // @RequestMapping("/managerUserActionHistory")-->@RequestMapping("/manager-user-action-history")
            strategy.setControllerMappingHyphenStyle(true);
            strategy.setTablePrefix(pc.getModuleName() + "_");//表前缀

            mpg.setStrategy(strategy);//数据库表配置
            mpg.setTemplateEngine(new FreemarkerTemplateEngine());// 选择 freemarker 引擎，默认 Veloctiy

            //生成代码
            mpg.execute();
        }


    }

}
