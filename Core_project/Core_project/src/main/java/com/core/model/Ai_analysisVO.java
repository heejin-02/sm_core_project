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
public class Ai_analysisVO {
<<<<<<< HEAD:Core_project/Core_project/src/main/java/com/core/model/Ai_analysisVO.java
	private int ANALYSIS_NO;
	private int PRPSL_NO;
	private String ANALYSIS_MODEL;
	private String ANALYSIS_RESULT;
	private int SIMILARITY;
	private String RECO_POLICY;
	private LocalDateTime ANALIZED_AT;
	public Date getAnalizedAtDate() {
        if (this.ANALIZED_AT == null) return null;
        return Date.from(this.ANALIZED_AT.atZone(ZoneId.systemDefault()).toInstant());
    }
=======
	private int analysis_no;
	private int prpsl_no;
	private String analysis_model;
	private String analysis_result;
	private int similarity;
	private String reco_policy;
	private LocalDateTime analized_at;
>>>>>>> dc275ca6745981e66533fa19f93ab572ea3c16c3:Core_project/src/main/java/com/core/model/Ai_analysisVO.java
}
