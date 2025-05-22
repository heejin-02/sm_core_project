package com.core.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.core.dao.discussDao;
import com.core.domain.discussComment;
import com.core.domain.discussPost;

@Repository("discussDao")
public class discussDaoImpl implements discussDao {

		@Autowired
		private SqlSession sqlSession;

		@Override
		public int insertPost(Map<String, Object> paramMap) {
			return sqlSession.insert("discuss.insertPost", paramMap);
		}

		@Override
		public int updatePost(Map<String, Object> paramMap) {
			return sqlSession.update("discuss.updatePost", paramMap);
		}

		@Override
		public int deletePost(Map<String, Object> paramMap) {
			return sqlSession.delete("discuss.deletePost", paramMap);
		}

		@Override
		public discussPost selectPost(Map<String, Object> paramMap) {
			return sqlSession.selectOne("discuss.selectPost", paramMap);
		}

		@Override
		public List<discussPost> selectPostList(Map<String, Object> paramMap) {
			return sqlSession.selectList("discuss.selectPostList", paramMap);
		}

		@Override
		public int insertComment(Map<String, Object> paramMap) {
			return sqlSession.insert("discuss.insertComment", paramMap);
		}

		@Override
		public List<discussComment> selectCommentList(Map<String, Object> paramMap) {
			return sqlSession.selectList("discuss.selectCommentList", paramMap);
		}
	}
