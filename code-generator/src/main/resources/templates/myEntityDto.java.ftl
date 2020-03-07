package ${cfg.dtopackage}.dto;

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
<#assign isHaveJSON = "no">
<#list table.importPackages as pkg>
    <#if pkg ?contains("Date") || pkg?contains("Time")>
        <#if isHaveJSON == "no">
import com.fasterxml.jackson.annotation.JsonFormat;
            <#assign isHaveJSON = "yes">
        </#if>
    </#if>
</#list>
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
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
 * FileName: ${entity}DTO
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} dto实体
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
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ${entity}DTO {
<#else>
    public class ${entity} implements Serializable {
</#if>

<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.commonFields as field>
    /**
     * ${field.comment}
     */
    <#if field.propertyType?contains("Date")>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ${field.propertyName};
    <#else>
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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ${field.propertyName};
    <#else>
    private ${field.propertyType} ${field.propertyName};
    </#if>

</#list>
<#------------  END 字段循环遍历  ---------->
    /**
     * 排序字段 + 升序， -降序
     * 比如 +updateTime 根据 修改时间升序排序，-updateTime 根据 修改时间降序排序
     */
    private String orderBy;

}
