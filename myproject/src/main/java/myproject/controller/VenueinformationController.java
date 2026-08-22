package myproject.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import myproject.common.page.PageResult;
import myproject.common.utils.Result;
import myproject.convert.VenueinformationConvert;
import myproject.entity.VenueinformationEntity;
import myproject.service.VenueinformationService;
import myproject.query.VenueinformationQuery;
import myproject.vo.VenueinformationVO;
import org.springframework.web.bind.annotation.*;
import myproject.common.request.RequestSingleParam;
import myproject.common.sysLog.SysLog;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.io.File;
import myproject.service.StoreupService;
import myproject.vo.StoreupVO;
import myproject.common.utils.GloabUtils;
/**
* 场地信息
*/
@RestController
@RequestMapping("venueinformation")
@Tag(name="场地信息")
@AllArgsConstructor
public class VenueinformationController {
private final VenueinformationService venueinformationService;
private final StoreupService storeupService;
    /**
     * 查看场地信息分页
     */
    @PostMapping("page")
    @Operation(summary = "分页")
    @SysLog(title = "查看场地信息分页")
    public Result<PageResult<VenueinformationVO>> page(@RequestBody @Valid VenueinformationQuery query){
        PageResult<VenueinformationVO> page = venueinformationService.page(query);
        return Result.ok(page);
    }
    /**
     * 查看场地信息列表
     */
    @PostMapping("list")
    @Operation(summary = "列表")
    @SaIgnore
    @SysLog(title = "查看场地信息列表")
    public Result<List<VenueinformationVO>> list(@RequestBody @Valid VenueinformationQuery query){
        List<VenueinformationVO> list = venueinformationService.queryList(query);
        return Result.ok(list);
    }
    /**
     * 查看场地信息信息
     */
    @PostMapping("/info")
    @Operation(summary = "信息")
    @SysLog(title = "查看场地信息信息")
    public Result<VenueinformationVO> get(@RequestSingleParam(value = "id") Long id){
        VenueinformationEntity entity = venueinformationService.getById(id);
        StoreupVO storeupVO = new StoreupVO();
        storeupVO.setUserid(GloabUtils.getUserId());
        storeupVO.setRefid(id);
        storeupVO.setType(1);
        storeupVO.setPicture(entity.getPhoto());
        storeupVO.setName(entity.getName());
        storeupVO.setTablename("venueinformation");
        storeupService.save(storeupVO);
        return Result.ok(VenueinformationConvert.INSTANCE.convert(entity));
    }
    @PostMapping("/userCFRecommend")
    @Operation(summary = "根据用户推荐")
    public Result<List<VenueinformationVO>> userCFRecommend(@RequestSingleParam(value = "id") Long id) {
        return Result.ok(venueinformationService.userCFRecommend(id));
    }
    /**
     * 保存场地信息信息
     */
    @PostMapping("save")
    @Operation(summary = "保存")
    @SysLog(title = "保存场地信息信息")
    public Result<String> save(@RequestBody VenueinformationVO vo){
        venueinformationService.save(vo);
        return Result.ok();
    }
    /**
     * 修改场地信息信息
     */
    @PostMapping("update")
    @Operation(summary = "修改")
    @SysLog(title = "修改场地信息信息")
    public Result<String> update(@RequestBody @Valid VenueinformationVO vo){
        venueinformationService.update(vo);
        return Result.ok();
    }
    /**
     * 删除场地信息信息
     */
    @PostMapping("delete")
    @Operation(summary = "删除")
    @SysLog(title = "删除场地信息信息")
    public Result<String> delete(@RequestBody List<Long> idList){
            venueinformationService.delete(idList);
            return Result.ok();
    }
    /**
     * 导出场地信息列表
     */
    @PostMapping("export")
    @Operation(summary = "导出")
    @SysLog(title = "导出场地信息列表")
    public void export(@RequestBody @Valid VenueinformationQuery query) {
        venueinformationService.export(query);
    }
    /**
     * 导入场地信息列表
     */
    @PostMapping("import")
    @Operation(summary = "导入")
    public Result<String> importvenueinformation(@RequestSingleParam(value = "file") String file) {
        if (file.isEmpty()) {
            return Result.error("请选择需要上传的文件");
        }
        file = file.replace("api/", "");
        File importFile = new File(file);
        venueinformationService.importvenueinformation(importFile);
        return Result.ok();
    }
    /**
    * （按值统计）
    */
    @SaIgnore
    @RequestMapping("/value/{xColumnName}/{yColumnName}")
    public Result value(@PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName, HttpServletRequest request) {
    Map<String, Object> params = new HashMap<>();
    params.put("xColumn", xColumnName);
    params.put("yColumn", yColumnName);
    LambdaQueryWrapper<VenueinformationEntity> wrapper = Wrappers.lambdaQuery();
    List<Map<String, Object>> result = venueinformationService.selectValue(params, wrapper);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    for (Map<String, Object> m : result) {
        for (String k : m.keySet()) {
            if (m.get(k) instanceof Date) {
                m.put(k, sdf.format((Date) m.get(k)));
            }
        }
    }
    return Result.ok(result);
    }

    /**
    * （按值统计）时间统计类型
    */
    @SaIgnore
    @RequestMapping("/value/{xColumnName}/{yColumnName}/{timeStatType}")
    public Result valueDay(@PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType, HttpServletRequest request) {
    Map<String, Object> params = new HashMap<>();
    params.put("xColumn", xColumnName);
    params.put("yColumn", yColumnName);
    params.put("timeStatType", timeStatType);
    LambdaQueryWrapper<VenueinformationEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = venueinformationService.selectTimeStatValue(params, wrapper);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (Map<String, Object> m : result) {
            for (String k : m.keySet()) {
                if (m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date) m.get(k)));
                }
            }
        }
    return Result.ok(result);
    }

    /**
    * 分组统计
    */
    @SaIgnore
    @RequestMapping("/group/{columnName}")
    public Result group(@PathVariable("columnName") String columnName, HttpServletRequest request) {
    Map<String, Object> params = new HashMap<>();
    params.put("column", columnName);
    LambdaQueryWrapper<VenueinformationEntity> wrapper = Wrappers.lambdaQuery();
        //		wrapper.orderByDesc(VenueinformationEntity::getCount);
        List<Map<String, Object>> result = venueinformationService.selectGroup(params, wrapper);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (Map<String, Object> m : result) {
            for (String k : m.keySet()) {
                if (m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date) m.get(k)));
                }
            }
        }
    return Result.ok(result);
    }
}