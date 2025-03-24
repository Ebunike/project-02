package kr.co.soldesk.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import kr.co.soldesk.beans.MainOrderBean;

@Mapper
public interface MainOrderMapper {

	@Insert("insert into MainOrder values(#{order_id}, #{id}, sysdate)")
	public void saveOrder(MainOrderBean newOrder);
	
	@Delete("delete from MainOrder where order_id = #{orderId}")
	public void deleteOrder(String orderId);
}

