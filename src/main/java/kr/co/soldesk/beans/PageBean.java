package kr.co.soldesk.beans;


public class PageBean {
	
	private int min;//최소 페이지 번호
	
	private int max;//최대 페이지 번호
	
	private int prevPage;//이전 버튼의 페이지 번호
	
	private int nextPage;//다음 버튼의 페이지 번호
	
	private int pageCnt;//전체 페이지 개수
	
	private int currentPage;//현재 페이지 번호
	
	public PageBean(int contentCnt, int currentPage, 
			int contentPageCnt, int paginationCnt) {
	//contentCnt: 전체 게시글의 개수
	//currentPage: 현재 페이지
	//contentPageCnt: 페이지당 글의 개수
	//paginationCnt: 페이지 링크의 개수
		
		this.currentPage = currentPage;
		
		pageCnt = contentCnt / contentPageCnt;
		//30개 글 조회, 페이지 링크의 개수는 3
		if(contentCnt % contentPageCnt > 0) {
			pageCnt++;
		}//31개의 글 조회, 페이지 링크의 개수는 4
		
		min = ((currentPage-1) / contentPageCnt) * contentPageCnt + 1;
		//현재페이지가 1~10면 최소페이지는 1
		//현재페이지가 11~20면 최소페이지는 11
		max = min + paginationCnt - 1;
		//최소페이지가 1이면 최대페이지는 10
		//최소페이지가 11이면 최대페이지는 20
		if(max > pageCnt) {
			max = pageCnt;
		}//최대페이지는 전체 게시글의 개수를 넘지 않게 조정
		
		prevPage = min - 1;//이전버튼 
		nextPage = max + 1;//다음버튼
	}

	public int getMin() {
		return min;
	}

	public int getMax() {
		return max;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public int getCurrentPage() {
		return currentPage;
	}
	
}