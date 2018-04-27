package encrypt;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

public class ImgEncrypt {

	private static final int numOfEncAndDec = 0x130732af; // 加密解密秘钥

	private static int dataOfFile = 0; // 文件字节内容

	public static void encFile(File srcFile, File encFile) throws Exception {
		if (!srcFile.exists()) {
			System.out.println("source file not exixt");
			return;
		}

		if (!encFile.exists()) {
			System.out.println("encrypt file created");
			encFile.createNewFile();
		}
		InputStream fis = new FileInputStream(srcFile);
		OutputStream fos = new FileOutputStream(encFile);

		while ((dataOfFile = fis.read()) > -1) {
			fos.write(dataOfFile ^ numOfEncAndDec);
		}

		fis.close();
		fos.flush();
		fos.close();
	}

	public static void decFile(File encFile, File decFile) throws Exception {
		if(!encFile.exists()){
			System.out.println("encrypt file not exixt");
			return;
		}
		if(!decFile.exists()){
			System.out.println("decrypt file created");
			decFile.createNewFile();
		}
		InputStream fis  = new FileInputStream(encFile);
		OutputStream fos = new FileOutputStream(decFile);

		while ((dataOfFile = fis.read()) > -1) {
			fos.write(dataOfFile ^ numOfEncAndDec);
		}
		fis.close();
		fos.flush();
		fos.close();
	}

	/*@SuppressWarnings("unused")
	public static void main(String[] args) {
		File srcFile = new File("E:\\ImageTest\\image1.jpg"); //初始文件
        File encFile = new File("E:\\ImageTest\\image-encFile.jpg"); //加密文件
        File decFile = new File("E:\\ImageTest\\image-decFile.jpg"); //解密文件
        
        try {
        	encFile(new File("E:\\Workspaces\\EclipseProject\\JavaEEProject\\diary\\src\\main\\webapp\\WEB-INF\\upload\\img\\2017\\07\\02\\1498967983133326.JPG"), 
        			srcFile);
//        	decFile(new File("E:\\Workspaces\\EclipseProject\\JavaEEProject\\diary\\src\\main\\webapp\\WEB-INF\\upload\\img\\2017\\08\\03\\1501752370627603.jpg"), 
//        			srcFile);
        } catch (Exception e) {
            e.printStackTrace();
        }  
	}*/
}
