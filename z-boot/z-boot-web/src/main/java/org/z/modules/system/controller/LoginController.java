package org.z.modules.system.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.z.common.constant.CommonConstant;
import org.z.common.system.vo.LoginUser;
import org.z.common.system.vo.Result;
import org.z.common.util.*;
import org.z.component.cache.ZCacheManager;
import org.z.modules.system.entity.SysUser;
import org.z.modules.system.model.SysLoginModel;
import org.z.modules.system.service.ISysBaseAPI;
import org.z.modules.system.service.ISysDictService;
import org.z.modules.system.service.ISysLogService;
import org.z.modules.system.service.ISysUserService;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 登录
 *
 * @author z
 */
@RestController
@RequestMapping("/sys")
@Api(tags = "用户登录")
@Slf4j
public class LoginController {
    @Autowired
    private ISysUserService sysUserService;
    @Autowired
    private ISysBaseAPI sysBaseAPI;
    @Autowired
    private ISysLogService logService;
    @Autowired
    private ISysDictService sysDictService;
    @Autowired
    private ZCacheManager cacheManager;


    @ApiOperation("登录接口")
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public Result<Map<String, Object>> login(@RequestBody SysLoginModel sysLoginModel) {
        Result<Map<String, Object>> result;
        String username = sysLoginModel.getUsername();
        String password = sysLoginModel.getPassword();

        String captcha = sysLoginModel.getCaptcha();
        if (captcha == null) {
            return Result.error("验证码无效");
        }
        String lowerCaseCaptcha = captcha.toLowerCase();
        String realKey = DigestUtils.md5DigestAsHex((lowerCaseCaptcha + sysLoginModel.getCheckKey()).getBytes());
        Object checkCode = cacheManager.get(realKey);
        if (checkCode == null || !checkCode.equals(lowerCaseCaptcha)) {
            return Result.error("验证码错误");
        }
        //1. 校验用户是否有效
        SysUser sysUser = sysUserService.getUserByName(username);
        result = sysUserService.checkUserIsEffective(sysUser);
        if (!result.isSuccess()) {
            return result;
        }

        //2. 校验用户名或密码是否正确
        String userPassword = PasswordUtil.encrypt(username, password, sysUser.getSalt());
        String sysPassword = sysUser.getPassword();
        if (!sysPassword.equals(userPassword)) {
            result.error500("用户名或密码错误");
            return result;
        }

        //用户登录信息
        userInfo(sysUser, result);
        sysBaseAPI.addLog("用户: " + sysUser.getRealname() + ",登录成功！", CommonConstant.LOG_TYPE_1,
                null, sysUser);

        return result;
    }

    /**
     * 退出登录
     *
     * @param request  HttpServletRequest
     * @return Result<Object>
     */
    @RequestMapping(value = "/logout")
    public Result<Object> logout(HttpServletRequest request) {
        //用户退出逻辑
        String token = request.getHeader(CommonConstant.X_ACCESS_TOKEN);
        if (StringUtils.isEmpty(token)) {
            return Result.error("退出登录失败！");
        }
        String username = JwtUtil.getUsername(token);
        LoginUser sysUser = sysBaseAPI.getUserByName(username);
        if (sysUser != null) {
            sysBaseAPI.addLog("用户: " + sysUser.getRealname() + ",退出成功！", CommonConstant.LOG_TYPE_1,
                    null, null);
            log.info(" 用户名:  " + sysUser.getRealname() + ",退出成功！ ");
            //清空用户登录Token缓存
            cacheManager.del(CommonConstant.PREFIX_USER_TOKEN + token);
            //清空用户登录Shiro权限缓存
            cacheManager.del(CommonConstant.PREFIX_USER_SHIRO_CACHE + sysUser.getId());
            //调用shiro的logout
            SecurityUtils.getSubject().logout();
            return Result.ok();
        } else {
            return Result.error("Token无效!");
        }
    }

