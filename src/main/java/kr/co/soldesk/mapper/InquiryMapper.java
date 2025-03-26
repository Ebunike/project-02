package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.InquiryBean;

@Mapper
public interface InquiryMapper {

    @Insert("INSERT INTO inquiry (inquiry_idx, id, inquiry_category, inquiry_title, inquiry_content, inquiry_reply, inquiry_read, inquiry_replyer, inquiry_date) "
          + "VALUES (inquiry_seq.NEXTVAL, #{id}, #{inquiry_category}, #{inquiry_title}, #{inquiry_content}, NULL, #{inquiry_read}, NULL, SYSDATE)")
    void inquiry(InquiryBean inquiry);
    @Select("select * from inquiry where id=#{id}")
    List<InquiryBean> myInquiry(String id);
    @Select("select * from inquiry where inquiry_idx=#{idx}")
    InquiryBean oneinquiry(int idx);
}