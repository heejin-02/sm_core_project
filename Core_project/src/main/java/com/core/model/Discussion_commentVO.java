package com.core.model;


import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discussion_commentVO {	
	private int commentId;         // COMMENT_ID
    private int discussionId;      // DISCUSSION_ID (외래키)
    private String userId;         // USER_ID
    private String opinionType;    // OPINION_TYPE ('T' 또는 'F')
    private String content;        // CONTENT
    private LocalDateTime createdAt; // CREATED_AT
}
