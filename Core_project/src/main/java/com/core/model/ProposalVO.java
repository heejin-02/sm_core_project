package com.core.model;


import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProposalVO {

	private int prpsl_no;
	private String id ;
	private String category;
	private String title;
	private String content;
	private String expectation_effect; 
	private LocalDateTime prpsl_dt;
	private String st_cd ;
	private String prcs_nm;
	private String result_content;
	private int agree_cnt;
	private int disag_cnt;

}
