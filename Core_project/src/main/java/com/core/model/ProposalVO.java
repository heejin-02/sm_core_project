package com.core.model;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProposalVO {
   private int PRPSL_NO;
   private String ID;
   private String NICK;
   private String CATEGORY = "";
   private String TITLE;
   private String CONTENT;
   private String EXPECTATION_EFFECT;
   private LocalDateTime PRPSL_DT;
   private String ST_CD;
   private String PRCS_NM;
   private String RESULT_CONTENT; // 제안 배경 및 현황 저장 용도
   private int AGREE_CNT;
   private int DISAG_CNT;
   public String getPrpslDtAsDate() {
       return PRPSL_DT.format(
           DateTimeFormatter.ofPattern("yyyy.MM.dd")
       );
   }
}
