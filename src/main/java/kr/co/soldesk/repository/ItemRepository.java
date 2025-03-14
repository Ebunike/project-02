package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ItemBean;
import kr.co.soldesk.beans.KitBean;
import kr.co.soldesk.beans.ThemeBean;
import kr.co.soldesk.mapper.ItemMapper;

@Repository
public class ItemRepository {

	
	@Autowired
	private ItemMapper itemMapper;
	
	public void insert_kitItem(ItemBean itemBean, String id) {
		itemMapper.insert_kitItem(itemBean, id);
	}
	public void insert_kit(ItemBean itemBean, KitBean kitBean) {
		itemMapper.insert_kit(itemBean, kitBean);
	}
	public int getTheme_index(ThemeBean themeBean) {
		return itemMapper.getTheme_index(themeBean);
	}
	public List<ItemBean> getAllKit() {
		return itemMapper.getAllKit();
	}
	public ItemBean getItem(int item_index){
		return itemMapper.getItem(item_index);
	}
	public String getSellerName(int seller_index) {
		return itemMapper.getSellerName(seller_index);
	}
}
