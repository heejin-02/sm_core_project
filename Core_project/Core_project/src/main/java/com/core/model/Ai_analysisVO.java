package com.core.model;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Ai_analysisVO {
    private int analysisNo;         // 컬럼 ANALYSIS_NO
    private int prpslNo;            // 컬럼 PRPSL_NO
    private String analysisModel;   // 컬럼 ANALYSIS_MODEL
    private String analysisResult;  // 컬럼 ANALYSIS_RESULT
    private int similarity;         // 컬럼 SIMILARITY
    private String recoPolicy;      // 컬럼 RECO_POLICY
    private LocalDateTime analizedAt; // 컬럼 ANALIZED_AT
    public Date getAnalizedAtDate() {
    	  return analizedAt == null
    	    ? null
    	    : java.sql.Timestamp.valueOf(analizedAt);
    	}
}