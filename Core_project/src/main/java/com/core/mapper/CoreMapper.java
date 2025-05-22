package com.core.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.core.model.Ai_analysisVO;
import com.core.model.Discussion_postVO;
import com.core.model.ProposalVO;
import com.core.model.ProposalVoteVO;
import com.core.model.UserinfoVO;

@Mapper
public interface CoreMapper {
   //로그인
    public UserinfoVO login(UserinfoVO vo);
   // 회원가입
    public int join(UserinfoVO vo);
   // 회원탈퇴
    public int delete(String user_email);
    // 아이디중복확인
    public int checkId(String id);


    /** 정책 제안 저장 */
    void insertProposal(ProposalVO proposal);

    /** 전체 정책 제안 목록 조회 */
    List<ProposalVO> selectAllProposals();

    /** 단일 정책 제안 조회 */
    ProposalVO selectProposalById(@Param("id") int id);
    
    /** 카테고리별 정책 제안 목록 조회 */
    List<ProposalVO> selectByCategory(@Param("category") String category);
    
    /**
     * 유사도 분석 결과 목록 조회
     * @param idea 검색 키워드
     * @return Ai_analysisVO 리스트
     */
    List<Ai_analysisVO> similarSearch(@Param("idea") String idea);
    
 // 사용자가 이미 투표했는지 확인
    ProposalVoteVO checkVote(@Param("prpslNo") int prpslNo, @Param("userId") String userId);

    // 투표 기록 저장
    int insertVote(ProposalVoteVO vote);

    // 좋아요/싫어요 개수 증가
    int incrementAgree(int prpslNo);
    int incrementDisagree(int prpslNo);
    // 토론 게시글 전체 조회
    List<Discussion_postVO> selectAllPosts();

    // 제목 기반 검색
    List<Discussion_postVO> searchPostsByTitle(@Param("keyword") String keyword);

    // 토론 게시글 저장
    void insertDiscussionPost(Discussion_postVO post);

    // 단일 토론 게시글 조회
    Discussion_postVO selectPostById(@Param("id") int discussionId);
}