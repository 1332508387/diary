package diary.controller;

import diary.common.vo.SysResult;
import diary.pojo.ExceptionRecord;
import diary.pojo.ExceptionType;
import diary.pojo.User;
import diary.service.ExceptionRecordService;
import diary.service.ExceptionTypeService;
import javafx.beans.binding.LongExpression;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

@RequestMapping("/exception/record")
@RestController
public class ExceptionRecordController {
    @Resource
    private ExceptionRecordService exceptionRecordService;

    @RequestMapping("/getData")
    public Map<String, Object> listExceptionRecord(Integer pageIndex, Integer pageSize, String[] keywords, HttpSession session) {
        Map<String, Object> resultMap = new HashMap<>();
        User user = (User) session.getAttribute("currUser");

        List<String> keys = null;
        if(keywords != null && keywords.length != 0){
            keys = new ArrayList<>();
            for (String key : keywords) {
                keys.add(key);
            }
        }
        List<ExceptionRecord> exceptionRecords = this.exceptionRecordService.listExceptionRecord(user.getId(), pageIndex, pageSize, keys);
        Integer records = this.exceptionRecordService.countByUserId(user.getId(), keys);

        // 改变关键字颜色
        if(keywords != null && keywords.length != 0){
            for (ExceptionRecord record : exceptionRecords) {
                List<ExceptionType> types = record.getExceptionTypes();
                if (types == null || types.isEmpty()) break;
                for (ExceptionType type : types) {
                   if(keys.contains(type.getId() + "")) {
                        type.setName("<span style='color: #CC0100;'>" + type.getName() + "</span>");
                   }
                }
            }
        }

        resultMap.put("data", exceptionRecords);
        resultMap.put("recordsTotal", records);
        resultMap.put("recordsFiltered", records);
        return  resultMap;
    }

    @RequestMapping("/save")
    public SysResult save(ExceptionRecord exceptionRecord, HttpSession session, String[] exceptionTypeIds) {
        try {
            exceptionRecord.setUserId(this.getUserId(session));
            this.exceptionRecordService.saveExceptionRecord(exceptionRecord, exceptionTypeIds);
            return  SysResult.build(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SysResult.build(201, "添加失败");
    }

    @RequestMapping("/update")
    public SysResult update(ExceptionRecord exceptionRecord, String[] exceptionTypeIds, HttpSession session) {
        try {
            exceptionRecord.setUserId(this.getUserId(session));
            this.exceptionRecordService.updateExceptionRecord(exceptionRecord, exceptionTypeIds);
            return SysResult.build(200, "修改成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SysResult.build(201, "修改失败");
    }

    @RequestMapping("/del/{id}")
    public SysResult remove(@PathVariable Long id) {
        try {
            this.exceptionRecordService.deleteById(id);
            return SysResult.build(200, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SysResult.build(201, "删除失败");
    }

    @RequestMapping("/getSolution/{id}")
    public String getSolution(@PathVariable Long id) {
        ExceptionRecord exceptionRecord = this.exceptionRecordService.queryById(id);
        if(exceptionRecord != null) {
            return exceptionRecord.getSolution();
        }
        return  "";
    }

    private Long getUserId(HttpSession session){
        User user = (User) session.getAttribute("currUser");
        return  user.getId();
    }
}
