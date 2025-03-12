package kr.co.soldesk.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.beans.KitBean;
import kr.co.soldesk.beans.MemberBean;
import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.repository.ItemRepository;

@Service
public class ItemService {

	@Autowired
	private ItemRepository itemRepository;
	@Resource(name = "loginMemberBean")
	private MemberBean loginMemberBean;
	
	
	private String saveUploadFile(MultipartFile upload_file) {
		String file_name = System.currentTimeMillis()+"_"
				+FilenameUtils.getBaseName(upload_file.getOriginalFilename())+"."
				+FilenameUtils.getExtension(upload_file.getOriginalFilename());
	      try {
	          upload_file.transferTo(new File("C:/Users/illum/git/project-02/src/main/webapp/upload/"
	                                  +file_name));
	       } catch (Exception e) {
	          e.printStackTrace();
	       }
		return file_name;
	}
	public void insert_kitItem(ItemBean itemBean) {
		String id = loginMemberBean.getId();
		
		
		MultipartFile upload_file = itemBean.getUpload_file();
		
		
		if(upload_file.getSize()>0) {
			
			String file_name = saveUploadFile(upload_file);
			
			if (file_name == null) {
			    System.out.println("파일 이름이 NULL입니다.");
			} else {
				System.out.println(file_name);
			    itemBean.setItem_picture(file_name);
			    itemRepository.insert_kitItem(itemBean, id);
			}
		}
	}
	public void insert_kit(ItemBean itemBean, KitBean kitBean) {
		itemRepository.insert_kit(itemBean, kitBean);
	}
	public int getTheme_index(ThemeBean themeBean) {
		return itemRepository.getTheme_index(themeBean);
	}
	public List<ItemBean> getItem() {
		return itemRepository.getItem();
	}
}
