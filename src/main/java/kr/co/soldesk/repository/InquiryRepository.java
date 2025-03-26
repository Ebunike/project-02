package kr.co.soldesk.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.mapper.InquiryMapper;

@Repository
public class InquiryRepository {

	@Autowired
	private InquiryMapper inquiryMapper;
	
	
	public void inquiry(InquiryBean inquiry){
		inquiryMapper.inquiry(inquiry);
	}
	public List<InquiryBean> myInquiry(String id){
		return inquiryMapper.myInquiry(id);
	}
	public InquiryBean oneinquiry(int idx) {
		return inquiryMapper.oneinquiry(idx);
	}
	
}
