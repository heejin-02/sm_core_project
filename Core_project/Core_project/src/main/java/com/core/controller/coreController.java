package com.core.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.core.mapper.CoreMapper;
import com.core.model.UserinfoVO;
import org.springframework.ui.Model;

@Controller
public class coreController {

	@Autowired
	private CoreMapper mapper;

	@RequestMapping("/similar_search")
	public String similarSearch() {
		return "similar_search";
	}

	@RequestMapping("/")
	public String home() {
		return "similar_search";
	}

	// 회원가입 메서드(join)
	// 회원가입 폼 페이지 보여주기 (GET 요청)
	@GetMapping("/join")
	public String joinForm() {
		return "join"; // join.jsp 보여줌
	}

	// 회원가입 처리 (POST 요청)
	@PostMapping("/join")
	public String join(UserinfoVO vo, Model model) {
	    System.out.println("id: " + vo.getId());

<<<<<<< HEAD:Core_project/Core_project/src/main/java/com/core/controller/coreController.java
	       if (!pw.equals(pwConfirm)) {
	           model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
	           return "join";
	       }

	       int result = coreMapper.join(vo);

	       if (result > 0) {
	           return "login";
	       } else {
	           model.addAttribute("msg", "회원가입 실패, 다시 시도하세요.");
	           return "join";
	       }
	   }
	
	
	//로그인 메서드(login)
	
	   @RequestMapping("/login")
	    public String login(UserinfoVO vo, HttpSession session,  Model model) {
	        UserinfoVO mvo = coreMapper.login(vo);

	        if (mvo != null) {
	            session.setAttribute("mvo", mvo); // 로그인 성공 시 세션 저장
	            return "similar_search";
	        } else {
	        	 model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
	             return "login";  // 다시 로그인 페이지로 이동
	        }
=======
	    // 필수 필드 null 또는 빈값 체크
	    if (vo.getId() == null || vo.getId().isEmpty() ||
	        vo.getPw() == null || vo.getPw().isEmpty() ||
	        vo.getNick() == null || vo.getNick().isEmpty() ||
	        vo.getRegion() == null || vo.getRegion().isEmpty()) {
	        System.out.println("❗ 필수 입력값 누락");
	        model.addAttribute("msg", "모든 항목을 입력해주세요.");
	        return "join"; // 다시 회원가입 폼으로 이동
>>>>>>> dc275ca6745981e66533fa19f93ab572ea3c16c3:Core_project/src/main/java/com/core/controller/coreController.java
	    }

	    // 파일 없이 기본값 세팅
	    vo.setId_card("default.jpg");  // or "N/A" 등 문자열로 대체 가능

	    // 기본값 세팅
	    vo.setIs_approved("N");
	    vo.setJoined_at(LocalDateTime.now());

	    // DB 저장
	    mapper.join(vo);

	    model.addAttribute("id", vo.getId());
	    return "similar_search"; // 가입 완료 후 이동할 페이지
	}

	// 로그인 메서드(login)

	private void model_addAttribute(String string, String id) {
		// TODO Auto-generated method stub

	}

	@GetMapping("/login")
	public String loginform() {
		return "login"; 
	}
	
	@RequestMapping("/login")
	public String login(UserinfoVO vo, HttpSession session, Model model) {
		UserinfoVO mvo = mapper.login(vo);

		if (mvo != null) {
			session.setAttribute("mvo", mvo); // 로그인 성공 시 세션 저장
			return "similar_search";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "login"; // 다시 로그인 페이지로 이동
		}
	}

	// 로그아웃 메서드(logout)
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return "similar_search";
	}

	// 회원탈퇴 메서드
	@RequestMapping("/delete")
	public String delete(@RequestParam("ID") String id, HttpSession session) {
		int cnt = mapper.delete(id);
		if (cnt > 0) {
			session.invalidate();
		}
		return "similar_search";
	}

	// 정책 제안 올리기 메서드(proposal_post)
	// 정책 제안소 이동 메서드
	@GetMapping("/proposal_list")
	public String proposal_list() {
		return "proposal_list"; // join.jsp 보여줌
	}

	// 정책 제안 목록 띄우기 메서드(proposal_list)

<<<<<<< HEAD:Core_project/Core_project/src/main/java/com/core/controller/coreController.java
        // 작성자(ID) 세팅
        proposal.setId(session.getAttribute("loginUser").toString());
        // 초기 상태 세팅
        proposal.setSt_cd("접수");       // 예: 접수 상태 코드
        proposal.setPrcs_nm("대기");     // 예: 처리 대기
=======
	// 유사도 목록 띄우기 메서드(similar_search)
>>>>>>> dc275ca6745981e66533fa19f93ab572ea3c16c3:Core_project/src/main/java/com/core/controller/coreController.java

	// 토론방 목록 띄우기 메서드(discuss_list)

	// 토론방 생성하기 메서드(discuss_post)

<<<<<<< HEAD:Core_project/Core_project/src/main/java/com/core/controller/coreController.java
	
	
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

        if (idea != null && !idea.trim().isEmpty()) {
            List<Ai_analysisVO> list = coreMapper.similarSearch(idea.trim());
            model.addAttribute("similarList", list);
            model.addAttribute("searched", true);
        }

        return "similar_search";
    }
	
	
	
	//토론방 목록 띄우기 메서드(discuss_list)
	
	
	
	
	
	//토론방 생성하기 메서드(discuss_post)
	
	
	
	
	
	
	//토론방 안 채팅 띄우기 메서드(discuss_room)
=======
	// 토론방 안 채팅 띄우기 메서드(discuss_room)
>>>>>>> dc275ca6745981e66533fa19f93ab572ea3c16c3:Core_project/src/main/java/com/core/controller/coreController.java
	// (제일 나중에하기)
}