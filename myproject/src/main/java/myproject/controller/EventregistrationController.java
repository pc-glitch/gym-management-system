package myproject.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import myproject.common.page.PageResult;
import myproject.common.utils.Result;
import myproject.convert.EventregistrationConvert;
import myproject.entity.EventregistrationEntity;
import myproject.service.EventregistrationService;
import myproject.query.EventregistrationQuery;
import myproject.vo.EventregistrationVO;
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
* 赛事报名
*/
@RestController
@RequestMapping("eventregistration")
@Tag(name="赛事报名")
@AllArgsConstructor
public class EventregistrationController {
private final EventregistrationService eventregistrationService;
    /**
     * 查看赛事报名分页
     */
    @PostMapping("page")
    @Operation(summary = "分页")
    @SysLog(title = "查看赛事报名分页")
    public Result<PageResult<EventregistrationVO>> page(@RequestBody @Valid EventregistrationQuery query){
        PageResult<EventregistrationVO> page = eventregistrationService.page(query);
        return Result.ok(page);
    }
    /**
     * 查看赛事报名列表
     */
    @PostMapping("list")
    @Operation(summary = "列表")
    @SaIgnore
    @SysLog(title = "查看赛事报名列表")
    public Result<List<EventregistrationVO>> list(@RequestBody @Valid EventregistrationQuery query){
        List<EventregistrationVO> list = eventregistrationService.queryList(query);
        return Result.ok(list);
    }
    /**
     * 查看赛事报名信息
     */
    @PostMapping("/info")
    @Operation(summary = "信息")
    @SysLog(title = "查看赛事报名信息")
    public Result<EventregistrationVO> get(@RequestSingleParam(value = "id") Long id){
        EventregistrationEntity entity = eventregistrationService.getById(id);
        return Result.ok(EventregistrationConvert.INSTANCE.convert(entity));
    }
    /**
     * 保存赛事报名信息
     */
    @PostMapping("save")
    @Operation(summary = "保存")
    @SysLog(title = "保存赛事报名信息")
    public Result<String> save(@RequestBody EventregistrationVO vo){
        eventregistrationService.save(vo);
        return Result.ok();
    }
    /**
     * 修改赛事报名信息
     */
    @PostMapping("update")
    @Operation(summary = "修改")
    @SysLog(title = "修改赛事报名信息")
    public Result<String> update(@RequestBody @Valid EventregistrationVO vo){
        eventregistrationService.update(vo);
        return Result.ok();
    }
    /**
     * 删除赛事报名信息
     */
    @PostMapping("delete")
    @Operation(summary = "删除")
    @SysLog(title = "删除赛事报名信息")
    public Result<String> delete(@RequestBody List<Long> idList){
            eventregistrationService.delete(idList);
            return Result.ok();
    }
    /**
     * 导出赛事报名列表
     */
    @PostMapping("export")
    @Operation(summary = "导出")
    @SysLog(title = "导出赛事报名列表")
    public void export(@RequestBody @Valid EventregistrationQuery query) {
        eventregistrationService.export(query);
    }
    /**
     * 导入赛事报名列表
     */
    @PostMapping("import")
    @Operation(summary = "导入")
    public Result<String> importeventregistration(@RequestSingleParam(value = "file") String file) {
        if (file.isEmpty()) {
            return Result.error("请选择需要上传的文件");
        }
        file = file.replace("api/", "");
        File importFile = new File(file);
        eventregistrationService.importeventregistration(importFile);
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
    LambdaQueryWrapper<EventregistrationEntity> wrapper = Wrappers.lambdaQuery();
    List<Map<String, Object>> result = eventregistrationService.selectValue(params, wrapper);
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
    LambdaQueryWrapper<EventregistrationEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = eventregistrationService.selectTimeStatValue(params, wrapper);
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
    LambdaQueryWrapper<EventregistrationEntity> wrapper = Wrappers.lambdaQuery();
        //		wrapper.orderByDesc(EventregistrationEntity::getCount);
        List<Map<String, Object>> result = eventregistrationService.selectGroup(params, wrapper);
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