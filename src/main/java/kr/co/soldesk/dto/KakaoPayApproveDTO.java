package kr.co.soldesk.dto;

import java.util.Date;
import lombok.Data;

/**
 * 카카오페이 결제 승인 응답 DTO
 * 문서: https://developers.kakaopay.com/docs/payment/online/single-payment
 */
@Data
public class KakaoPayApproveDTO {
    private String aid;                  // 요청 고유 번호
    private String tid;                  // 결제 고유 번호
    private String cid;                  // 가맹점 코드
    private String sid;                  // 정기결제용 ID
    private String partner_order_id;     // 가맹점 주문번호
    private String partner_user_id;      // 가맹점 회원 ID
    private String payment_method_type;  // 결제 수단, CARD 또는 MONEY
    private Amount amount;               // 결제 금액 정보
    private CardInfo card_info;          // 결제 카드 정보
    private String item_name;            // 상품명
    private String item_code;            // 상품 코드
    private int quantity;                // 상품 수량
    private Date created_at;             // 결제 준비 요청 시각
    private Date approved_at;            // 결제 승인 시각
    private String payload;              // 결제 요청 시 전달한 요청 데이터
    
    
    
    public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getPartner_order_id() {
		return partner_order_id;
	}

	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}

	public String getPartner_user_id() {
		return partner_user_id;
	}

	public void setPartner_user_id(String partner_user_id) {
		this.partner_user_id = partner_user_id;
	}

	public String getPayment_method_type() {
		return payment_method_type;
	}

	public void setPayment_method_type(String payment_method_type) {
		this.payment_method_type = payment_method_type;
	}

	public Amount getAmount() {
		return amount;
	}

	public void setAmount(Amount amount) {
		this.amount = amount;
	}

	public CardInfo getCard_info() {
		return card_info;
	}

	public void setCard_info(CardInfo card_info) {
		this.card_info = card_info;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_code() {
		return item_code;
	}

	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public Date getApproved_at() {
		return approved_at;
	}

	public void setApproved_at(Date approved_at) {
		this.approved_at = approved_at;
	}

	public String getPayload() {
		return payload;
	}

	public void setPayload(String payload) {
		this.payload = payload;
	}

	@Data
    public static class Amount {
        private int total;             // 총 결제 금액
        private int tax_free;          // 비과세 금액
        private int vat;               // 부가세 금액
        private int point;             // 사용한 포인트 금액
        private int discount;          // 할인 금액
        private int green_deposit;     // 컵 보증금
		public int getTotal() {
			return total;
		}
		public void setTotal(int total) {
			this.total = total;
		}
		public int getTax_free() {
			return tax_free;
		}
		public void setTax_free(int tax_free) {
			this.tax_free = tax_free;
		}
		public int getVat() {
			return vat;
		}
		public void setVat(int vat) {
			this.vat = vat;
		}
		public int getPoint() {
			return point;
		}
		public void setPoint(int point) {
			this.point = point;
		}
		public int getDiscount() {
			return discount;
		}
		public void setDiscount(int discount) {
			this.discount = discount;
		}
		public int getGreen_deposit() {
			return green_deposit;
		}
		public void setGreen_deposit(int green_deposit) {
			this.green_deposit = green_deposit;
		}
        
        
    }
    
    @Data
    public static class CardInfo {
        private String purchase_corp;              // 매입 카드사 한글명
        private String purchase_corp_code;         // 매입 카드사 코드
        private String issuer_corp;                // 카드 발급사 한글명
        private String issuer_corp_code;           // 카드 발급사 코드
        private String kakaopay_purchase_corp;     // 카카오페이 매입사명
        private String kakaopay_purchase_corp_code; // 카카오페이 매입사 코드
        private String kakaopay_issuer_corp;       // 카카오페이 발급사명
        private String kakaopay_issuer_corp_code;  // 카카오페이 발급사 코드
        private String bin;                        // 카드 BIN
        private String card_type;                  // 카드 타입
        private String install_month;              // 할부 개월 수
        private String approved_id;                // 카드사 승인번호
        private String card_mid;                   // 카드사 가맹점 번호
        private String interest_free_install;      // 무이자 할부 여부
        private String card_item_code;             // 카드 상품 코드
		public String getPurchase_corp() {
			return purchase_corp;
		}
		public void setPurchase_corp(String purchase_corp) {
			this.purchase_corp = purchase_corp;
		}
		public String getPurchase_corp_code() {
			return purchase_corp_code;
		}
		public void setPurchase_corp_code(String purchase_corp_code) {
			this.purchase_corp_code = purchase_corp_code;
		}
		public String getIssuer_corp() {
			return issuer_corp;
		}
		public void setIssuer_corp(String issuer_corp) {
			this.issuer_corp = issuer_corp;
		}
		public String getIssuer_corp_code() {
			return issuer_corp_code;
		}
		public void setIssuer_corp_code(String issuer_corp_code) {
			this.issuer_corp_code = issuer_corp_code;
		}
		public String getKakaopay_purchase_corp() {
			return kakaopay_purchase_corp;
		}
		public void setKakaopay_purchase_corp(String kakaopay_purchase_corp) {
			this.kakaopay_purchase_corp = kakaopay_purchase_corp;
		}
		public String getKakaopay_purchase_corp_code() {
			return kakaopay_purchase_corp_code;
		}
		public void setKakaopay_purchase_corp_code(String kakaopay_purchase_corp_code) {
			this.kakaopay_purchase_corp_code = kakaopay_purchase_corp_code;
		}
		public String getKakaopay_issuer_corp() {
			return kakaopay_issuer_corp;
		}
		public void setKakaopay_issuer_corp(String kakaopay_issuer_corp) {
			this.kakaopay_issuer_corp = kakaopay_issuer_corp;
		}
		public String getKakaopay_issuer_corp_code() {
			return kakaopay_issuer_corp_code;
		}
		public void setKakaopay_issuer_corp_code(String kakaopay_issuer_corp_code) {
			this.kakaopay_issuer_corp_code = kakaopay_issuer_corp_code;
		}
		public String getBin() {
			return bin;
		}
		public void setBin(String bin) {
			this.bin = bin;
		}
		public String getCard_type() {
			return card_type;
		}
		public void setCard_type(String card_type) {
			this.card_type = card_type;
		}
		public String getInstall_month() {
			return install_month;
		}
		public void setInstall_month(String install_month) {
			this.install_month = install_month;
		}
		public String getApproved_id() {
			return approved_id;
		}
		public void setApproved_id(String approved_id) {
			this.approved_id = approved_id;
		}
		public String getCard_mid() {
			return card_mid;
		}
		public void setCard_mid(String card_mid) {
			this.card_mid = card_mid;
		}
		public String getInterest_free_install() {
			return interest_free_install;
		}
		public void setInterest_free_install(String interest_free_install) {
			this.interest_free_install = interest_free_install;
		}
		public String getCard_item_code() {
			return card_item_code;
		}
		public void setCard_item_code(String card_item_code) {
			this.card_item_code = card_item_code;
		}
        
        
    }
}