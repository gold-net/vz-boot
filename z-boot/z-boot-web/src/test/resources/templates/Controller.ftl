package ${package.Controller};

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>
import org.z.common.annotation.AutoLog;
import org.z.common.system.vo.Result;
import ${package.Entity}.${table.entityName};
import ${package.Service}.${table.serviceName};

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;

/**
* <p>
	* ${table.comment!} 前端控制器
	* </p>
*
* @author ${author}
* @since ${date}
*/
@Slf4j
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>
</#if>
	@Autowired
	private ${table.serviceName} ${table.serviceName?uncap_first};

	/**
	 * 分页列表查询
	 *
	 * @param ${table.entityName?uncap_first}
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "${table.comment}-分页列表查询")
	@GetMapping(value = "/list")
	public Result<?> queryPageList(${table.entityName} ${table.entityName?uncap_first},
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<${table.entityName}> queryWrapper = Wrappers.query(${table.entityName?uncap_first});
		Page<${table.entityName}> page = new Page<>(pageNo, pageSize);
		IPage<${table.entityName}> pageList = ${table.serviceName?uncap_first}.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	/**
	 * 添加
	 *
	 * @param ${table.entityName?uncap_first}
	 * @return
	 */
	@AutoLog(value = "${table.comment}-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody ${table.entityName} ${table.entityName?uncap_first}) {
		${table.serviceName?uncap_first}.save(${table.entityName?uncap_first});
		return Result.ok("添加成功！");
	}

	/**
	 * 编辑
	 *
	 * @param ${table.entityName?uncap_first}
	 * @return
	 */
	@AutoLog(value = "${table.comment}-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody ${table.entityName} ${table.entityName?uncap_first}) {
		${table.serviceName?uncap_first}.updateById(${table.entityName?uncap_first});
		return Result.ok("编辑成功!");
	}

	/**
	 * 通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "${table.comment}-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id") String id) {
		${table.serviceName?uncap_first}.removeById(id);
		return Result.ok("删除成功!");
	}

	/**
	 * 批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "${table.comment}-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids") String ids) {
		${table.serviceName?uncap_first}.removeByIds(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功！");
	}

	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "${table.comment}-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id") String id) {
		${table.entityName} ${table.entityName?uncap_first} = ${table.serviceName?uncap_first}.getById(id);
		return Result.ok(${table.entityName?uncap_first});
	}

}
