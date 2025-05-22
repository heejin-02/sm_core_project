package com.core.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class discussComment {
    private int commentId;
    private int discussionId;
    private String userId;
    private String opinionType; // 'T(찬성)' or 'F(반대)'
    private String content;
    private LocalDateTime createdAt;

}