    /**
     * 获取访问量
     *
     * @return Result<Map < String, Object>>
     */
    @GetMapping("loginfo")
    public Result<Map<String, Object>> logInfo() {
        Result<Map<String, Object>> result = new Result<>();
        Map<String, Object> obj = new HashMap<>(4);
        // 获取一天的开始和结束时间
        Calendar calendar = new GregorianCalendar();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Date dayStart = calendar.getTime();
        calendar.add(Calendar.DATE, 1);
        Date dayEnd = calendar.getTime();
        // 获取系统访问记录
        Long totalVisitCount = logService.findTotalVisitCount();
        obj.put("totalVisitCount", totalVisitCount);
        Long todayVisitCount = logService.findTodayVisitCount(dayStart, dayEnd);
        obj.put("todayVisitCount", todayVisitCount);
        Long todayIp = logService.findTodayIp(dayStart, dayEnd);
        obj.put("todayIp", todayIp);
        result.setResult(obj);
        result.success("登录成功");
        return result;
    }

    /**
     * 获取访问量
     *
     * @return Result<List < Map < String, Object>>>
     */
    @GetMapping("visitInfo")
    public Result<List<Map<String, Object>>> visitInfo() {
        Result<List<Map<String, Object>>> result = new Result<>();
        Calendar calendar = new GregorianCalendar();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        Date dayEnd = calendar.getTime();
        calendar.add(Calendar.DAY_OF_MONTH, -7);
        Date dayStart = calendar.getTime();
        List<Map<String, Object>> list = logService.findVisitCount(dayStart, dayEnd);
        result.setResult(CommonUtil.toLowerCasePageList(list));
        return result;
    }

    /**
     * 用户信息
     *
     * @param sysUser SysUser
     * @param result  Result<Map<String, Object>>
     */
    private void userInfo(SysUser sysUser, Result<Map<String, Object>> result) {
        String sysPassword = sysUser.getPassword();
        String username = sysUser.getUsername();
        // 生成token
        String token = JwtUtil.sign(username, sysPassword);
        // 设置token缓存有效时间
        cacheManager.set(CommonConstant.PREFIX_USER_TOKEN + token, token, JwtUtil.EXPIRE_TIME);

        // 获取用户部门信息
        Map<String, Object> obj = new HashMap<>(4);
        obj.put("token", token);
        obj.put("userInfo", sysUser);
        obj.put("sysAllDictItems", sysDictService.queryAllDictItems());
        obj.put("roles", sysUserService.getUserRolesSet(sysUser.getUsername()));
        result.setResult(obj);
        result.success("登录成功");
    }

    /**
     * 获取加密字符串
     *
     * @return Result<Map < String, String>>
     */
    @GetMapping(value = "/getEncryptedString")
    public Result<Map<String, String>> getEncryptedString() {
        Result<Map<String, String>> result = new Result<>();
        Map<String, String> map = new HashMap<>(2);
        //map.put("key", EncryptedString.key);
        //map.put("iv",EncryptedString.iv);
        result.setResult(map);
        return result;
    }

    /**
     * 后台生成图形验证码 ：有效
     *
     * @param key      String
     * @return Result<Object>
     */
    @ApiOperation("获取验证码")
    @GetMapping(value = "/randomImage/{key}")
    public Result<Object> randomImage(@PathVariable String key) {
        Result<Object> res;
        try {
            String code = RandomUtil.randomString(4);
            String lowerCaseCode = code.toLowerCase();
            String realKey = DigestUtils.md5DigestAsHex((lowerCaseCode + key).getBytes());
            cacheManager.set(realKey, lowerCaseCode, 60 * 1000);
            String base64 = RandImageUtil.generate(code);
            res = Result.ok();
            res.setResult(base64);
        } catch (Exception e) {
            res = Result.error("获取验证码出错");
            log.error("获取验证码出错", e);
        }
        return res;
    }

