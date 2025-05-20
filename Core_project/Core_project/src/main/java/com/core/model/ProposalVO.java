package com.core.model;


import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProposalVO {
	private int PRPSL_NO;
	private String ID;
	private String CATEGORY;
	private String TITLE;
	private String CONTENT;
	private String EXPECTATION_EFFECT;
	private LocalDateTime PRPSL_DT;
	private String ST_CD;
	private String PRCS_NM;
	private String RESULT_CONTENT;
	private int AGREE_CNT;
	private int DISAG_CNT;
	public Date getPrpslDtAsDate() {
	    if (this.PRPSL_DT == null) return null;
	    return Date.from(this.PRPSL_DT.atZone(ZoneId.systemDefault()).toInstant());
	}
}
