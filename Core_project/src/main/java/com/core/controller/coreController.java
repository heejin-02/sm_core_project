package com.core.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.core.mapper.CoreMapper;
import com.core.model.ProposalVO;

@Controller
public class coreController {

	// 기본 메서드
	@RequestMapping("/")
	public String main() {
		return "similar_search";
	}
	
	//회원가입 메서드(join)
	
	
	
	
	
	//로그인 메서드(login)
	
	
	
	
	
	//정책 제안 올리기 메서드(proposal_post)
	@Autowired
    private CoreMapper coreMapper;
	 // 1) 정책 제안 작성 폼 보여주기
    @GetMapping("/proposal_post")
    public String showProposalForm(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        return "proposal_post";
    }

    // 2) 정책 제안 제출 처리
    @PostMapping("/proposal_post")
    public String submitProposal(
            @ModelAttribute("proposal") ProposalVO proposal,
            HttpSession session,
            RedirectAttributes rttr) {

        // 로그인 체크
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }

        // 작성자(ID) 세팅
        proposal.setAuthor(session.getAttribute("loginUser").toString());

        // DB에 저장
        coreMapper.insertProposal(proposal);

        // 완료 메시지
        rttr.addFlashAttribute("msg", "제안이 성공적으로 등록되었습니다.");

        // 목록 페이지로 리다이렉트
        return "redirect:/proposal_list";
    }

	
	
	//정책 제안 목록 띄우기 메서드(proposal_list)
	
	
	
	
	
	//유사도 목록 띄우기 메서드(similar_search)
	
	
	
	
	
	//토론방 목록 띄우기 메서드(discuss_list)
	
	
	
	
	
	//토론방 생성하기 메서드(discuss_post)
	
	
	
	
	
	
	//토론방 안 채팅 띄우기 메서드(discuss_room)
	// (제일 나중에하기)
}
