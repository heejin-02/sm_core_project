package com.core.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discussion_summaryVO {

	private int discussionId;
	private String summary;
	private Timestamp lastUpdated;
}
