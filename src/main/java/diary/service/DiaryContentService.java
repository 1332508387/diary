package diary.service;

import org.springframework.stereotype.Service;

import diary.pojo.DiaryContent;

@Service
public class DiaryContentService extends BaseService<DiaryContent> {
	public DiaryContent queryContentById(Long diaryId) {
		return this.queryById(diaryId);
	}
}
