package diary.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

/**
 * 情绪，与 Diary 一对一
 *
 */
@Setter
@Getter
@Table(name = "tb_mood")
public class Mood extends BasePojo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	/** 情绪名称 */
	private String name;
	
	/** 情绪类型 0、积极1、中性2、消极 */
	private Integer type;
	
	private String remark;
}
