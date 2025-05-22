package com.core.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.core.dao.discussDao;
import com.core.domain.discussComment;
import com.core.domain.discussPost;
import com.core.service.discussService;

@Service("discussService")
public class discussServiceImpl implements discussService {

	@Resource(name="discussDao")
	private discussDao discussDao;

	@Override
	public int createPost(Map<String, Object> paramMap) {
		return discussDao.insertPost(paramMap);
	}

	@Override
	public discussPost getPost(Map<String, Object> paramMap) {
		return discussDao.selectPost(paramMap);
	}

	@Override
	public List<discussPost> getPostList(Map<String, Object> paramMap) {
		return discussDao.selectPostList(paramMap);
	}

	@Override
	public int addComment(Map<String, Object> paramMap) {
		return discussDao.insertComment(paramMap);
	}

	@Override
	public List<discussComment> getCommentList(Map<String, Object> paramMap) {
		return discussDao.selectCommentList(paramMap);
	}
}
