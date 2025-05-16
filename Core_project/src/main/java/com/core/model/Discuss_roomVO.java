package com.core.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discuss_roomVO {
	private int DROOM_NO;
	private String DROOM_CATEGORY;
	private String DROOM_TITLE;
	private String DROOM_INFO;
	private String ID;
	private int DROOM_LIMIT;
}
