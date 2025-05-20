package com.core.model;


import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProposalVO {
<<<<<<< HEAD
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
=======
	private int PRPSL_NO ;
	private String ID; //사용자 아이디
	private String CATEGORY; 
	private String TITLE;
	private String CONTENT;
	private String EXPECTATION_EFFECT;
	private LocalDateTime PRPSL_DT;
	private String ST_CD;
	private String PRCS_NM ;
	private String RESULT_CONTENT;
	private int AGREE_CNT;
	private int DISAG_CNT;
	public void setId(String Id) {
		this.ID=Id;		
}
>>>>>>> 94b28914d81d342c37052e4d4223ef832116a89f
}
