package image;

import java.io.File;

import javax.imageio.ImageIO;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

/**
 * 测试 Google Thumbnailator 图片压缩工具
 *
 */
public class CompressTest {
	
	private static String path = "E:\\ImageTest\\";
	private static String srcPath = "E:\\ImageTest\\image.jpg";

	/**
	 * 从图像文件创建缩略图
	 */
	//@Test
	public void test1() throws Exception{
		File img = new java.io.File(srcPath);
		Thumbnails.of(img).size(640, 480).toFile(new File(path + "image0.jpg"));;
	}
	/**
	 * 图片尺寸不变，压缩图片文件大小
	 * scale：缩放倍数，1f 原始大小、0.25 原始图片的 25%
	 * outputQuality：25%的压缩质量
	 */
	//@Test
	public void test2() throws Exception{
		File img = new java.io.File(srcPath);
		Thumbnails.of(img).scale(1f).outputQuality(0.8f).toFile(new File(path + "image1.jpg"));  
	}
	/**
	 * 给图片加水印
	 * watermark(位置，水印图，透明度)
	 * Positions.CENTER 表示水印位置 
	 */
	//@Test
	public void test3() throws Exception{
		Thumbnails.of(srcPath).size(400,400)  
		.watermark(Positions.BOTTOM_RIGHT,ImageIO.read(new File(path + "water.png")),0.5f)  
		.outputQuality(0.8f).toFile(path + "image2.jpg"); 
	}
	
	
	
}
