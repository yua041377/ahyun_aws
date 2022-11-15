package kr.or.ahyun.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import jdk.nashorn.internal.runtime.GlobalConstants;

public class AttachFileMapper {
	
//	public ArrayList<Map<String,String>> fileList = new ArrayList<Map<String,String>>();
	public Map<String,Object> item_info = new HashMap<String,Object>();
	
	public AttachFileMapper(MultipartFile item) throws IOException{
		
//		for(MultipartFile item : items){
			
			if(item != null){
				
				String real_name = FilenameUtils.getName(item.getOriginalFilename());
				
				String baseName = FilenameUtils.getBaseName(real_name);
				
				String extension = FilenameUtils.getExtension(real_name);
				
				String genID = UUID.randomUUID().toString().replace("-", "");
				
				long fileSize = item.getSize();
				
				String save_name = baseName + genID + "." + extension;
				
				saveFile(save_name, item);
				
//				Map<String,String> item_info = new HashMap<String,String>();
				item_info.put("save_file_name", save_name);
				item_info.put("org_file_name", real_name);
				item_info.put("file_size", fileSize);
//				fileList.add(item_info);
//			}
			
		}
		
	}
	

	private void saveFile(String save_name, MultipartFile items){
		
		File saveFile = new File("C:\\Users\\yua04\\Desktop\\Develop\\eGovFrameDev-3.7.0-64bit\\workspace\\ahyun_proc\\src\\main\\webapp\\resources\\img", save_name);
		
		try{
			items.transferTo(saveFile);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

}
