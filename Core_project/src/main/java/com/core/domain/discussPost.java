package com.core.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class discussPost {
    private int discussionId;
    private String title;
    private String content;
    private String authorId;
    private LocalDateTime createdAt;

    
}
