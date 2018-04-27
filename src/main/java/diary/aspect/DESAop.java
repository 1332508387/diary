package diary.aspect;


import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.util.Base64Utils;

import diary.common.util.Constant;
import diary.common.util.DESUtil;
import diary.pojo.Diary;
import diary.pojo.DiaryContent;

@Aspect
@Component
public class DESAop {
	/**
	 * 前置通知，持久化日记数据前使用 DES 加密数据
	 * 
	 * @param joinPoint
	 */
	@Before(value = "execution(* diary.service.DiaryService.saveDiaryAnContent(..)) "
			+ "or execution(* diary.service.DiaryService.updateDiaryAndContent(..))")
	public void encode(JoinPoint joinPoint){
		Object[] args = joinPoint.getArgs();
		Diary diary = (Diary) args[0];
		DiaryContent diaryContent = (DiaryContent) args[1];
		 
		String keyword = diary.getKeyword();
		String site = diary.getSite();
		String remark = diary.getRemark();
		String content = diaryContent.getContent();
		
		// DES 加密操作 
		if(StringUtils.isNotEmpty(keyword)){
			String desKeyword = DESUtil.encode(Constant.DES_KEY, keyword);
			diary.setKeyword(Base64Utils.encodeToString(desKeyword.getBytes()));
		}
		if(StringUtils.isNotEmpty(site)){
			String desSite = DESUtil.encode(Constant.DES_KEY, site);
			diary.setSite(Base64Utils.encodeToString(desSite.getBytes()));
		}
		if(StringUtils.isNotEmpty(remark)){
			String desRemark = DESUtil.encode(Constant.DES_KEY, remark);
			diary.setRemark(Base64Utils.encodeToString(desRemark.getBytes()));
		}
		if(StringUtils.isNotEmpty(content)){
			String desContent = DESUtil.encode(Constant.DES_KEY, content);
			diaryContent.setContent(Base64Utils.encodeToString(desContent.getBytes()));
		}
	}
	
	/**
	 * 环绕通知，获取日记数据时，使用 DES 解码数据，返回给客户端
	 * 
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@SuppressWarnings("unchecked")
	@Around(value = "execution(* diary.service.DiaryService.queryDiaryList(..)) "
			+ "or execution(* diary.service.DiaryService.getDiaryById(..))")
	public Map<String, Object> decodeDiary(ProceedingJoinPoint joinPoint) throws Throwable{
		Map<String, Object> result = (Map<String, Object>) joinPoint.proceed();
		
		List<Diary> diaries = (List<Diary>) result.get("data");
		if(diaries.isEmpty()){
			return result;
		}
		for(Diary diary : diaries){
			String keyword = diary.getKeyword();
			String site = diary.getSite();
			String remark = diary.getRemark();
			
			if(StringUtils.isNotEmpty(keyword)){
				String baseKeyword = new String(Base64Utils.decodeFromString(keyword));
				diary.setKeyword(DESUtil.decode(Constant.DES_KEY, baseKeyword));
			}
			if(StringUtils.isNotEmpty(site)){
				String baseSite = new String(Base64Utils.decodeFromString(site));
				diary.setSite(DESUtil.decode(Constant.DES_KEY, baseSite));
			}
			if(StringUtils.isNotEmpty(remark)){
				String baseRemark = new String(Base64Utils.decodeFromString(remark));
				diary.setRemark(DESUtil.decode(Constant.DES_KEY, baseRemark));
			}
		}
		return result;
	}
	
	/**
	 * 使用 DES 解码日记内容
	 * 
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around(value = "execution(* diary.service.DiaryContentService.queryContentById(..))")
	public DiaryContent decodeDiaryContent(ProceedingJoinPoint joinPoint) throws Throwable{
		DiaryContent content = (DiaryContent) joinPoint.proceed();
		if(null == content){
			return content;
		}
		content.setContent(DESUtil.decode(Constant.DES_KEY, 
				new String(Base64Utils.decodeFromString(content.getContent()))));
		return content;
	}
}
