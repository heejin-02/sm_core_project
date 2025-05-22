package com.core.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discuss_roomVO {

    private int droom_no;               // DROOM_NO
    private String droom_category;      // DROOM_CATEGORY
    private String droom_title;         // DROOM_TITLE
    private String droom_info;          // DROOM_INFO
    private String id;                  // ID (개설자 ID)
    private int droom_limit;            // DROOM_LIMIT
    private String droom_mg;            // DROOM_MG
    private Timestamp create_at;        // CREATED_AT
    private String droom_st;            // DROOM_ST

}
