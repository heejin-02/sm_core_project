package com.core.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.core.mapper.CoreMapper;
import com.core.model.Ai_analysisVO;
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
    public String showProposalForm(Model model, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        // 카테고리 목록
        List<String> categories = Arrays.asList("학교생활", "지역사회", "문화생활", "사회문제");
        model.addAttribute("categories", categories);
        model.addAttribute("proposal", new ProposalVO());
        return "proposal_post";
    }

    // 2) 정책 제안 제출 처리
    @PostMapping("/proposal_post")
    public String submitProposal(
            @ModelAttribute("proposal") ProposalVO proposal,
            Model model,
            HttpSession session,
            RedirectAttributes rttr) {

        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }

        // 작성자(ID) 세팅
        proposal.setId(session.getAttribute("loginUser").toString());
        // 초기 상태 세팅
        proposal.setST_CD("접수");       // 예: 접수 상태 코드
        proposal.setPRCS_NM("대기");     // 예: 처리 대기

        // DB 저장
        coreMapper.insertProposal(proposal);

        // 완료 메시지
        rttr.addFlashAttribute("msg", "제안이 성공적으로 등록되었습니다.");
        return "redirect:/proposal_list";
    }

	
	
	//정책 제안 목록 띄우기 메서드(proposal_list)
    @GetMapping("/proposal_list")
    public String showProposalList(
            @RequestParam(value = "category", required = false, defaultValue = "전체") String category,
            Model model) {
        // 카테고리 탭 데이터
        List<String> categories = Arrays.asList("전체", "학교생활", "지역사회", "문화생활", "사회문제");
        model.addAttribute("categories", categories);
        model.addAttribute("selectedCategory", category);

        // 제안 목록 조회
        List<ProposalVO> proposals;
        if ("전체".equals(category)) {
            proposals = coreMapper.selectAllProposals();
        } else {
            proposals = coreMapper.selectByCategory(category);
        }
        model.addAttribute("proposals", proposals);

        return "proposal_list";
    }
	
	
	
	
	//유사도 목록 띄우기 메서드(similar_search)
    /**
     * @param idea 검색 키워드
     * @param model 뷰로 전달할 모델
     * @return similar_search.jsp 뷰 이름
     */
    @GetMapping("/similar_search")
    public String similarSearch(
            @RequestParam(value = "idea", required = false) String idea,
            Model model) {
        if (idea != null && !idea.isEmpty()) {
            List<Ai_analysisVO> list = coreMapper.similarSearch(idea);
            model.addAttribute("similarList", list);
            model.addAttribute("searched", true);
        }
        return "similar_search"; // /WEB-INF/views/similar_search.jsp
    }
	
	
	
	//토론방 목록 띄우기 메서드(discuss_list)
	
	
	
	
	
	//토론방 생성하기 메서드(discuss_post)
	
	
	
	
	
	
	//토론방 안 채팅 띄우기 메서드(discuss_room)
	// (제일 나중에하기)
}
