package ${package.ServiceImpl};

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${cfg.dtopackage}.dto.${entity}DTO;
<#-- import ${superServiceImplClassPackage}; -->
import ${cfg.utils}.InitExampleOrderByUtils;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

/**
 * Copyright (C), 2020-2020, public
 * FileName: ${table.serviceImplName}
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} serviceImpl
 * Version: 1.0
 */
@Slf4j
@Service
<#if kotlin>
    open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

    }
<#else>
public class ${table.serviceImplName} implements ${table.serviceName} {

    @Resource
    private ${table.mapperName} ${table.mapperName ?uncap_first};

    /**
     * @title: selectFuzzyByDto
     * @description: 模糊查询操作
     * @params: [ dto ]
     * @return: java.util.List
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @Override
    public List<${entity}DTO> selectFuzzyByDto(${entity}DTO dto) {
        //List<${entity}> list = ${table.mapperName ?uncap_first}.selectByExample(initFuzzyExample(dto));
        List<${entity}> list = ${table.mapperName ?uncap_first}.describeListByFuzzy(JSONObject.parseObject(JSONObject.toJSONString(dto),${entity}.class));
        return JSONArray.parseArray(JSONArray.toJSONString(list), ${entity}DTO.class);
    }

    /**
     * @title: selectByDto
     * @description: 精确查询操作
     * @params: [ dto ]
     * @return: java.util.List
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @Override
    public List<${entity}DTO> selectByDto(${entity}DTO dto) {
        //List<${entity}> list = ${table.mapperName ?uncap_first}.selectByExample(initExample(dto));
        List<${entity}> list = ${table.mapperName ?uncap_first}.describeList(JSONObject.parseObject(JSONObject.toJSONString(dto),${entity}.class));
        return JSONArray.parseArray(JSONArray.toJSONString(list), ${entity}DTO.class);
    }

    /**
     * @title: insertDto
     * @description: 插入操作
     * @params: [ dto ]
     * @return: Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @Override
    public Integer insertDto(${entity}DTO dto) {
        if (null == dto.getId() || "".equals(dto.getId())) {
        <#assign isSeted = "no"/>
            <#list table.commonFields as field>
                <#if field.propertyName == "id" && isSeted == "no">
                    <#if field.columnType == "STRING">
            dto.setId(UUID.randomUUID().toString());
                        <#assign isSeted = "yes">
                    <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
            dto.setId(new Date());
                        <#assign isSeted = "yes">
                    <#elseif field.columnType == "BLOB">
            dto.setId(UUID.randomUUID().toString());
                        <#assign isSeted = "yes">
                    <#elseif field.columnType == "INTEGER">
            dto.setId(0);
                        <#assign isSeted = "yes">
                    <#else>
            dto.setId();
                        <#assign isSeted = "yes">
                    </#if>
                </#if>
            </#list>
        }
        return ${table.mapperName ?uncap_first}.insert${entity}(JSONObject.parseObject(JSON.toJSONString(dto), ${entity}.class));
        //return ${table.mapperName ?uncap_first}.insert(JSONObject.parseObject(JSON.toJSONString(dto), ${entity}.class));
    }

    /**
     * @title: updateDto
     * @description: 修改操作
     * @params: [ dto ]
     * @return: Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @Override
    public Integer updateDto(${entity}DTO dto) {
        if (null != dto && null != dto.getId() && !"".equals(dto.getId())) {
            return ${table.mapperName ?uncap_first}.update${entity}(JSONObject.parseObject(JSON.toJSONString(dto), ${entity}.class));
            //return ${table.mapperName ?uncap_first}.updateByPrimaryKey(JSONObject.parseObject(JSON.toJSONString(dto), ${entity}.class));
        } else {
            return 0;
        }
    }

    /**
     * @title: deleteDto
     * @description: 删除操作
     * @params: [ dto ]
     * @return: Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @Override
    public Integer deleteDto(${entity}DTO dto) {
        if (null != dto && null != dto.getId() && !"".equals(dto.getId())) {
            return ${table.mapperName ?uncap_first}.delete${entity}(JSONObject.parseObject(JSON.toJSONString(dto), ${entity}.class));
            //return ${table.mapperName ?uncap_first}.deleteByPrimaryKey(dto.getId());
        } else {
            return 0;
        }
    }


    /**
     * @title: initFuzzyExample
     * @description: 初始化 模糊查询 example
     * @params: [ dto ]
     * @return: tk.mybatis.mapper.entity.Example
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    private Example initFuzzyExample(${entity}DTO dto) {
        Example example = InitExampleOrderByUtils.initExampleOrderBy(${entity}.class, dto.getOrderBy());
        Example.Criteria criteriaName = example.createCriteria();
        if (null != dto) {
            <#list table.fields as field>
                <#--<#if field.propertyType?contains("Date")>
                <#else>-->
            if (null != dto.get${field.capitalName}() && !"".equals(dto.get${field.capitalName}())) {
                criteriaName.andLike("${field.capitalName}", "%" + dto.get${field.capitalName}() + "%");
            }
                <#--</#if>-->
            </#list>
        }
        return example;
    }

    /**
     * @title: initExample
     * @description: 初始化 精确查询 example
     * @params: [ dto ]
     * @return: tk.mybatis.mapper.entity.Example
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    private Example initExample(${entity}DTO dto) {
        Example example = InitExampleOrderByUtils.initExampleOrderBy(${entity}.class, dto.getOrderBy());
        Example.Criteria criteriaName = example.createCriteria();
        if (null != dto) {
    <#list table.fields as field>
        <#--<#if field.propertyType?contains("Date")>
        <#else>-->
            if (null != dto.get${field.capitalName}() && !"".equals(dto.get${field.capitalName}())) {
                criteriaName.andEqualTo("${field.capitalName}", dto.get${field.capitalName}());
            }
        <#--</#if>-->
    </#list>
        }
        return example;
    }

    <#--/**
     * @title: initExampleOrderBy
     * @description: 初始化排序信息, 如果不需要，可修改模板代码
     * @params: [ dto ]
     * @return: tk.mybatis.mapper.entity.Example
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    private Example initExampleOrderBy(${entity}DTO dto) {
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
    }-->

}
</#if>
