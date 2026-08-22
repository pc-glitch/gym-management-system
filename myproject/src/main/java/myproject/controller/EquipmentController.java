package myproject.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import myproject.common.page.PageResult;
import myproject.common.utils.Result;
import myproject.convert.EquipmentConvert;
import myproject.entity.EquipmentEntity;
import myproject.service.EquipmentService;
import myproject.query.EquipmentQuery;
import myproject.vo.EquipmentVO;
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
* 器材信息
*/
@RestController
@RequestMapping("equipment")
@Tag(name="器材信息")
@AllArgsConstructor
public class EquipmentController {
private final EquipmentService equipmentService;

    /**
     * 查看器材信息分页
     */
    @PostMapping("page")
    @Operation(summary = "分页")
    @SysLog(title = "查看器材信息分页")
    public Result<PageResult<EquipmentVO>> page(@RequestBody @Valid EquipmentQuery query){
        PageResult<EquipmentVO> page = equipmentService.page(query);
        return Result.ok(page);
    }
    /**
     * 查看器材信息列表
     */
    @PostMapping("list")
    @Operation(summary = "列表")
    @SaIgnore
    @SysLog(title = "查看器材信息列表")
    public Result<List<EquipmentVO>> list(@RequestBody @Valid EquipmentQuery query){
        List<EquipmentVO> list = equipmentService.queryList(query);
        return Result.ok(list);
    }
    /**
     * 查看器材信息信息
     */
    @PostMapping("/info")
    @Operation(summary = "信息")
    @SysLog(title = "查看器材信息信息")
    public Result<EquipmentVO> get(@RequestSingleParam(value = "id") Long id){
        EquipmentEntity entity = equipmentService.getById(id);
        return Result.ok(EquipmentConvert.INSTANCE.convert(entity));
    }
    /**
     * 保存器材信息信息
     */
    @PostMapping("save")
    @Operation(summary = "保存")
    @SysLog(title = "保存器材信息信息")
    public Result<String> save(@RequestBody @Valid EquipmentVO vo){
        equipmentService.save(vo);
        return Result.ok();
    }
    /**
     * 修改器材信息信息
     */
    @PostMapping("update")
    @Operation(summary = "修改")
    @SysLog(title = "修改器材信息信息")
    public Result<String> update(@RequestBody @Valid EquipmentVO vo){
        equipmentService.update(vo);
        return Result.ok();
    }
    /**
     * 删除器材信息信息
     */
    @PostMapping("delete")
    @Operation(summary = "删除")
    @SysLog(title = "删除器材信息信息")
    public Result<String> delete(@RequestBody List<Long> idList){
            equipmentService.delete(idList);
            return Result.ok();
    }
    /**
     * 导出器材信息列表
     */
    @PostMapping("export")
    @Operation(summary = "导出")
    @SysLog(title = "导出器材信息列表")
    public void export(@RequestBody @Valid EquipmentQuery query) {
        equipmentService.export(query);
    }
    /**
     * 导入器材信息列表
     */
    @PostMapping("import")
    @Operation(summary = "导入")
    public Result<String> importEquipment(@RequestSingleParam(value = "file") String file) {
        if (file.isEmpty()) {
            return Result.error("请选择需要上传的文件");
        }
        file = file.replace("api/", "");
        File importFile = new File(file);
        equipmentService.importEquipment(importFile);
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
    LambdaQueryWrapper<EquipmentEntity> wrapper = Wrappers.lambdaQuery();
    List<Map<String, Object>> result = equipmentService.selectValue(params, wrapper);
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
    LambdaQueryWrapper<EquipmentEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = equipmentService.selectTimeStatValue(params, wrapper);
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
    LambdaQueryWrapper<EquipmentEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = equipmentService.selectGroup(params, wrapper);
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