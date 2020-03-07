package ${cfg.utils};

import ${package.Entity}.${entity};
import ${cfg.dtopackage}.dto.${entity}DTO;
<#-- import ${superServiceImplClassPackage}; -->
import tk.mybatis.mapper.entity.Example;

/**
 * Copyright (C), 2020-2020, public
 * FileName: InitExampleOrderByUtils
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} serviceImpl
 * Version: 1.0
 */
<#if kotlin>
    open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

    }
<#else>
public class InitExampleOrderByUtils {

    /**
     * @title: initExampleOrderBy
     * @description: 初始化排序信息, 如果需要，可以抽成 公共utils
     * @params: [ dto ]
     * @return: tk.mybatis.mapper.entity.Example
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public static Example initExampleOrderBy(${entity}DTO dto) {
        Example example = new Example(${entity}.class);
        //排序
        if (null != dto.getOrderBy() && !"".equals(dto.getOrderBy())) {
            if (dto.getOrderBy().startsWith("+")) {
                //升序
                example.orderBy(dto.getOrderBy().substring(1)).asc();
            } else {
                //降序
                example.orderBy(dto.getOrderBy().substring(1)).desc();
            }
        } else {
            //默认排序,不要可移除
            example.orderBy("updateTime").desc();
        }
        return example;
    }

}
</#if>
