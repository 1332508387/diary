package diary.controller;

import java.io.File;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import diary.common.DateFormatContant;
import diary.common.util.DateUtil;
import diary.common.util.ImgEncrypt;
import diary.common.vo.PicUploadResult;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

@Controller
public class PictureController {

	@Value("${IMAGE_REPOSITORY_PATH}")
	private String IMAGE_REPOSITORY_PATH;
	
	@RequestMapping("/pic/upload")
	@ResponseBody
	public PicUploadResult upload(@RequestParam("uploadPicture") MultipartFile file, HttpServletRequest request){
		PicUploadResult result = new PicUploadResult();
		
		// 获取文件名
		String fileName = file.getOriginalFilename();
		// 截取文件后缀
		String prefix = fileName.substring(fileName.lastIndexOf("."));
		// 图片格式检测
		if(!".jpg".equalsIgnoreCase(prefix) && !".png".equalsIgnoreCase(prefix)
				&& !".gif".equalsIgnoreCase(prefix)){
			result.setError(1);
			return result;
		}
		
		// 获取工程根路径
		String rootPath = request.getSession().getServletContext().getRealPath(IMAGE_REPOSITORY_PATH);
		// 生成图片存放目录
		String picDir = DateUtil.getDate(DateFormatContant.FORMAT1);
		// 图片存放路径
		String picPath = rootPath + File.separator + picDir;
		// 检测目录是否存在
		File _file = new File(picPath);
		if(!_file.exists()){
			_file.mkdirs();
		}
		
		// 生成图片名称：当前时间 + 随机数 + 后缀
		String picName = System.currentTimeMillis() + "" 
					+ (int)RandomUtils.nextInt(100, 1000) + ".mnt";
		_file = new File(picPath, picName);
		// 图片上传
		try {
			//file.transferTo(_file);
			// 改变图片大小，添加水印
			File _fFile = new File(_file.getPath() + ".jpg");
			Thumbnails.of(file.getInputStream()).size(800, 800)
			.watermark(Positions.BOTTOM_RIGHT, 
					ImageIO.read(new File(rootPath, "water.png")),0.5f)
			.toFile(_fFile);
			// 加密图片
			ImgEncrypt.encFile(_fFile, _file);
			_fFile.delete();
			String pic = picDir + "/" + picName;
			result.setUrl("/img?pic="  + Base64Utils.encodeToString(pic.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/img")
	public String getPicture(String pic, HttpServletResponse response, HttpServletRequest request){
		// 获取工程根路径
		String rootPath = request.getSession().getServletContext().getRealPath(IMAGE_REPOSITORY_PATH);
		String imgPath = new String(Base64Utils.decodeFromString(pic));
		File file = new File(rootPath, imgPath);
		String tmpImg = imgPath + ".jpg";
		File tmpFile = new File(rootPath, tmpImg);
		try {
			ImgEncrypt.decFile(file, tmpFile);
			request.getRequestDispatcher(IMAGE_REPOSITORY_PATH + tmpImg).forward(request, response);
			tmpFile.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
