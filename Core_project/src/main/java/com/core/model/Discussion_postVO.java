package com.core.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discussion_postVO {
    private int discussionId;       // DISCUSSION_ID
    private String title;           // TITLE
    private String content;         // CONTENT
    private String authorId;        // AUTHOR_ID
    private java.sql.Timestamp createdAt; // ← LocalDateTime → Timestamp 로 변경
    private int commentCount; // COMMENTCOUNT
    private String category = ""; // CATEGORY
}
