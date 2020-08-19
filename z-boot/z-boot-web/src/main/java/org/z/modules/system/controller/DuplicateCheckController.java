package org.z.modules.system.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.z.common.constant.CommonConstant;
import org.z.common.system.vo.Result;
import org.z.common.util.SqlInjectionUtil;
import org.z.modules.system.mapper.SysDictMapper;
import org.z.modules.system.vo.DuplicateCheckVo;

import javax.servlet.http.HttpServletRequest;

/**
 *
 */
@Slf4j
@RestController
@RequestMapping("/sys/duplicate")
@Api(tags="重复校验")
public class DuplicateCheckController {

	@Autowired
	SysDictMapper sysDictMapper;

	/**
	 * 校验数据是否在系统中是否存在
	 *
	 * @return
	 */
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	@ApiOperation("重复校验接口")
	public Result<Object> doDuplicateCheck(DuplicateCheckVo duplicateCheckVo, HttpServletRequest request) {
		int num = 0;
		log.info("----duplicate check------："+ duplicateCheckVo.toString());
		SqlInjectionUtil.filterContent(new String[]{duplicateCheckVo.getTableName(), duplicateCheckVo.getFieldName()});
		if (StringUtils.isNotBlank(duplicateCheckVo.getDataId())) {
			// [2].编辑页面校验
			num = sysDictMapper.duplicateCheckCountSql(duplicateCheckVo);
		} else {
			// [1].添加页面校验
			num = sysDictMapper.duplicateCheckCountSqlNoDataId(duplicateCheckVo);
		}
		if (num == 0) {
			// 该值可用
			return Result.ok();
		} else {
			// 该值不可用
			return Result.error(CommonConstant.SC_OK_200, "该值不可用，系统中已存在！");
		}
	}
}
