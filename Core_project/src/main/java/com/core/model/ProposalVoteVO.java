package com.core.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProposalVoteVO {
    private int prpslNo;
    private String userId;
    private String voteType;  // "LIKE" 또는 "DISLIKE"
}