package com.core.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discuss_commentVO { //토론장 찬반댓글 관련

	private int COMMENT_ID;
	private int DISCUSSION_ID;
	private String USER_ID;
	private String OPINION_TYPE;
	private String CONTENT;
	private LocalDateTime CREATED_AT;
	
}
