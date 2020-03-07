package ${package.Mapper};

import ${package.Entity}.${entity};
<#--import ${superMapperClassPackage};-->
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Copyright (C), 2020-2020, public
 * FileName: ${table.mapperName}
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} mapper
 * Version: 1.0
 */
<#if kotlin>
interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
public interface ${table.mapperName} extends Mapper<${entity}> {

    /**
     * @title: describeListByFuzzy
     * @description: 模糊列表查询
     * @params: [ ${entity ?cap_first} ]
     * @return: java.util.List
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public List<${entity}> describeListByFuzzy(${entity} ${entity ?cap_first});

    /**
     * @title: describeListByFuzzy
     * @description: 精确列表查询
     * @params: [ ${entity ?cap_first} ]
     * @return: java.util.List
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public List<${entity}> describeList(${entity} ${entity ?cap_first});

    /**
     * @title: update${entity}
     * @description: 更新
     * @params: [ ${entity ?cap_first} ]
     * @return: java.lang.Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public Integer update${entity}(${entity} ${entity ?cap_first});

    /**
     * @title: insert${entity}
     * @description: 插入
     * @params: [ ${entity ?cap_first} ]
     * @return: java.lang.Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public Integer insert${entity}(${entity} ${entity ?cap_first});

    /**
     * @title: delete${entity}
     * @description: 删除
     * @params: [ ${entity ?cap_first} ]
     * @return: java.lang.Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public Integer delete${entity}(${entity} ${entity ?cap_first});
}
</#if>
