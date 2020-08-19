package org.z.modules.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.z.common.system.vo.DictModel;
import org.z.modules.system.entity.SysDict;
import org.z.modules.system.vo.DuplicateCheckVo;

import java.util.List;

/**
 * <p>
 * 字典表 Mapper 接口
 * </p>
 *
 * @author z
 */
public interface SysDictMapper extends BaseMapper<SysDict> {

    List<DictModel> queryDictItemsByCode(@Param("code") String code);

    String queryDictTextByKey(@Param("code") String code, @Param("key") String key);

    /**
     * 查询所有部门 作为字典信息 id -->value,departName -->text
     *
     * @return
     */
    List<DictModel> queryAllDepartBackDictModel();

    /**
     * 查询所有用户  作为字典信息 username -->value,realname -->text
     *
     * @return
     */
    List<DictModel> queryAllUserBackDictModel();

    /**
     * 删除
     *
     * @param id
     */
    @Select("delete from sys_dict where id = #{id}")
    void deleteOneById(@Param("id") String id);

    /**
     * 查询被逻辑删除的数据
     *
     * @return
     */
    @Select("select * from sys_dict where del_flag = 1")
    List<SysDict> queryDeleteList();

    /**
     * 修改状态值
     *
     * @param delFlag
     * @param id
     */
    @Update("update sys_dict set del_flag = #{flag,jdbcType=INTEGER} where id = #{id,jdbcType=VARCHAR}")
    void updateDictDelFlag(@Param("flag") int delFlag, @Param("id") String id);

    /**
     * 重复检查SQL
     *
     * @param duplicateCheckVo
     * @return java.lang.Long
     */
    int duplicateCheckCountSql(DuplicateCheckVo duplicateCheckVo);

    /**
     * 重复检查SQL无id
     *
     * @param duplicateCheckVo
     * @return java.lang.Long
     */
    int duplicateCheckCountSqlNoDataId(DuplicateCheckVo duplicateCheckVo);
}
