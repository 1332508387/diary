package diary.pojo;

import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

/**
 * 日记内容，与日记项一对一
 *
 */
@Setter
@Getter
@Table(name = "tb_diary_content")
public class DiaryContent extends BasePojo {
	@Id
	private Long diaryId;

	/** 日记内容 */
	private String content;
}
