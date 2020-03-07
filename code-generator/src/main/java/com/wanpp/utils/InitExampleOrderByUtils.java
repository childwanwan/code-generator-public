package com.wanpp.utils;

import tk.mybatis.mapper.entity.Example;

/**
 * Copyright (C), 2020-2020, public
 * FileName: InitExampleOrderByUtils
 *
 * @Author: wanpp
 * @Date: 2020-03-07
 * Description: test serviceImpl
 * Version: 1.0
 */
public class InitExampleOrderByUtils {

    /**
     * @title: initExampleOrderBy
     * @description: 初始化排序信息
     * @params: [ dto ]
     * @return: tk.mybatis.mapper.entity.Example
     * @createTime: 2020-03-07
     * @version: 1.0
     * @author: wanpp
     */
    public static<T> Example initExampleOrderBy(Class<T> entityClass,String orderBy) {
        Example example = new Example(entityClass);
        //排序
        if (null != orderBy && !"".equals(orderBy)) {
            if (orderBy.startsWith("+")) {
                //升序
                example.orderBy(orderBy.substring(1)).asc();
            } else {
                //降序
                example.orderBy(orderBy.substring(1)).desc();
            }
        } else {
            //默认排序,不要可移除
            example.orderBy("id").desc();
        }
        return example;
    }

}
