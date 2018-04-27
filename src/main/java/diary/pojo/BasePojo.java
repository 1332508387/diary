package diary.pojo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BasePojo {
	/** 创建时间 */
	private Date created;
	/** 最后一次修改时间 */
	private Date updated;
}
