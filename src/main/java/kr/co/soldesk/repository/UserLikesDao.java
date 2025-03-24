package kr.co.soldesk.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.UserLikesBean;
import kr.co.soldesk.mapper.OpenRecipeMapper;

@Repository
public class UserLikesDao {

    @Autowired
    private OpenRecipeMapper userLikesMapper;

    // 좋아요 상태 확인
    public UserLikesBean findLike(UserLikesBean userLikesBean) {
        return userLikesMapper.findLike(userLikesBean);
    }

    // 좋아요 추가
    public void addLike(UserLikesBean userLikesBean) {
        userLikesMapper.addLike(userLikesBean);
    }

    // 좋아요 삭제
    public void removeLike(UserLikesBean userLikesBean) {
        userLikesMapper.removeLike(userLikesBean);
    }
}