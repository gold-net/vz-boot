package org.z.modules.system.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.z.common.constant.CommonConstant;
import org.z.common.system.vo.Result;
import org.z.common.util.JwtUtil;
import org.z.modules.system.entity.SysPermission;
import org.z.modules.system.entity.SysRolePermission;
import org.z.modules.system.model.SysPermissionTree;
import org.z.modules.system.model.TreeModel;
import org.z.modules.system.service.ISysPermissionService;
import org.z.modules.system.service.ISysRolePermissionService;
import org.z.modules.system.util.PermissionDataUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * <p>
 * 菜单权限表 前端控制器
 * </p>
 *
 * @Author scott
 * @since 2018-12-21
 */
@Slf4j
@RestController
@RequestMapping("/sys/permission")
public class SysPermissionController {

    @Autowired
    private ISysPermissionService sysPermissionService;

    @Autowired
    private ISysRolePermissionService sysRolePermissionService;

    /**
     * 加载数据节点
     *
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public Result<List<SysPermissionTree>> list() {
        long start = System.currentTimeMillis();
        Result<List<SysPermissionTree>> result = null;
        try {
            LambdaQueryWrapper<SysPermission> query = new LambdaQueryWrapper<SysPermission>();
            query.eq(SysPermission::getDelFlag, CommonConstant.DEL_FLAG_0);
            query.orderByAsc(SysPermission::getSortNo);
            List<SysPermission> list = sysPermissionService.list(query);
            List<SysPermissionTree> treeList = new ArrayList<>();
            getTreeList(treeList, list, null);
            result = Result.ok(treeList);
            log.info("======获取全部菜单数据=====耗时:" + (System.currentTimeMillis() - start) + "毫秒");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result = Result.error(e.getMessage());
        }
        return result;
    }

    /**
     * 系统菜单列表(一级菜单)
     *
     * @return
     */
    @RequestMapping(value = "/getSystemMenuList", method = RequestMethod.GET)
    public Result<List<SysPermissionTree>> getSystemMenuList() {
        long start = System.currentTimeMillis();
        Result<List<SysPermissionTree>> result;
        try {
            LambdaQueryWrapper<SysPermission> query = new LambdaQueryWrapper<SysPermission>();
            query.eq(SysPermission::getMenuType, CommonConstant.MENU_TYPE_0);
            query.eq(SysPermission::getDelFlag, CommonConstant.DEL_FLAG_0);
            query.orderByAsc(SysPermission::getSortNo);
            List<SysPermission> list = sysPermissionService.list(query);
            List<SysPermissionTree> sysPermissionTreeList = new ArrayList<SysPermissionTree>();
            for (SysPermission sysPermission : list) {
                SysPermissionTree sysPermissionTree = new SysPermissionTree(sysPermission);
                sysPermissionTreeList.add(sysPermissionTree);
            }
            result = Result.ok(sysPermissionTreeList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result = Result.error(e.getMessage());
        }
        log.info("======获取一级菜单数据=====耗时:" + (System.currentTimeMillis() - start) + "毫秒");
        return result;
    }

    /**
     * 查询子菜单
     *
     * @param parentId
     * @return
     */
    @RequestMapping(value = "/getSystemSubmenu", method = RequestMethod.GET)
    public Result<List<SysPermissionTree>> getSystemSubmenu(@RequestParam("parentId") String parentId) {
        Result<List<SysPermissionTree>> result;
        try {
            LambdaQueryWrapper<SysPermission> query = new LambdaQueryWrapper<>();
            query.eq(SysPermission::getParentId, parentId);
            query.eq(SysPermission::getDelFlag, CommonConstant.DEL_FLAG_0);
            query.orderByAsc(SysPermission::getSortNo);
            List<SysPermission> list = sysPermissionService.list(query);
            List<SysPermissionTree> sysPermissionTreeList = new ArrayList<>();
            for (SysPermission sysPermission : list) {
                SysPermissionTree sysPermissionTree = new SysPermissionTree(sysPermission);
                sysPermissionTreeList.add(sysPermissionTree);
            }
            result = Result.ok(sysPermissionTreeList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result = Result.error(e.getMessage());
        }
        return result;
    }

    /**
     * 查询子菜单
     *
     * @param parentIds 父ID（多个采用半角逗号分割）
     * @return 返回 key-value 的 Map
     */
    @GetMapping("/getSystemSubmenuBatch")
    public Result getSystemSubmenuBatch(@RequestParam("parentIds") String parentIds) {
        try {
            LambdaQueryWrapper<SysPermission> query = new LambdaQueryWrapper<>();
            List<String> parentIdList = Arrays.asList(parentIds.split(","));
            query.in(SysPermission::getParentId, parentIdList);
            query.eq(SysPermission::getDelFlag, CommonConstant.DEL_FLAG_0);
            query.orderByAsc(SysPermission::getSortNo);
            List<SysPermission> list = sysPermissionService.list(query);
            Map<Integer, List<SysPermissionTree>> listMap = new HashMap<>();
            for (SysPermission item : list) {
                Integer pid = item.getParentId();
                if (parentIdList.contains(pid)) {
                    List<SysPermissionTree> mapList = listMap.get(pid);
                    if (mapList == null) {
                        mapList = new ArrayList<>();
                    }
                    mapList.add(new SysPermissionTree(item));
                    listMap.put(pid, mapList);
                }
            }
            return Result.ok(listMap);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return Result.error("批量查询子菜单失败：" + e.getMessage());
        }
    }

    /**
     * 查询用户拥有的菜单权限和按钮权限（根据TOKEN）
     *
     * @return
     */
    @RequestMapping(value = "/getUserPermissionByToken", method = RequestMethod.GET)
    public Result<?> getUserPermissionByToken(HttpServletRequest request,
                                              @RequestParam(name = "token", required = false) String token) {
        String username = null;
        // 如果没有传递token，就从header中获取token并获取用户信息
        if (StringUtils.isEmpty(token)) {
            username = JwtUtil.getUserNameByToken(request);
        } else {
            username = JwtUtil.getUsername(token);
        }

        Result<Map<String, Object>> result = new Result<>();
        try {
            if (StringUtils.isEmpty(username)) {
                return Result.error("TOKEN不允许为空！");
            }
            log.info(" ------ 通过令牌获取用户拥有的访问菜单 ---- TOKEN ------ " + token);
            List<SysPermission> metaList = sysPermissionService.queryByUser(username);
            Map<String, Object> json = new HashMap<>();
            List<Map<String, Object>> menujsonArray = new ArrayList<>();
            this.getPermissionJsonArray(menujsonArray, metaList, null);
            List<Map<String, Object>> authjsonArray = new ArrayList<>();
            this.getAuthJsonArray(authjsonArray, metaList);
            //查询所有的权限
            LambdaQueryWrapper<SysPermission> query = new LambdaQueryWrapper<SysPermission>();
            query.eq(SysPermission::getDelFlag, CommonConstant.DEL_FLAG_0);
            query.eq(SysPermission::getMenuType, CommonConstant.MENU_TYPE_2);
            //query.eq(SysPermission::getStatus, "1");
            List<SysPermission> allAuthList = sysPermissionService.list(query);
            List<Map<String, Object>> allauthjsonArray = new ArrayList<>();
            this.getAllAuthJsonArray(allauthjsonArray, allAuthList);
            //路由菜单
            json.put("menu", menujsonArray);
            //按钮权限（用户拥有的权限集合）
            json.put("auth", authjsonArray);
            //全部权限配置集合（按钮权限，访问权限）
            json.put("allAuth", allauthjsonArray);
            result.setResult(json);
            result.success("查询成功");
        } catch (Exception e) {
            result.error500("查询失败:" + e.getMessage());
            log.error(e.getMessage(), e);
        }
        return result;
    }

    /**
     * 添加菜单
     *
     * @param permission
     * @return
     */
    @RequiresRoles({"admin"})
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public Result<SysPermission> add(@RequestBody SysPermission permission) {
        Result<SysPermission> result = new Result<SysPermission>();
        try {
            permission = PermissionDataUtil.intelligentProcessData(permission);
            sysPermissionService.addPermission(permission);
            result.success("添加成功！");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result.error500("操作失败");
        }
        return result;
    }

    /**
     * 编辑菜单
     *
     * @param permission
     * @return
     */
    @RequiresRoles({"admin"})
    @RequestMapping(value = "/edit", method = {RequestMethod.PUT, RequestMethod.POST})
    public Result<SysPermission> edit(@RequestBody SysPermission permission) {
        Result<SysPermission> result = new Result<>();
        try {
            permission = PermissionDataUtil.intelligentProcessData(permission);
            sysPermissionService.editPermission(permission);
            result.success("修改成功！");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result.error500("操作失败");
        }
        return result;
    }

    /**
     * 删除菜单
     *
     * @param id
     * @return
     */
    @RequiresRoles({"admin"})
    @RequestMapping(value = "/delete", method = RequestMethod.DELETE)
    public Result<SysPermission> delete(@RequestParam(name = "id", required = true) String id) {
        Result<SysPermission> result = new Result<>();
        try {
            sysPermissionService.deletePermission(id);
            result.success("删除成功!");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result.error500(e.getMessage());
        }
        return result;
    }

    /**
     * 批量删除菜单
     *
     * @param ids
     * @return
     */
    @RequiresRoles({"admin"})
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.DELETE)
    public Result<SysPermission> deleteBatch(@RequestParam(name = "ids", required = true) String ids) {
        Result<SysPermission> result = new Result<>();
        try {
            String[] arr = ids.split(",");
            for (String id : arr) {
                if (StringUtils.isNotEmpty(id)) {
                    sysPermissionService.deletePermission(id);
                }
            }
            result.success("删除成功!");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result.error500("删除成功!");
        }
        return result;
    }

    /**
     * 获取全部的权限树
     *
     * @return
     */
    @RequestMapping(value = "/queryTreeList", method = RequestMethod.GET)
    public Result<Map<String, Object>> queryTreeList() {
        Result<Map<String, Object>> result = new Result<>();
        // 全部权限ids
        List<Integer> ids = new ArrayList<>();
        try {
            LambdaQueryWrapper<SysPermission> query = new LambdaQueryWrapper<SysPermission>();
            query.eq(SysPermission::getDelFlag, CommonConstant.DEL_FLAG_0);
            query.orderByAsc(SysPermission::getSortNo);
            List<SysPermission> list = sysPermissionService.list(query);
            for (SysPermission sysPer : list) {
                ids.add(sysPer.getId());
            }
            List<TreeModel> treeList = new ArrayList<>();
            getTreeModelList(treeList, list, null);

            Map<String, Object> resMap = new HashMap<String, Object>();
            // 全部树节点数据
            resMap.put("treeList", treeList);
            resMap.put("ids", ids);// 全部树ids
            result.setResult(resMap);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return result;
    }

    /**
     * 异步加载数据节点
     *
     * @return
     */
    @RequestMapping(value = "/queryListAsync", method = RequestMethod.GET)
    public Result<List<TreeModel>> queryAsync(@RequestParam(name = "pid", required = false) String parentId) {
        Result<List<TreeModel>> result = new Result<>();
        try {
            List<TreeModel> list = sysPermissionService.queryListByParentId(parentId);
            if (list == null || list.size() <= 0) {
                result.error500("未找到角色信息");
            } else {
                result.setResult(list);
                result.setSuccess(true);
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }

        return result;
    }

    /**
     * 查询角色授权
     *
     * @return
     */
    @RequestMapping(value = "/queryRolePermission", method = RequestMethod.GET)
    public Result<List<Integer>> queryRolePermission(@RequestParam(name = "roleId") String roleId) {
        Result<List<Integer>> result;
        try {
            List<SysRolePermission> list = sysRolePermissionService.list(new QueryWrapper<SysRolePermission>().lambda().eq(SysRolePermission::getRoleId, roleId));
            result = Result.ok(list.stream().map(SysRolePermission::getPermissionId).collect(Collectors.toList()));
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result = Result.error(e.getMessage());
        }
        return result;
    }

    /**
     * 保存角色授权
     *
     * @return
     */
    @RequestMapping(value = "/saveRolePermission", method = RequestMethod.POST)
    @RequiresRoles({"admin"})
    public Result<String> saveRolePermission(@RequestBody Map<String, String> json) {
        long start = System.currentTimeMillis();
        Result<String> result = new Result<>();
        try {
            Integer roleId = Integer.parseInt(json.get("roleId"));
            String permissionIds = json.get("permissionIds");
            String lastPermissionIds = json.get("lastpermissionIds");
            this.sysRolePermissionService.saveRolePermission(roleId, permissionIds, lastPermissionIds);
            result.success("保存成功！");
            log.info("======角色授权成功=====耗时:" + (System.currentTimeMillis() - start) + "毫秒");
        } catch (Exception e) {
            result.error500("授权失败！");
            log.error(e.getMessage(), e);
        }
        return result;
    }

    private void getTreeList(List<SysPermissionTree> treeList, List<SysPermission> metaList, SysPermissionTree temp) {
        for (SysPermission permission : metaList) {
            Integer tempPid = permission.getParentId();
            SysPermissionTree tree = new SysPermissionTree(permission);
            if (temp == null && tempPid == null) {
                treeList.add(tree);
                if (!tree.getIsLeaf()) {
                    getTreeList(treeList, metaList, tree);
                }
            } else if (temp != null && tempPid != null && tempPid.equals(temp.getId())) {
                temp.getChildren().add(tree);
                if (!tree.getIsLeaf()) {
                    getTreeList(treeList, metaList, tree);
                }
            }

        }
    }

    private void getTreeModelList(List<TreeModel> treeList, List<SysPermission> metaList, TreeModel temp) {
        for (SysPermission permission : metaList) {
            Integer tempPid = permission.getParentId();
            TreeModel tree = new TreeModel(permission);
            if (temp == null && tempPid == null) {
                treeList.add(tree);
                if (!tree.getIsLeaf()) {
                    getTreeModelList(treeList, metaList, tree);
                }
            } else if (temp != null && tempPid != null && tempPid.equals(temp.getKey())) {
                temp.getChildren().add(tree);
                if (!tree.getIsLeaf()) {
                    getTreeModelList(treeList, metaList, tree);
                }
            }

        }
    }

    /**
     * 获取权限JSON数组
     *
     * @param jsonArray
     * @param allList
     */
    private void getAllAuthJsonArray(List<Map<String, Object>> jsonArray, List<SysPermission> allList) {
        Map<String, Object> json = null;
        for (SysPermission permission : allList) {
            json = new HashMap<>();
            json.put("action", permission.getPerms());
            json.put("status", permission.getStatus());
            json.put("type", permission.getPermsType());
            json.put("describe", permission.getTitle());
            jsonArray.add(json);
        }
    }

    /**
     * 获取权限JSON数组
     *
     * @param jsonArray
     * @param metaList
     */
    private void getAuthJsonArray(List<Map<String, Object>> jsonArray, List<SysPermission> metaList) {
        for (SysPermission permission : metaList) {
            if (permission.getMenuType() == null) {
                continue;
            }
            Map<String, Object> json = null;
            if (permission.getMenuType().equals(CommonConstant.MENU_TYPE_2) && CommonConstant.STATUS_1.equals(permission.getStatus())) {
                json = new HashMap<>();
                json.put("action", permission.getPerms());
                json.put("type", permission.getPermsType());
                json.put("describe", permission.getTitle());
                jsonArray.add(json);
            }
        }
    }

    /**
     * 获取菜单JSON数组
     *
     * @param jsonArray
     * @param metaList
     * @param parentJson
     */
    private void getPermissionJsonArray(List<Map<String, Object>> jsonArray, List<SysPermission> metaList, Map<String, Object> parentJson) {
        for (SysPermission permission : metaList) {
            if (permission.getMenuType() == null) {
                continue;
            }
            Integer tempPid = permission.getParentId();
            Map<String, Object> json = getPermissionJsonObject(permission);
            if (json == null) {
                continue;
            }
            if (parentJson == null && tempPid == null) {
                jsonArray.add(json);
                if (!permission.isLeaf()) {
                    getPermissionJsonArray(jsonArray, metaList, json);
                }
            } else if (parentJson != null && tempPid != null && tempPid.equals(parentJson.get("id"))) {
                // 类型( 0：一级菜单 1：子菜单 2：按钮 )
                if (permission.getMenuType().equals(CommonConstant.MENU_TYPE_2)) {
                    Map<String, Object> metaJson = (Map<String, Object>) parentJson.get("meta");
                    if (metaJson.containsKey("permissionList")) {
                        ((List) metaJson.get("permissionList")).add(json);
                    } else {
                        List<Map<String, Object>> permissionList = new ArrayList<>();
                        permissionList.add(json);
                        metaJson.put("permissionList", permissionList);
                    }
                    // 类型( 0：一级菜单 1：子菜单 2：按钮 )
                } else if (permission.getMenuType().equals(CommonConstant.MENU_TYPE_1) || permission.getMenuType().equals(CommonConstant.MENU_TYPE_0)) {
                    if (parentJson.containsKey("children")) {
                        ((List) parentJson.get("children")).add(json);
                    } else {
                        List<Map<String, Object>> children = new ArrayList<>();
                        children.add(json);
                        parentJson.put("children", children);
                    }

                    if (!permission.isLeaf()) {
                        getPermissionJsonArray(jsonArray, metaList, json);
                    }
                }
            }

        }
    }

    /**
     * 根据菜单配置生成路由json
     *
     * @param permission
     * @return
     */
    private Map<String, Object> getPermissionJsonObject(SysPermission permission) {
        Map<String, Object> json = new HashMap<>();
        // 类型(0：一级菜单 1：子菜单 2：按钮)
        if (permission.getMenuType().equals(CommonConstant.MENU_TYPE_2)) {
            return null;
        } else if (permission.getMenuType().equals(CommonConstant.MENU_TYPE_0) || permission.getMenuType().equals(CommonConstant.MENU_TYPE_1)) {
            json.put("id", permission.getId());
            if (permission.isRoute()) {
                json.put("route", "1");// 表示生成路由
            } else {
                json.put("route", "0");// 表示不生成路由
            }

            // 重要规则：路由name (通过URL生成路由name,路由name供前端开发，页面跳转使用)
            if (StringUtils.isNotEmpty(permission.getName())) {
                json.put("name", permission.getName());
            } else {
                json.put("name", urlToRouteName(permission.getUrl()));
            }

            // 是否隐藏路由，默认都是显示的
            if (permission.isHidden()) {
                json.put("hidden", true);
            }
            // 聚合路由
            if (permission.isAlwaysShow()) {
                json.put("alwaysShow", true);
            }
            json.put("component", permission.getComponent());
            Map<String, Object> meta = new HashMap<>();
            String path = permission.getUrl();
            if (!permission.isExternal() && isWWWHttpUrl(permission.getUrl())) {
                path = DigestUtils.md5DigestAsHex(permission.getUrl().getBytes());
                meta.put("url", permission.getUrl());
            }
            json.put("path", path);

            // 由用户设置是否缓存页面 用布尔值
            if (permission.isKeepAlive()) {
                meta.put("keepAlive", true);
            }

            //外链菜单打开方式
            if (permission.isExternal()) {
                meta.put("external", true);
            }

            meta.put("title", permission.getTitle());
            if (permission.getParentId() == null) {
                // 一级菜单跳转地址
                json.put("redirect", permission.getRedirect());
                if (StringUtils.isNotEmpty(permission.getIcon())) {
                    meta.put("icon", permission.getIcon());
                }
            } else {
                if (StringUtils.isNotEmpty(permission.getIcon())) {
                    meta.put("icon", permission.getIcon());
                }
            }
            json.put("meta", meta);
        }

        return json;
    }

    /**
     * @return
     */
    private boolean isWWWHttpUrl(String url) {
        return url != null && (Pattern.matches("^(https?:|mailto:|tel:).*", url) || url.startsWith("{{"));
    }

    /**
     * 通过URL生成路由name（去掉URL前缀斜杠，替换内容中的斜杠‘/’为-） 举例： URL = /isystem/role RouteName =
     * isystem-role
     *
     * @return
     */
    private String urlToRouteName(String url) {
        if (StringUtils.isNotEmpty(url)) {
            if (url.startsWith("/")) {
                url = url.substring(1);
            }
            url = url.replace("/", "-");

            // 特殊标记
            url = url.replace(":", "@");
            return url;
        } else {
            return null;
        }
    }
}
