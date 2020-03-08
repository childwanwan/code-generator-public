package ${package.Controller};

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${package.Service}.${table.serviceName};
import ${cfg.dtopackage}.dto.${entity}DTO;
import com.wanpp.utils.ReturnCodeData;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
<#else>
    import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
    import ${superControllerClassPackage};
</#if>

import javax.annotation.Resource;
import java.util.List;

/**
 * Copyright (C), 2020-2020, public
 * FileName: ${table.controllerName}
 *
 * @Author: ${author}
 * @Date: ${date}
 * Description: ${table.name!} controller
 * Version: 1.0
 */
<#assign serviceName = table.serviceName ?substring(1,table.serviceName?length)/>
@Api(description = " ${entity ?cap_first} 控制层")
@Slf4j
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping(value = "/${entity ?uncap_first}",produces = "application/json;charset=utf-8")
<#if kotlin>
    class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
    <#if superControllerClass??>
        public class ${table.controllerName} extends ${superControllerClass} {
    <#else>
public class ${table.controllerName} {
    </#if>

    @Resource
    private ${table.serviceName} ${serviceName ?uncap_first};

    /**
     * @title: describeFuzzyList
     * @description: 列表分页模糊查询
     * @params: [ paramsDTO, currentPage, pageSize ]
     * @return: org.springframework.http.ResponseEntity
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @ApiOperation(value = "列表分页查询", notes = "列表分页查询")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "paramsDTO", value = "实体参数信息", required = true, dataType = "${entity}DTO", paramType = "query"),
        @ApiImplicitParam(name = "currentPage", value = "当前页", required = true, dataType = "Integer", paramType = "query"),
        @ApiImplicitParam(name = "pageSize", value = "一页数据条数", required = true, dataType = "Integer", paramType = "query")
    })
    @RequestMapping(value = "/describe_fuzzy_list", method = RequestMethod.GET)
    public ResponseEntity<JSONObject> describeFuzzyList(@ModelAttribute ${entity}DTO paramsDTO,
    @RequestParam(name = "currentPage", required = true) Integer currentPage,
    @RequestParam(name = "pageSize", required = true) Integer pageSize) {
        log.info("准备执行  列表分页模糊查询，传入的参数为：" + JSON.toJSONString(paramsDTO));
        JSONObject data = new JSONObject();
        try {
            //分页
            Page page = PageHelper.startPage(currentPage, pageSize);
            //执行
            List<${entity}DTO> resultDTOList = ${serviceName ?uncap_first}.selectFuzzyByDto(paramsDTO);
            PageInfo<${entity}DTO> pageInfo = page.toPageInfo();
            pageInfo.setList(resultDTOList);
            data.put("data",pageInfo);
            data.put("msg", "列表分页模糊查询成功");
            data.put("code", ReturnCodeData.SUCCESS);
        } catch (Exception e) {
            log.error("执行列表分页模糊查询异常，异常信息为：" + JSON.toJSONString(e));
            data.put("msg", e.toString());
            data.put("code", ReturnCodeData.FAIL);
        }
        log.info("执行列表分页模糊查询完成，准备返回的结果为：" + JSON.toJSONString(data));
        return new ResponseEntity<>(data, HttpStatus.ACCEPTED);
    }

    /**
     * @title: describeList
     * @description: 列表分页精确查询
     * @params: [ paramsDTO, currentPage, pageSize ]
     * @return: org.springframework.http.ResponseEntity
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @ApiOperation(value = "列表分页查询", notes = "列表分页查询")
    @ApiImplicitParams({
    @ApiImplicitParam(name = "paramsDTO", value = "实体参数信息", required = true, dataType = "${entity}DTO", paramType = "query"),
    @ApiImplicitParam(name = "currentPage", value = "当前页", required = true, dataType = "Integer", paramType = "query"),
    @ApiImplicitParam(name = "pageSize", value = "一页数据条数", required = true, dataType = "Integer", paramType = "query")
    })
    @RequestMapping(value = "/describe_list", method = RequestMethod.GET)
    public ResponseEntity<JSONObject> describeList(@ModelAttribute ${entity}DTO paramsDTO,
        @RequestParam(name = "currentPage", required = true) Integer currentPage,
        @RequestParam(name = "pageSize", required = true) Integer pageSize) {
        log.info("准备执行  列表分页查询，传入的参数为：" + JSON.toJSONString(paramsDTO));
        JSONObject data = new JSONObject();
        try {
            //分页
            Page page = PageHelper.startPage(currentPage, pageSize);
            //执行
            List<${entity}DTO> resultDTOList = ${serviceName ?uncap_first}.selectFuzzyByDto(paramsDTO);
            PageInfo<${entity}DTO> pageInfo = page.toPageInfo();
            pageInfo.setList(resultDTOList);
            data.put("data",pageInfo);
            data.put("msg", "列表分页查询成功");
            data.put("code", ReturnCodeData.SUCCESS);
        } catch (Exception e) {
            log.error("执行列表分页查询异常，异常信息为：" + JSON.toJSONString(e));
            data.put("msg", e.toString());
            data.put("code", ReturnCodeData.FAIL);
        }
        log.info("执行列表分页查询完成，准备返回的结果为：" + JSON.toJSONString(data));
        return new ResponseEntity<>(data, HttpStatus.ACCEPTED);
    }


    /**
     * @title: save
     * @description: 数据插入
     * @params: [ paramsDTO ]
     * @return: org.springframework.http.ResponseEntity
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @ApiOperation(value = "数据插入", notes = "数据插入")
    @ApiImplicitParams({@ApiImplicitParam(name = "paramsDTO", value = "实体参数信息", required = true, dataType = "${entity}", paramType = "body")})
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<JSONObject> save(@RequestBody ${entity}DTO paramsDTO) {
        log.info("准备执行 数据插入，传入的参数为：" + JSON.toJSONString(paramsDTO));
        JSONObject data = new JSONObject();
        try {
            //执行
            Integer result = ${serviceName ?uncap_first}.insertDto(paramsDTO);
            data.put("data",result);
            data.put("msg", "数据插入成功");
            data.put("code", ReturnCodeData.SUCCESS);
        } catch (Exception e) {
            log.error("执行 数据插入 异常，异常信息为：" + JSON.toJSONString(e));
            data.put("msg", e.toString());
            data.put("code", ReturnCodeData.FAIL);
        }
        log.info("执行 数据插入完成，准备返回的结果为：" + JSON.toJSONString(data));
        return new ResponseEntity<>(data, HttpStatus.ACCEPTED);
    }

    /**
     * @title: update
     * @description: 数据修改
     * @params: [ paramsDTO ]
     * @return: org.springframework.http.ResponseEntity
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @ApiOperation(value = "数据修改", notes = "数据修改")
    @ApiImplicitParams({@ApiImplicitParam(name = "paramsDTO", value = "实体参数信息", required = true, dataType = "${entity}", paramType = "body")})
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ResponseEntity<JSONObject> update(@RequestBody ${entity}DTO paramsDTO) {
        log.info("准备执行 数据修改，传入的参数为：" + JSON.toJSONString(paramsDTO));
        JSONObject data = new JSONObject();
        try {
            //执行
            Integer result = ${serviceName ?uncap_first}.updateDto(paramsDTO);
            data.put("data",result);
            data.put("msg", "数据修改成功");
            data.put("code", ReturnCodeData.SUCCESS);
        } catch (Exception e) {
            log.error("执行 数据修改 异常，异常信息为：" + JSON.toJSONString(e));
            data.put("msg", e.toString());
            data.put("code", ReturnCodeData.FAIL);
        }
        log.info("执行 数据修改完成，准备返回的结果为：" + JSON.toJSONString(data));
        return new ResponseEntity<>(data, HttpStatus.ACCEPTED);
    }

    /**
     * @title: delete
     * @description: 数据删除
     * @params: [ id ]
     * @return: org.springframework.http.ResponseEntity
     * @createTime: ${date}
     * @version: 1.0
     * @author: ${author}
     */
    @ApiOperation(value = "数据删除", notes = "数据删除")
    @ApiImplicitParams({@ApiImplicitParam(name = "paramsDTO", value = "实体参数信息", required = true, dataType = "${entity}", paramType = "body")})
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ResponseEntity<JSONObject> delete(@RequestBody ${entity}DTO paramsDTO) {
        log.info("准备执行 数据删除，传入的参数为：" + JSON.toJSONString(paramsDTO));
        JSONObject data = new JSONObject();
        try {
            //执行
            Integer result = ${serviceName ?uncap_first}.deleteDto(paramsDTO);
            data.put("data",result);
            data.put("msg", "数据删除成功");
            data.put("code", ReturnCodeData.SUCCESS);
        } catch (Exception e) {
            log.error("执行 数据删除 异常，异常信息为：" + JSON.toJSONString(e));
            data.put("msg", "数据删除失败");
            data.put("code", ReturnCodeData.FAIL);
        }
        log.info("执行 数据删除 完成，准备返回的结果为：" + JSON.toJSONString(data));
        return new ResponseEntity<>(data, HttpStatus.ACCEPTED);
    }

}
</#if>