    /**
     * 短信登录接口
     *
     * @param jsonObject Map<String, String>
     * @return Result<String>
     */
    @PostMapping(value = "/sms")
    public Result<Map<String, Object>> sms(@RequestBody Map<String, String> jsonObject) {
        Result<Map<String, Object>> result = new Result<>();
        String mobile = jsonObject.get("mobile");
        //手机号模式 登录模式: "2"  注册模式: "1"
        String smsMode = jsonObject.get("smsmode");
        log.info(mobile);
        if (StringUtils.isEmpty(mobile)) {
            result.setMessage("手机号不允许为空！");
            result.setSuccess(false);
            return result;
        }
        Object object = cacheManager.get(mobile);
        if (object != null) {
            result.setMessage("验证码10分钟内，仍然有效！");
            result.setSuccess(false);
            return result;
        }
        //随机数
        String captcha = RandomUtil.randomNumbers(6);
        Map<String, String> obj = new HashMap<>(2);
        obj.put("code", captcha);
        try {
            boolean b = false;
            //注册模板
            if (CommonConstant.SMS_TPL_TYPE_1.equals(smsMode)) {
                SysUser sysUser = sysUserService.getUserByPhone(mobile);
                if (sysUser != null) {
                    result.error500(" 手机号已经注册，请直接登录！");
                    return result;
                }
                // send msg
            } else {
                //登录模式，校验用户有效性
                SysUser sysUser = sysUserService.getUserByPhone(mobile);
                result = sysUserService.checkUserIsEffective(sysUser);
                if (!result.isSuccess()) {
                    String message = result.getMessage();
                    if ("该用户不存在，请注册".equals(message)) {
                        result.error500("该用户不存在或未绑定手机号");
                    }
                    return result;
                }

                /**
                 * smsmode 短信模板方式  0 .登录模板、1.注册模板、2.忘记密码模板
                 */
                if (CommonConstant.SMS_TPL_TYPE_0.equals(smsMode)) {
                    //登录模板
                    // send msg
                } else if (CommonConstant.SMS_TPL_TYPE_2.equals(smsMode)) {
                    //忘记密码模板
                    // send msg
                }
            }

            if (b == false) {
                result.setMessage("短信验证码发送失败,请稍后重试");
                result.setSuccess(false);
                return result;
            }
            //验证码10分钟内有效
            cacheManager.set(mobile, captcha, 600);
            result.setSuccess(true);

        } catch (Exception e) {
            log.error(e.getMessage(), e);
            result.error500("短信接口未配置，请联系管理员！");
            return result;
        }
        return result;
    }

    /**
     * 手机号登录接口
     *
     * @param jsonObject ap<String, String>
     * @return Result<Map < String, Object>>
     */
    @ApiOperation("手机号登录接口")
    @PostMapping("/phoneLogin")
    public Result<Map<String, Object>> phoneLogin(@RequestBody Map<String, String> jsonObject) {
        Result<Map<String, Object>> result;
        String phone = jsonObject.get("mobile");

        //校验用户有效性
        SysUser sysUser = sysUserService.getUserByPhone(phone);
        result = sysUserService.checkUserIsEffective(sysUser);
        if (!result.isSuccess()) {
            return result;
        }

        String smsCode = jsonObject.get("captcha");
        Object code = cacheManager.get(phone);
        if (!smsCode.equals(code)) {
            result.setMessage("手机验证码错误");
            return result;
        }
        //用户信息
        userInfo(sysUser, result);
        //添加日志
        sysBaseAPI.addLog("用户名: " + sysUser.getUsername() + ",登录成功！", CommonConstant.LOG_TYPE_1,
                null, sysUser);

        return result;
    }

    /**
     * 图形验证码
     *
     * @param sysLoginModel SysLoginModel
     * @return Result<?>
     */
    @RequestMapping(value = "/checkCaptcha", method = RequestMethod.POST)
    public Result<?> checkCaptcha(@RequestBody SysLoginModel sysLoginModel) {
        String captcha = sysLoginModel.getCaptcha();
        String checkKey = sysLoginModel.getCheckKey();
        if (captcha == null) {
            return Result.error("验证码无效");
        }
        String lowerCaseCaptcha = captcha.toLowerCase();
        String realKey = DigestUtils.md5DigestAsHex((lowerCaseCaptcha + checkKey).getBytes());
        Object checkCode = cacheManager.get(realKey);
        if (checkCode == null || !checkCode.equals(lowerCaseCaptcha)) {
            return Result.error("验证码错误");
        }
        return Result.ok();
    }

}