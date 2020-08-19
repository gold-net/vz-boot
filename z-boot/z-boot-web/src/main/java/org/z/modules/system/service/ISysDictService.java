package org.z.modules.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.z.common.system.vo.DictModel;
import org.z.modules.system.entity.SysDict;
import org.z.modules.system.entity.SysDictItem;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 字典表 服务类
 * </p>
 *
 * @author z
 */
public interface ISysDictService extends IService<SysDict> {

    List<DictModel> queryDictItemsByCode(String code);

    Map<String, List<DictModel>> queryAllDictItems();

    String queryDictTextByKey(String code, String key);

    /**
     * 根据字典类型删除关联表中其对应的数据
     *
     * @param sysDict
     * @return
     */
    boolean deleteByDictId(SysDict sysDict);

    /**
     * 添加一对多
     */
    Integer saveMain(SysDict sysDict, List<SysDictItem> sysDictItemList);

    /**
     * 查询所有用户  作为字典信息 username -->value,realname -->text
     *
     * @return
     */
    List<DictModel> queryAllUserBackDictModel();

    /**
     * 真实删除
     *
     * @param id
     */
    void deleteOneDictPhysically(String id);

    /**
     * 修改delFlag
     *
     * @param delFlag
     * @param id
     */
    void updateDictDelFlag(int delFlag, String id);

    /**
     * 查询被逻辑删除的数据
     *
     * @return
     */
    List<SysDict> queryDeleteList();

}
