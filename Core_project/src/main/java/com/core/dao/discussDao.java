package com.core.dao;

import java.util.List;
import java.util.Map;

import com.core.domain.discussComment;
import com.core.domain.discussPost;

public interface discussDao {
	int insertPost(Map<String, Object> paramMap);
    int updatePost(Map<String, Object> paramMap);
    int deletePost(Map<String, Object> paramMap);
    discussPost selectPost(Map<String, Object> paramMap);
    List<discussPost> selectPostList(Map<String, Object> paramMap);

    int insertComment(Map<String, Object> paramMap);
    List<discussComment> selectCommentList(Map<String, Object> paramMap);
}
