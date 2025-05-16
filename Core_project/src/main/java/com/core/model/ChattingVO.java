package com.core.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChattingVO {

	private int CHAT_NO;
	private int DROOM_NO;
	private String CHATTER;
	private String CHAT_CONTENT;
	private String CHAT_EMOTICON;
	private String CHAT_FILE;
	private LocalDateTime CREATED_AT;
	private String BLOCK_YN;
	
	
}
