package com.core.model;


import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discuss_roomVO {
	
	
	private int droom_no;
	private String droom_category;
	private String droom_title;
	private String droom_info;
	private String id;
	private int droom_limit;
	private String droom_mg;
	private LocalDateTime create_at;
	private String droom_st;
}
