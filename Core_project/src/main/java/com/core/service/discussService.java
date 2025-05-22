package com.core.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.core.domain.discussComment;
import com.core.domain.discussPost;

@Resource(name = "discussServiceImpl")
public interface discussService {
	int createPost(Map<String, Object> paramMap);
    discussPost getPost(Map<String, Object> paramMap);
    List<discussPost> getPostList(Map<String, Object> paramMap);

    int addComment(Map<String, Object> paramMap);
    List<discussComment> getCommentList(Map<String, Object> paramMap);
}
