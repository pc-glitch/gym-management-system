package myproject.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import myproject.common.page.PageResult;
import myproject.common.impl.BaseServiceImpl;
import myproject.convert.AdminConvert;
import myproject.entity.AdminEntity;
import myproject.query.AdminQuery;
import myproject.vo.AdminVO;
import myproject.dao.AdminDao;
import myproject.service.AdminService;
import myproject.common.utils.DateUtils;
import myproject.common.excel.ExcelFinishCallBack;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import myproject.common.utils.ExcelUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.io.File;

/**
* 后台管理用户表
*
*/
@Service
@AllArgsConstructor
public class AdminServiceImpl extends BaseServiceImpl<AdminDao, AdminEntity> implements AdminService {

    @Override
    public PageResult<AdminVO> page(AdminQuery query) {
        IPage<AdminEntity> page = baseMapper.selectPage(getPage(query), getWrapper(query));
        return new PageResult<>(AdminConvert.INSTANCE.convertList(page.getRecords()), page.getTotal());
    }

    @Override
    public List<AdminVO> queryList(AdminQuery query) {
        return AdminConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
    }

    private LambdaQueryWrapper<AdminEntity> getWrapper(AdminQuery query){
        LambdaQueryWrapper<AdminEntity> wrapper = Wrappers.lambdaQuery();
                    wrapper.eq(null!=query.getId(), AdminEntity::getId, query.getId());
                    wrapper.eq(StringUtils.isNotEmpty(query.getUsername()), AdminEntity::getUsername, query.getUsername());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPassword()), AdminEntity::getPassword, query.getPassword());
                    wrapper.eq(StringUtils.isNotEmpty(query.getName()), AdminEntity::getName, query.getName());
                    wrapper.eq(StringUtils.isNotEmpty(query.getGender()), AdminEntity::getGender, query.getGender());
                    wrapper.eq(StringUtils.isNotEmpty(query.getPhone()), AdminEntity::getPhone, query.getPhone());
                    wrapper.eq(StringUtils.isNotEmpty(query.getAvatarurl()), AdminEntity::getAvatarurl, query.getAvatarurl());
                    wrapper.eq(StringUtils.isNotEmpty(query.getEmail()), AdminEntity::getEmail, query.getEmail());
                    wrapper.eq(StringUtils.isNotEmpty(query.getRole()), AdminEntity::getRole, query.getRole());
                    wrapper.between(ArrayUtils.isNotEmpty(query.getAddtime()), AdminEntity::getAddtime, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[0] : null, ArrayUtils.isNotEmpty(query.getAddtime()) ? query.getAddtime()[1] : null);
            return wrapper;
    }

    @Override
    public void save(AdminVO vo) {
        AdminEntity entity = AdminConvert.INSTANCE.convert(vo);
        baseMapper.insert(entity);
    }

    @Override
    public void update(AdminVO vo) {
        AdminEntity entity = AdminConvert.INSTANCE.convert(vo);
        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }

    @Override
    @SneakyThrows
    public void export(AdminQuery query) {
        List<AdminVO> list = AdminConvert.INSTANCE.convertList(baseMapper.selectList(getWrapper(query)));
        // 写到浏览器打开
        ExcelUtils.excelExport(AdminVO.class, "后台管理用户表" + DateUtils.format(new Date()), null, list);
    }

    @Override
    @SneakyThrows
    public void importadmin(File file) {
        ExcelUtils.readAnalysis(file, AdminVO.class, new ExcelFinishCallBack<AdminVO>() {
            @Override
            public void doAfterAllAnalysed(List<AdminVO> result) {
                saveAdmins(result);
            }

            @Override
            public void doSaveBatch(List<AdminVO> result) {
                saveAdmins(result);
            }

            private void saveAdmins(List<AdminVO> result) {
                List<AdminEntity> AdminEntities = AdminConvert.INSTANCE.convertEntityList(result);
                saveBatch(AdminEntities);
            }
        });
    }

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, LambdaQueryWrapper<AdminEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, LambdaQueryWrapper<AdminEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, LambdaQueryWrapper<AdminEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }
}