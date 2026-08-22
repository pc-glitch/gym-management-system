package myproject.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import myproject.common.page.PageResult;
import myproject.common.utils.Result;
import myproject.convert.ActivityregistrationConvert;
import myproject.entity.ActivityregistrationEntity;
import myproject.service.ActivityregistrationService;
import myproject.query.ActivityregistrationQuery;
import myproject.vo.ActivityregistrationVO;
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
* 活动报名
*/
@RestController
@RequestMapping("activityregistration")
@Tag(name="活动报名")
@AllArgsConstructor
public class ActivityregistrationController {
private final ActivityregistrationService activityregistrationService;
    /**
     * 查看活动报名分页
     */
    @PostMapping("page")
    @Operation(summary = "分页")
    @SysLog(title = "查看活动报名分页")
    public Result<PageResult<ActivityregistrationVO>> page(@RequestBody @Valid ActivityregistrationQuery query){
        PageResult<ActivityregistrationVO> page = activityregistrationService.page(query);
        return Result.ok(page);
    }
    /**
     * 查看活动报名列表
     */
    @PostMapping("list")
    @Operation(summary = "列表")
    @SaIgnore
    @SysLog(title = "查看活动报名列表")
    public Result<List<ActivityregistrationVO>> list(@RequestBody @Valid ActivityregistrationQuery query){
        List<ActivityregistrationVO> list = activityregistrationService.queryList(query);
        return Result.ok(list);
    }
    /**
     * 查看活动报名信息
     */
    @PostMapping("/info")
    @Operation(summary = "信息")
    @SysLog(title = "查看活动报名信息")
    public Result<ActivityregistrationVO> get(@RequestSingleParam(value = "id") Long id){
        ActivityregistrationEntity entity = activityregistrationService.getById(id);
        return Result.ok(ActivityregistrationConvert.INSTANCE.convert(entity));
    }
    /**
     * 保存活动报名信息
     */
    @PostMapping("save")
    @Operation(summary = "保存")
    @SysLog(title = "保存活动报名信息")
    public Result<String> save(@RequestBody ActivityregistrationVO vo){
        activityregistrationService.save(vo);
        return Result.ok();
    }
    /**
     * 修改活动报名信息
     */
    @PostMapping("update")
    @Operation(summary = "修改")
    @SysLog(title = "修改活动报名信息")
    public Result<String> update(@RequestBody @Valid ActivityregistrationVO vo){
        activityregistrationService.update(vo);
        return Result.ok();
    }
    /**
     * 删除活动报名信息
     */
    @PostMapping("delete")
    @Operation(summary = "删除")
    @SysLog(title = "删除活动报名信息")
    public Result<String> delete(@RequestBody List<Long> idList){
            activityregistrationService.delete(idList);
            return Result.ok();
    }
    /**
     * 导出活动报名列表
     */
    @PostMapping("export")
    @Operation(summary = "导出")
    @SysLog(title = "导出活动报名列表")
    public void export(@RequestBody @Valid ActivityregistrationQuery query) {
        activityregistrationService.export(query);
    }
    /**
     * 导入活动报名列表
     */
    @PostMapping("import")
    @Operation(summary = "导入")
    public Result<String> importactivityregistration(@RequestSingleParam(value = "file") String file) {
        if (file.isEmpty()) {
            return Result.error("请选择需要上传的文件");
        }
        file = file.replace("api/", "");
        File importFile = new File(file);
        activityregistrationService.importactivityregistration(importFile);
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
    LambdaQueryWrapper<ActivityregistrationEntity> wrapper = Wrappers.lambdaQuery();
    List<Map<String, Object>> result = activityregistrationService.selectValue(params, wrapper);
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
    LambdaQueryWrapper<ActivityregistrationEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = activityregistrationService.selectTimeStatValue(params, wrapper);
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
    LambdaQueryWrapper<ActivityregistrationEntity> wrapper = Wrappers.lambdaQuery();
        //		wrapper.orderByDesc(ActivityregistrationEntity::getCount);
        List<Map<String, Object>> result = activityregistrationService.selectGroup(params, wrapper);
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
