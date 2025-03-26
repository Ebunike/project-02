package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.InquiryBean;
import kr.co.soldesk.repository.InquiryRepository;

@Service
public class InquiryService {

	@Autowired
	private InquiryRepository inquiryRepository;
	
	public void inquiry(InquiryBean inquriry) {
		inquiryRepository.inquiry(inquriry);
	}
	public List<InquiryBean> myInquiry(String id){
		return inquiryRepository.myInquiry(id);
	}
	public InquiryBean oneinquiry(int idx) {
		return inquiryRepository.oneinquiry(idx);
	}
}
