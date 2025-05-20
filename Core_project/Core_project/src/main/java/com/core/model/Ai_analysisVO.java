package com.core.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Ai_analysisVO {
	private int analysis_no;
	private int prpsl_no;
	private String analysis_model;
	private String analysis_result;
	private int similarity;
	private String reco_policy;
	private LocalDateTime analized_at;
}
