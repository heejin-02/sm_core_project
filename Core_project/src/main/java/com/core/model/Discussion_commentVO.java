package com.core.model;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discussion_commentVO {
    private int        commentId;      // COMMENT_ID (PK)
    private int        discussionId;   // DISCUSSION_ID (FK)
    private String     userId;         // USER_ID
    private String     opinionType;    // OPINION_TYPE ('T' / 'F')
    private String     content;        // CONTENT
    private String		nick;			// NICK
    private Timestamp  createdAt;      // CREATED_AT  <-- java.sql.Timestamp으로 변경
}
