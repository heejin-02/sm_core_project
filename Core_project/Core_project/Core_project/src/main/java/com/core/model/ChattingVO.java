package com.core.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChattingVO {

	private int chat_no;
	private int droom_no;
	private String chatter;
	private String chat_content;
	private String chat_emoticon;
	private String chat_file;
	private LocalDateTime create_at;
	private String block_yn;
	
	
}
