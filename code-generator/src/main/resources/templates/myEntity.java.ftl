package ${package.Entity};

<#assign isHaveDate = "no">
<#list table.importPackages as pkg>
    <#if pkg ?contains("Date") || pkg?contains("Time")>
        <#if isHaveDate == "no">
import java.util.Date;
            <#assign isHaveDate = "yes">
        </#if>
    <#elseif pkg ?contains("Model")>
    <#elseif pkg ?contains("Serializable")>
    <#else>
import ${pkg};
    </#if>
</#list>
import javax.persistence.*;
<#if swagger2>
    import io.swagger.annotations.ApiModel;
    import io.swagger.annotations.ApiModelProperty;
</#if>
<#if entityLombokModel>
    import lombok.Data;
    import lombok.EqualsAndHashCode;
    import lombok.experimental.Accessors;
</#if>

/**
 * Copyright (C), 2020-2020, public
 * FileName: ${entity}
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} 实体
 * Version: 1.0
 */
<#if entityLombokModel>
    @Data
    <#if superEntityClass??>
        @EqualsAndHashCode(callSuper = true)
    <#else>
        @EqualsAndHashCode(callSuper = false)
    </#if>
    @Accessors(chain = true)
</#if>
<#if table.convert>
    @TableName("${table.name}")
</#if>
<#if swagger2>
    @ApiModel(value="${entity}对象", description="${table.comment!}")
</#if>
<#if superEntityClass??>
    public class ${entity} extends ${superEntityClass}<#if activeRecord><${entity}></#if> {
<#elseif activeRecord>
@Table(name = "${table.name}")
public class ${entity} {
<#else>
    public class ${entity} implements Serializable {
</#if>

<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.commonFields as field>
    /**
     * ${field.comment}
     */
    <#if field.propertyType?contains("Date")>
    @Id
    private Date ${field.propertyName};
    <#else>
    @Id
    private ${field.propertyType} ${field.propertyName};
    </#if>
</#list>

<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>
    <#if field.comment!?length gt 0>
        <#if swagger2>
            @ApiModelProperty(value = "${field.comment}")
        <#else>
    /**
     * ${field.comment}
     */
        </#if>
    </#if>
    <#if field.keyFlag>
    <#-- 主键 -->
        <#if field.keyIdentityFlag>
            @TableId(value = "${field.name}", type = IdType.AUTO)
        <#elseif idType??>
            @TableId(value = "${field.name}", type = IdType.${idType})
        <#elseif field.convert>
            @TableId("${field.name}")
        </#if>
    <#-- 普通字段 -->
    <#elseif field.fill??>
    <#-- -----   存在字段填充设置   ----->
        <#if field.convert>
            @TableField(value = "${field.name}", fill = FieldFill.${field.fill})
        <#else>
            @TableField(fill = FieldFill.${field.fill})
        </#if>
    <#elseif field.convert>
        @TableField("${field.name}")
    </#if>
<#-- 乐观锁注解 -->
    <#if (versionFieldName!"") == field.name>
        @Version
    </#if>
<#-- 逻辑删除注解 -->
    <#if (logicDeleteFieldName!"") == field.name>
        @TableLogic
    </#if>
    <#if field.propertyType?contains("Date")>
    @Column(name = "${field.name}")
    private Date ${field.propertyName};
    <#else>
    @Column(name = "${field.name}")
    private ${field.propertyType} ${field.propertyName};
    </#if>

</#list>
<#------------  END 字段循环遍历  ---------->
<#------------  GET and SET  START---------->
<#if !entityLombokModel>
    <#list table.commonFields as field>
        <#if field.propertyType == "boolean">
            <#assign getprefix="is"/>
        <#else>
            <#assign getprefix="get"/>
        </#if>
        <#if field.propertyType ?contains("Date") || field.propertyType ?contains("Time")>
    public Date ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

        <#else>
    public ${field.propertyType} ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

        </#if>
        <#if entityBuilderModel>
            <#if field.propertyType ?contains("Date") || field.propertyType ?contains("Time")>
    public ${entity} set${field.capitalName}(Date ${field.propertyName}) {
            <#else>
    public ${entity} set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
            </#if>
        <#else>
            <#if field.propertyType ?contains("Date") || field.propertyType ?contains("Time")>
    public void set${field.capitalName}(Date ${field.propertyName}) {
            <#else>
    public void set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
            </#if>
        </#if>
        this.${field.propertyName} = ${field.propertyName};
        <#if entityBuilderModel>
            return this;
        </#if>
    }

    </#list>
    <#list table.fields as field>
        <#if field.propertyType == "boolean">
            <#assign getprefix="is"/>
        <#else>
            <#assign getprefix="get"/>
        </#if>
        <#if field.propertyType ?contains("Date") || field.propertyType ?contains("Time")>
    public Date ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

            <#else>
    public ${field.propertyType} ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

        </#if>
        <#if entityBuilderModel>
            <#if field.propertyType ?contains("Date") || field.propertyType ?contains("Time")>
    public ${entity} set${field.capitalName}(Date ${field.propertyName}) {
            <#else>
    public ${entity} set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
            </#if>
        <#else>
            <#if field.propertyType ?contains("Date") || field.propertyType ?contains("Time")>
    public void set${field.capitalName}(Date ${field.propertyName}) {
            <#else>
    public void set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
            </#if>
        </#if>
        this.${field.propertyName} = ${field.propertyName};
        <#if entityBuilderModel>
            return this;
        </#if>
    }

    </#list>
</#if>
<#------------  GET and SET  END---------->
<#------------ toString ---------->
<#if !entityLombokModel>
    @Override
    public String toString() {
        return "${entity}{" +
    <#list table.fields as field>
        <#if field_index==0>
                "${field.propertyName}=" + ${field.propertyName} +
        <#else>
                ", ${field.propertyName}=" + ${field.propertyName} +
        </#if>
    </#list>
                "}";
    }
</#if>
}
