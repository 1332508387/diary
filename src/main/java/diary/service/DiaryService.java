package diary.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import diary.common.DateFormatContant;
import diary.common.util.DateUtil;
import diary.common.vo.SysResult;
import diary.mapper.DiaryContentMapper;
import diary.mapper.DiaryMapper;
import diary.pojo.Diary;
import diary.pojo.DiaryContent;
import diary.pojo.User;

@Service
public class DiaryService extends BaseService<Diary> {
    @Resource
    private DiaryMapper diaryMapper;
    @Resource
    private DiaryContentMapper diaryContentMapper;

    public Map<String, Object> queryDiaryList(User user, Diary diary, String startTime, String endTime, Integer pageIndex, Integer pageSize) {
        Map<String, Object> result = new HashMap<>();

        List<Diary> diaries = this.diaryMapper.queryDiaryList(user, diary, startTime, endTime, pageIndex, pageSize);
        int count = this.diaryMapper.count(user, diary, startTime, endTime);
        result.put("data", diaries);
        result.put("recordsTotal", count);
        result.put("recordsFiltered", count);
        return result;
    }

    public SysResult saveDiaryAnContent(Diary diary, DiaryContent content) {
        // 判断用户日记是否重复
        Diary _diary = new Diary();
        _diary.setUserId(diary.getUserId());
        _diary.setWriteDate(diary.getWriteDate());
        _diary.setStatus(null);
        List<Diary> diarys = this.diaryMapper.queryDiaryByWrite(_diary);
        if (!diarys.isEmpty()) {
            return SysResult.build(201, "日记已存在，请修改写作日期");
        }

        // 保存日记信息
        diary.setCreated(new Date());
        diary.setUpdated(diary.getCreated());

        diary.setStatus(0);
        if (!StringUtils.equals(DateUtil.getDate(DateFormatContant.FORMAT2),
                DateUtil.getDate(diary.getWriteDate(), DateFormatContant.FORMAT2))) {
            // 设置补写状态
            diary.setStatus(1);
        }
        this.saveSelective(diary);

        // 保存日记内容
        content.setDiaryId(diary.getId());
        content.setCreated(diary.getCreated());
        content.setUpdated(diary.getCreated());
        int num = this.diaryContentMapper.insertSelective(content);
        if (num <= 0) {
            return SysResult.build(201, "日记保存失败");
        }
        return SysResult.build(200, "日记保存成功");
    }

    public SysResult updateDiaryAndContent(Diary diary, DiaryContent content) {
        diary.setUpdated(new Date());
        this.updateSelective(diary);

        content.setDiaryId(diary.getId());
        content.setUpdated(diary.getCreated());
        this.diaryContentMapper.updateByPrimaryKeySelective(content);
        return SysResult.build(200, "日记保存成功");
    }

    // 返回 map 为了配合 aop
    public Map<String, Object> getDiaryById(Long id) {
        Map<String, Object> result = new HashMap<>();
        List<Diary> diaries = new ArrayList<>();
        diaries.add(this.queryById(id));
        result.put("data", diaries);
        return result;
    }

    public Diary getDiaryByWriteDate(Long userId, Date writeDate) {
        return this.diaryMapper.getDiaryByWriteDate(userId, writeDate);
    }
}
