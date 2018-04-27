package diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import diary.pojo.Diary;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import diary.common.vo.SysResult;
import diary.pojo.ValidateTest;

@Controller
public class HomeController {
	@RequestMapping("/{pageName}")
	public String toPage1(@PathVariable String pageName) {
		return pageName;
	}

	@RequestMapping("/exception/{pageName}")
	public String toPage2(@PathVariable String pageName) {
		return "exception/" + pageName;
	}

	@RequestMapping("/error/{pageName}")
	public String toError(@PathVariable String pageName) {
		return "/error/" + pageName;
	}

	@RequestMapping("/validate/test")
	@ResponseBody
	public SysResult validateTest(@Valid ValidateTest validateTest, BindingResult result) {
		if (result.hasErrors()) {
			// 如果没有通过,跳转提示
			Map<String, String> map = getErrors(result);
			return SysResult.build(201, "验证错误", map);
		}
		return SysResult.ok();
	}

	private Map<String, String> getErrors(BindingResult result) {
		Map<String, String> map = new HashMap<String, String>();
		List<FieldError> list = result.getFieldErrors();
		for (FieldError error : list) {
			System.out.println("error.getField():" + error.getField());
			System.out.println("error.getDefaultMessage():" + error.getDefaultMessage());

			map.put(error.getField(), error.getDefaultMessage());
		}
		return map;
	}
}
