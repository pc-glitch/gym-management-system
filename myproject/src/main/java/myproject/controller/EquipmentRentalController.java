package myproject.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import myproject.common.page.PageResult;
import myproject.common.utils.Result;
import myproject.convert.EquipmentRentalConvert;
import myproject.entity.EquipmentRentalEntity;
import myproject.service.EquipmentRentalService;
import myproject.query.EquipmentRentalQuery;
import myproject.vo.EquipmentRentalVO;
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
* 器材租借
*/
@RestController
@RequestMapping("equipmentRental")
@Tag(name="器材租借")
@AllArgsConstructor
public class EquipmentRentalController {
private final EquipmentRentalService equipmentRentalService;

    /**
     * 查看器材租借分页
     */
    @PostMapping("page")
    @Operation(summary = "分页")
    @SysLog(title = "查看器材租借分页")
    public Result<PageResult<EquipmentRentalVO>> page(@RequestBody @Valid EquipmentRentalQuery query){
        PageResult<EquipmentRentalVO> page = equipmentRentalService.page(query);
        return Result.ok(page);
    }
    /**
     * 查看器材租借列表
     */
    @PostMapping("list")
    @Operation(summary = "列表")
    @SaIgnore
    @SysLog(title = "查看器材租借列表")
    public Result<List<EquipmentRentalVO>> list(@RequestBody @Valid EquipmentRentalQuery query){
        List<EquipmentRentalVO> list = equipmentRentalService.queryList(query);
        return Result.ok(list);
    }
    /**
     * 查看器材租借信息
     */
    @PostMapping("/info")
    @Operation(summary = "信息")
    @SysLog(title = "查看器材租借信息")
    public Result<EquipmentRentalVO> get(@RequestSingleParam(value = "id") Long id){
        EquipmentRentalEntity entity = equipmentRentalService.getById(id);
        return Result.ok(EquipmentRentalConvert.INSTANCE.convert(entity));
    }
    /**
     * 保存器材租借信息
     */
    @PostMapping("save")
    @Operation(summary = "保存")
    @SysLog(title = "保存器材租借信息")
    public Result<String> save(@RequestBody @Valid EquipmentRentalVO vo){
        equipmentRentalService.save(vo);
        return Result.ok();
    }
    /**
     * 修改器材租借信息
     */
    @PostMapping("update")
    @Operation(summary = "修改")
    @SysLog(title = "修改器材租借信息")
    public Result<String> update(@RequestBody @Valid EquipmentRentalVO vo){
        equipmentRentalService.update(vo);
        return Result.ok();
    }
    /**
     * 删除器材租借信息
     */
    @PostMapping("delete")
    @Operation(summary = "删除")
    @SysLog(title = "删除器材租借信息")
    public Result<String> delete(@RequestBody List<Long> idList){
            equipmentRentalService.delete(idList);
            return Result.ok();
    }
    /**
     * 导出器材租借列表
     */
    @PostMapping("export")
    @Operation(summary = "导出")
    @SysLog(title = "导出器材租借列表")
    public void export(@RequestBody @Valid EquipmentRentalQuery query) {
        equipmentRentalService.export(query);
    }
    /**
     * 导入器材租借列表
     */
    @PostMapping("import")
    @Operation(summary = "导入")
    public Result<String> importEquipmentRental(@RequestSingleParam(value = "file") String file) {
        if (file.isEmpty()) {
            return Result.error("请选择需要上传的文件");
        }
        file = file.replace("api/", "");
        File importFile = new File(file);
        equipmentRentalService.importEquipmentRental(importFile);
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
    LambdaQueryWrapper<EquipmentRentalEntity> wrapper = Wrappers.lambdaQuery();
    List<Map<String, Object>> result = equipmentRentalService.selectValue(params, wrapper);
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
    LambdaQueryWrapper<EquipmentRentalEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = equipmentRentalService.selectTimeStatValue(params, wrapper);
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
    LambdaQueryWrapper<EquipmentRentalEntity> wrapper = Wrappers.lambdaQuery();
        List<Map<String, Object>> result = equipmentRentalService.selectGroup(params, wrapper);
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
     * 器材归还
     */
    @PostMapping("return")
    @Operation(summary = "器材归还")
    @SysLog(title = "器材归还")
    public Result<String> returnEquipment(@RequestSingleParam(value = "id") Long id) {
        equipmentRentalService.returnEquipment(id);
        return Result.ok("归还成功");
    }
    
    /**
     * 租借器材
     */
    @PostMapping("rent")
    @Operation(summary = "租借器材")
    @SysLog(title = "租借器材")
    public Result<String> rentEquipment(@RequestBody @Valid EquipmentRentalVO vo) {
        equipmentRentalService.rentEquipment(vo);
        return Result.ok("租借申请已提交，请等待管理员审批");
    }
    
    /**
     * 审批租借
     */
    @PostMapping("approve")
    @Operation(summary = "审批租借")
    @SysLog(title = "审批租借")
    public Result<String> approveRental(@RequestBody Map<String, Object> params) {
        try {
            Long id = Long.parseLong(params.get("id").toString());
            String approvalStatus = params.get("approvalStatus").toString();
            String approvalremark = params.get("approvalremark") != null ? params.get("approvalremark").toString() : null;
            equipmentRentalService.approveRental(id, approvalStatus, approvalremark);
            return Result.ok("审批成功");
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
