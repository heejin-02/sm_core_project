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
}
