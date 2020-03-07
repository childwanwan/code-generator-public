<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

    <#if enableCache>
        <!-- 开启二级缓存 -->
        <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>
    </#if>
    <#if baseResultMap>
    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
            <#list table.fields as field>
                <#if field.keyFlag><#--生成主键排在第一位-->
                    <#if field.keyFlag>
                        <#if field.columnType == "STRING">
        <id column="${field.name}" jdbcType="VARCHAR" property="${field.propertyName}"/>
                        <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
        <id column="${field.name}" jdbcType="TIMESTAMP" property="Date"/>
                        <#elseif field.columnType == "BLOB">
        <id column="${field.name}" jdbcType="BLOB" property="${field.propertyName}" typeHandler="org.apache.ibatis.type.BlobTypeHandler"/>
                        <#else>
        <id column="${field.name}" jdbcType="${field.columnType}" property="${field.propertyName}"/>
                        </#if>
                    </#if>
                </#if>
            </#list>
            <#list table.commonFields as field><#--生成公共字段 -->
                <#if field.columnType == "STRING">
        <id column="${field.name}" jdbcType="VARCHAR" property="${field.propertyName}"/>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
        <id column="${field.name}" jdbcType="TIMESTAMP" property="Date"/>
                <#elseif field.columnType == "BLOB">
        <id column="${field.name}" jdbcType="BLOB" property="${field.propertyName}" typeHandler="org.apache.ibatis.type.BlobTypeHandler"/>
                <#else>
        <id column="${field.name}" jdbcType="${field.columnType}" property="${field.propertyName}"/>
                </#if>
            </#list>
            <#list table.fields as field>
                <#if !field.keyFlag><#--生成普通字段 -->
                    <#if field.columnType == "STRING">
        <result column="${field.name}" jdbcType="VARCHAR" property="${field.propertyName}"/>
                    <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
        <result column="${field.name}" jdbcType="TIMESTAMP" property="Date"/>
                    <#elseif field.columnType == "BLOB">
        <result column="${field.name}" jdbcType="BLOB" property="${field.propertyName}" typeHandler="org.apache.ibatis.type.BlobTypeHandler"/>
                    <#else>
        <result column="${field.name}" jdbcType="${field.columnType}" property="${field.propertyName}"/>
                    </#if>
                </#if>
            </#list>
    </resultMap>

    </#if>
    <#if baseColumnList>
    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
            <#list table.commonFields as field>
        ${field.name},
            </#list>
        ${table.fieldNames}
    </sql>

    </#if>

    <!-- 模糊列表查询 -->
    <select id="describeListByFuzzy" parameterType="${package.Entity}.${entity}" resultMap="BaseResultMap">
        SELECT
        <include refid="Base_Column_List"/>
        FROM ${table.name}
        <where>
            <#list table.commonFields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} like concat('%',<#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>,'%')
            </if>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
                <#else>
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} like concat('%',<#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>,'%')
            </if>
                </#if>
            </#list>
        <#list table.fields as field>
            <#if field.propertyType?contains("Date")>
            <#elseif field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} like concat('%',<#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>,'%')
            </if>
            <#else>
            <if test="${field.propertyName} != null">
                AND ${table.name}.${field.name} like concat('%',<#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>,'%')
            </if>
            </#if>
        </#list>
        </where>
    </select>

    <!-- 精确列表查询 -->
    <select id="describeList" parameterType="${package.Entity}.${entity}" resultMap="BaseResultMap">
        SELECT
        <include refid="Base_Column_List"/>
        FROM ${table.name}
        <where>
            <#list table.commonFields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>
            </if>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
                <#else>
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} like concat('%',<#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>,'%')
            </if>
                </#if>
            </#list>
            <#list table.fields as field>
                <#if field.propertyType?contains("Date")>
                <#elseif field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>
            </if>
                <#else>
            <if test="${field.propertyName} != null">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>
            </if>
                </#if>
            </#list>
        </where>
    </select>

    <!-- 更新 -->
    <update id="update${entity}" parameterType="${package.Entity}.${entity}">
        UPDATE ${table.name}
        <set>
            <#list table.fields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                ${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>,
            </if>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
            <if test="${field.propertyName} != null">
                ${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=TIMESTAMP}</#noparse>,
            </if>
                <#else>
            <if test="${field.propertyName} != null">
                ${field.name} = <#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>,
            </if>
                </#if>
            </#list>
        </set>
        <where>
        <#list table.commonFields as field>
            <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>,
            </if>
            <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
            <if test="${field.propertyName} != null">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=TIMESTAMP}</#noparse>,
            </if>
            <#else>
            <if test="${field.propertyName} != null">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>,
            </if>
            </#if>
        </#list>
        </where>
    </update>

    <!-- 插入 -->
    <insert id="insert${entity}" parameterType="${package.Entity}.${entity}">
        INSERT INTO ${table.name}
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list table.commonFields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                ${field.name},
            </if>
                <#else>
            <if test="${field.propertyName} != null">
                ${field.name},
            </if>
                </#if>
            </#list>
            <#list table.fields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                ${field.name},
            </if>
                <#else>
            <if test="${field.propertyName} != null">
                ${field.name},
            </if>
                </#if>
            </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#list table.commonFields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                <#noparse>#{</#noparse>${field.name}<#noparse>,jdbcType=VARCHAR}</#noparse>,
            </if>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                <#noparse>#{</#noparse>${field.name}<#noparse>,jdbcType=TIMESTAMP}</#noparse>,
            </if>
                <#else>
            <if test="${field.propertyName} != null">
                <#noparse>#{</#noparse>${field.name},jdbcType=${field.columnType}<#noparse>}</#noparse>,
            </if>
                </#if>
            </#list>
            <#list table.fields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                <#noparse>#{</#noparse>${field.name}<#noparse>,jdbcType=VARCHAR}</#noparse>,
            </if>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
            <if test="${field.propertyName} != null">
                <#noparse>#{</#noparse>${field.name}<#noparse>,jdbcType=TIMESTAMP}</#noparse>,
            </if>
                <#else>
            <if test="${field.propertyName} != null">
                <#noparse>#{</#noparse>${field.name}<#noparse>,jdbcType=VARCHAR}</#noparse>,
            </if>
                </#if>
            </#list>
        </trim>
    </insert>

    <!-- 删除 -->
    <delete id="delete${entity}" parameterType="java.lang.String">
        DELETE FROM ${table.name}
        <where>
            <#list table.commonFields as field>
                <#if field.columnType == "STRING">
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=VARCHAR}</#noparse>
            </if>
                <#elseif field.columnType?contains("DATE") || field.columnType?contains("TIME") || field.columnType?contains("YEAR")>
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName}<#noparse>,jdbcType=TIMESTAMP}</#noparse>
            </if>
                <#else>
            <if test="${field.propertyName} != null and ${field.propertyName} != ''">
                AND ${table.name}.${field.name} = <#noparse>#{</#noparse>${field.propertyName},jdbcType=${field.columnType}<#noparse>}</#noparse>
            </if>
                </#if>
            </#list>
        </where>
    </delete>

</mapper>
