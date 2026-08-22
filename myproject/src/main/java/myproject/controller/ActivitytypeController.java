package myproject.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import myproject.common.page.PageResult;
import myproject.common.utils.Result;
import myproject.convert.ActivitytypeConvert;
import myproject.entity.ActivitytypeEntity;
import myproject.service.ActivitytypeService;
import myproject.query.ActivitytypeQuery;
import myproject.vo.ActivitytypeVO;
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
/**
* 活动类型
*/
@RestController
@RequestMapping("activitytype")
@Tag(name="活动类型")
@AllArgsConstructor
public class ActivitytypeController {
private final ActivitytypeService activitytypeService;
    /**
     * 查看活动类型分页
     */
    @PostMapping("page")
    @Operation(summary = "分页")
    @SysLog(title = "查看活动类型分页")
    public Result<PageResult<ActivitytypeVO>> page(@RequestBody @Valid ActivitytypeQuery query){
        PageResult<ActivitytypeVO> page = activitytypeService.page(query);
        return Result.ok(page);
    }
    /**
     * 查看活动类型列表
     */
    @PostMapping("list")
    @Operation(summary = "列表")
    @SaIgnore
    @SysLog(title = "查看活动类型列表")
    public Result<List<ActivitytypeVO>> list(@RequestBody @Valid ActivitytypeQuery query){
        List<ActivitytypeVO> list = activitytypeService.queryList(query);
        return Result.ok(list);
    }
    /**
     * 查看活动类型信息
     */
    @PostMapping("/info")
    @Operation(summary = "信息")
    @SysLog(title = "查看活动类型信息")
    public Result<ActivitytypeVO> get(@RequestSingleParam(value = "id") Long id){
        ActivitytypeEntity entity = activitytypeService.getById(id);
        return Result.ok(ActivitytypeConvert.INSTANCE.convert(entity));
    }
    /**
     * 保存活动类型信息
     */
    @PostMapping("save")
    @Operation(summary = "保存")
    @SysLog(title = "保存活动类型信息")
    public Result<String> save(@RequestBody ActivitytypeVO vo){
        activitytypeService.save(vo);
        return Result.ok();
    }
    /**
     * 修改活动类型信息
     */
    @PostMapping("update")
    @Operation(summary = "修改")
    @SysLog(title = "修改活动类型信息")
    public Result<String> update(@RequestBody @Valid ActivitytypeVO vo){
        activitytypeService.update(vo);
        return Result.ok();
    }
    /**
     * 删除活动类型信息
     */
    @PostMapping("delete")
    @Operation(summary = "删除")
    @SysLog(title = "删除活动类型信息")
    public Result<String> delete(@RequestBody List<Long> idList){
            activitytypeService.delete(idList);
            return Result.ok();
    }
    /**
     * 导出活动类型列表
     */
    @PostMapping("export")
    @Operation(summary = "导出")
    @SysLog(title = "导出活动类型列表")
    public void export(@RequestBody @Valid ActivitytypeQuery query) {
        activitytypeService.export(query);
    }
    /**
     * 导入活动类型列表
     */
    @PostMapping("import")
    @Operation(summary = "导入")
    public Result<String> importactivitytype(@RequestSingleParam(value = "file") String file) {
        if (file.isEmpty()) {
            return Result.error("请选择需要上传的文件");
        }
        file = file.replace("api/", "");
        File importFile = new File(file);
        activitytypeService.importactivitytype(importFile);
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
    LambdaQueryWrapper<ActivitytypeEntity> wrapper = Wrappers.lambdaQuery();
    List<Map<String, Object>> result = activitytypeService.selectValue(params, wrapper);
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
    LambdaQueryWrapper<ActivitytypeEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = activitytypeService.selectTimeStatValue(params, wrapper);
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
    LambdaQueryWrapper<ActivitytypeEntity> wrapper = Wrappers.lambdaQuery();
        //		wrapper.orderByDesc(ActivitytypeEntity::getCount);
        List<Map<String, Object>> result = activitytypeService.selectGroup(params, wrapper);
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