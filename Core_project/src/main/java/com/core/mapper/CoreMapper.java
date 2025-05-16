package com.core.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.core.model.ProposalVO;

@Mapper
public interface CoreMapper {

	/**
     * 정책 제안 저장
     */
    void insertProposal(ProposalVO proposal);

    /**
     * 전체 정책 제안 목록 조회
     */
    List<ProposalVO> selectAllProposals();

    /**
     * 단일 정책 제안 조회
     * @param id PRPSL_NO
     */
    ProposalVO selectProposalById(@Param("id") int id);
}