package com.core.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discuss_postVO { //토론장 저장 관련
	
	private int DISCUSSION_ID;
	private String TITLE;
	private String CONTENT;
	private String AUTHOR_ID;
	private LocalDateTime CREATED_AT;

}
