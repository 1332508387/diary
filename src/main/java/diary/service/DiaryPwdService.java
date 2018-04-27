package diary.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import diary.common.util.MD5Util;
import diary.common.util.StringUtil;
import diary.common.vo.SysResult;
import diary.mapper.DiaryPwdMapper;
import diary.pojo.DiaryPwd;
 
@Service
public class DiaryPwdService extends BaseService<DiaryPwd>{
	@Resource
	private DiaryPwdMapper diaryPwdMapper;

	public SysResult checkDiaryPwdByUserId(Long id) {
		DiaryPwd _diaryPwd = new DiaryPwd();
		_diaryPwd.setUserId(id);
		DiaryPwd diaryPwd = this.queryByWhere(_diaryPwd);
		if(null == diaryPwd){
			return SysResult.build(0, "用户未设置日记密码");
		}
		return SysResult.build(1, "用户已设置日记密码");
	}

	public void saveDiaryPwd(DiaryPwd diaryPwd) {
		diaryPwd.setCreated(new Date());
		diaryPwd.setUpdated(diaryPwd.getCreated());
		diaryPwd.setSalt(StringUtil.getRandomString(8));
		String newPwd = MD5Util.md5((MD5Util.md5(diaryPwd.getPassword()) + diaryPwd.getSalt()));
		diaryPwd.setPassword(newPwd);
		this.saveSelective(diaryPwd);
	}

	public SysResult updateDiaryPwd(DiaryPwd diaryPwd, String oldPwd) {
		if(!StringUtils.isNotEmpty(oldPwd)){
			return SysResult.build(201, "原始密码为空");
		}
		DiaryPwd _diaryPwd = new DiaryPwd();
		_diaryPwd.setUserId(diaryPwd.getUserId());
		List<DiaryPwd> diaryPwds = this.diaryPwdMapper.select(_diaryPwd);
		if(diaryPwds.isEmpty()){
			return SysResult.build(201, "");
		}
		_diaryPwd = diaryPwds.get(0);
		String oldPwdMd5 = MD5Util.md5((MD5Util.md5(oldPwd) + _diaryPwd.getSalt()));
		if(!StringUtils.equals(oldPwdMd5, _diaryPwd.getPassword())){
			return SysResult.build(201, "原始密码不正确");
		}
		
		diaryPwd.setId(_diaryPwd.getId());
		diaryPwd.setUpdated(new Date());
		diaryPwd.setSalt(StringUtil.getRandomString(8));
		String newPwdMd5 = MD5Util.md5((MD5Util.md5(diaryPwd.getPassword()) + diaryPwd.getSalt()));
		diaryPwd.setPassword(newPwdMd5);
		
		int num = this.diaryPwdMapper.updateByPrimaryKeySelective(diaryPwd);
		if(num <= 0){
			return SysResult.build(201, "");
		}
		return SysResult.ok();
	}

	public SysResult unLock(DiaryPwd diaryPwd) {
		DiaryPwd _diaryPwd = new DiaryPwd();
		_diaryPwd.setUserId(diaryPwd.getUserId());
		DiaryPwd _diaryPwd2 = this.queryByWhere(_diaryPwd);
		if(null == _diaryPwd2){
			return SysResult.build(201, "");
		}
		
		String md5Pwd = MD5Util.md5((MD5Util.md5(diaryPwd.getPassword()) + _diaryPwd2.getSalt()));
		if(!StringUtils.equals(md5Pwd, _diaryPwd2.getPassword())){
			return SysResult.build(201, "");
		}
		return SysResult.ok();
	}
}
