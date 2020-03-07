package ${package.Service};

import ${cfg.dtopackage}.dto.${entity}DTO;
<#-- import ${superServiceClassPackage}; -->

import java.util.List;

/**
 * Copyright (C), 2020-2020, public
 * FileName: ${table.serviceName}
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} service
 * Version: 1.0
 */
<#if kotlin>
    interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} {

    /**
     * @title: selectFuzzyByDto
     * @description: 模糊查询操作
     * @params: [ dto ]
     * @return: java.util.List
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public List<${entity}DTO> selectFuzzyByDto(${entity}DTO dto);

    /**
     * @title: selectByDto
     * @description: 精确查询操作
     * @params: [ dto ]
     * @return: java.util.List
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public List<${entity}DTO> selectByDto(${entity}DTO dto);

    /**
     * @title: insertDto
     * @description: 插入操作
     * @params: [ dto ]
     * @return: Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public Integer insertDto(${entity}DTO dto);

    /**
     * @title: updateDto
     * @description: 修改操作
     * @params: [ dto ]
     * @return: Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public Integer updateDto(${entity}DTO dto);

    /**
     * @title: deleteDto
     * @description: 删除操作
     * @params: [ dto ]
     * @return: Integer
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    public Integer deleteDto(${entity}DTO dto);
}
</#if>
