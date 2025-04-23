package kr.co.soldesk.beans;

import java.util.Date;

public class ParticipationBean {
    private int id;
    private int postId;
    private String memberId;
    private Date participationDate;
    private MemberBean member; // 참여자 정보
    private boolean isWaiting; // 대기자 여부

    public ParticipationBean() {
        this.participationDate = new Date();
        this.isWaiting = false;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public Date getParticipationDate() {
        return participationDate;
    }

    public void setParticipationDate(Date participationDate) {
        this.participationDate = participationDate;
    }

    public MemberBean getMember() {
        return member;
    }

    public void setMember(MemberBean member) {
        this.member = member;
    }

    public boolean isWaiting() {
        return isWaiting;
    }

    public void setWaiting(boolean waiting) {
        isWaiting = waiting;
    }
}