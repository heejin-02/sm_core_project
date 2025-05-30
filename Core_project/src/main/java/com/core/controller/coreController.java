package com.core.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.core.mapper.CoreMapper;
import com.core.model.Ai_analysisVO;
import com.core.model.ProposalVO;
import com.core.model.ProposalVoteVO;
import com.core.model.UserinfoVO;

@Controller
public class coreController {

	@Autowired
	private CoreMapper mapper;

	@RequestMapping("/similar_search")
	public String similarSearch() {
		return "similar_search";
	}

	@RequestMapping("/")
	public String home(@ModelAttribute("joinSuccess") Object joinSuccess) {
		return "similar_search";
	}

	// 회원가입 메서드(join)
	// 회원가입 폼 페이지 보여주기 (GET 요청)
	@GetMapping("/join")
	public String joinForm() {
		return "join"; // join.jsp 보여줌
	}

	// 아이디 중복 확인 AJAX 메서드
	@GetMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam("id") String id) {
		int count = mapper.checkId(id);
		return (count == 0) ? "OK" : "DUPLICATE";
	}

	// 회원가입 처리 (POST 요청)
	@PostMapping("/join")
	public String join(UserinfoVO vo, RedirectAttributes rttr, Model model, HttpSession session) {

		System.out.println("id: " + vo.getId());
		MultipartFile file = vo.getFile();

		// 필수 입력값 체크
		if (vo.getId() == null || vo.getId().isEmpty() || vo.getPw() == null || vo.getPw().isEmpty()
				|| vo.getNick() == null || vo.getNick().isEmpty() || vo.getRegion() == null
				|| vo.getRegion().isEmpty()) {
			System.out.println("❗ 필수 입력값 누락");
			model.addAttribute("msg", "모든 항목을 입력해주세요.");
			return "join";
		}

		// 실제 파일 저장 경로
		String uploadPath = "C:/upload/"; // 또는 상대 경로

		if (file != null && !file.isEmpty()) {
			try {
				// 원래 파일명 가져오기
				String filename = file.getOriginalFilename();

				// 저장할 경로 생성
				File dest = new File(uploadPath + filename);
				file.transferTo(dest); // 실제 파일 저장

				vo.setId_card(filename);
				System.out.println("파일 저장 완료: " + dest.getAbsolutePath());
			} catch (Exception e) {
				e.printStackTrace();
				vo.setId_card("default.jpg");
				System.out.println("파일 저장 실패, 기본값 설정");
			}
		} else {
			vo.setId_card("default.jpg");
		}

		// 기타 정보 세팅
		vo.setIs_approved("N");
		vo.setJoined_at(LocalDateTime.now());

		mapper.join(vo); // DB 저장

		model.addAttribute("joinSuccess", true);
		session.setAttribute("mvo", vo); // 사용자 VO 전체 저장
		session.setAttribute("midx", vo.getId());
		session.setAttribute("nickname", vo.getNick());

		return "similar_search";
	}

	// 로그인 메서드(login)
	@GetMapping("/login")
	public String loginform() {
		return "login";
	}

	@PostMapping("/login")
	public String login(UserinfoVO vo, HttpSession session, Model model) {
	    UserinfoVO mvo = mapper.login(vo);
	    if (mvo != null) {
	        session.setAttribute("mvo", mvo);
	        session.setAttribute("midx", mvo.getId());
	        session.setAttribute("nickname", mvo.getNick());

	        // 세션에 저장된 redirectAfterLogin이 있으면
	        String redirect = (String) session.getAttribute("redirectAfterLogin");
	        if (redirect != null) {
	            session.removeAttribute("redirectAfterLogin");
	            return "redirect:" + redirect;
	        }
	        // 기본 홈으로
	        return "redirect:/";
	    } else {
	        model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
	        return "login";
	    }
	}

	// 로그아웃 메서드(logout)
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return "similar_search";
	}
	
	@PostMapping("/edit_profile")
	public String editProfile(UserinfoVO updatedUser, HttpSession session, RedirectAttributes rttr) {
	    UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
	    if (user == null) {
	        return "redirect:/login";
	    }

	    updatedUser.setId(user.getId()); // 아이디는 세션값으로 고정

	    // 비밀번호가 빈칸이면 기존 비밀번호 유지
	    if (updatedUser.getPw() == null || updatedUser.getPw().isEmpty()) {
	        updatedUser.setPw(user.getPw());
	    }

	    int result = mapper.updateUserInfo(updatedUser);
	    if (result > 0) {
	        session.setAttribute("mvo", updatedUser);
	        session.setAttribute("nickname", updatedUser.getNick());
	        rttr.addFlashAttribute("msg", "회원정보가 수정되었습니다.");
	    } else {
	        rttr.addFlashAttribute("msg", "회원정보 수정 실패");
	    }
	    return "redirect:/edit_profile";
	}
	
	// 게시글 삭제
	   @PostMapping("/proposal_delete")
	   public String deleteProposal(@RequestParam("id") int proposalId, HttpSession session, RedirectAttributes rttr) {
	       UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");

	       if (user == null) {
	           rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
	           return "redirect:/login";
	       }

	       // 제안 작성자인지 확인
	       ProposalVO proposal = mapper.selectProposalById(proposalId);
	       if (proposal == null || !proposal.getID().equals(user.getId())) {
	           rttr.addFlashAttribute("msg", "삭제 권한이 없습니다.");
	           return "redirect:/proposal_list";
	       }

	       int result = mapper.deleteProposalById(proposalId);
	       if (result > 0) {
	           rttr.addFlashAttribute("msg", "제안이 삭제되었습니다.");
	       } else {
	           rttr.addFlashAttribute("msg", "제안 삭제 실패");
	       }

	       return "redirect:/proposal_list";
	   }

	// 회원탈퇴 메서드
	@RequestMapping("/delete")
	public String delete(HttpSession session, RedirectAttributes rttr) {
		UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");

		if (user == null) {
			rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
			return "redirect:/login";
		}

		String id = user.getId(); // 세션에서 ID 꺼냄
		int cnt = mapper.delete(id);

		if (cnt > 0) {
			session.invalidate(); // DB 삭제 성공 시 로그아웃
			rttr.addFlashAttribute("msg", "회원탈퇴가 완료되었습니다.");
		} else {
			rttr.addFlashAttribute("msg", "회원탈퇴에 실패했습니다.");
		}

		return "redirect:/";
	}

// 정책 제안 폼 보여주기
	@GetMapping("/proposal_post")
    public String showProposalForm(Model model, HttpSession session) {
        UserinfoVO mvo = (UserinfoVO) session.getAttribute("mvo");
        if (mvo == null) {
            // 로그인 이후 이 URL로 돌아오도록 세션에 저장
            session.setAttribute("redirectAfterLogin", "/proposal_post");
            return "redirect:/login";
        }
        List<String> categories = Arrays.asList("학교생활", "지역사회", "문화생활", "사회문제");
        model.addAttribute("categories", categories);
        model.addAttribute("proposal", new ProposalVO());
        return "proposal_post";
    }

	// 정책 제안 제출 처리
	 @PostMapping("/proposal_post")
	    public String submitProposal(
	            @ModelAttribute("proposal") ProposalVO proposal,
	            HttpSession session,
	            RedirectAttributes rttr) {

	        UserinfoVO mvo = (UserinfoVO) session.getAttribute("mvo");
	        if (mvo == null) {
	            session.setAttribute("redirectAfterLogin", "/proposal_post");
	            return "redirect:/login";
	        }

		// VO 필드 세팅
		proposal.setID(mvo.getId());
		proposal.setST_CD("접수");
		proposal.setPRCS_NM("대기");
		proposal.setAGREE_CNT(0);
		proposal.setDISAG_CNT(0);
		proposal.setPRPSL_DT(LocalDateTime.now());

		mapper.insertProposal(proposal);
		rttr.addFlashAttribute("msg", "제안이 성공적으로 등록되었습니다.");
        return "redirect:/proposal_list";
    }


	@GetMapping("/proposal_detail")
	public String showProposalDetail(@RequestParam("id") int id, Model model) {

		ProposalVO proposal = mapper.selectProposalById(id);
		if (proposal == null) {
			// (Optional) redirect or 404 handling
			return "redirect:/proposal_list";
		}

		model.addAttribute("proposal", proposal);
		return "proposal_detail";
	}

	// 유사도 목록 띄우기 메서드(search)
	@PostMapping("/search")
	public String searchPolicy(@RequestParam("input") String input, Model model) {

		String apiUrl = "http://192.168.219.72:8000/predict";

		// 요청 본문 설정
		Map<String, String> requestBody = new HashMap<>();
		requestBody.put("input", input);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, request, Map.class);

		if (response.getStatusCode() == HttpStatus.OK) {
			Map<String, Object> result = response.getBody();

			// FastAPI 응답에서 results 리스트 꺼내기
			model.addAttribute("query", result.get("query"));
			model.addAttribute("list", result.get("results")); // <-- JSP에서 ${list} 사용 가능
		} else {
			model.addAttribute("error", "FastAPI 서버 요청 실패");
		}

		return "similar_search"; // JSP 파일 이름
	}

	@PostMapping("/proposal/vote")
	@ResponseBody
	public ResponseEntity<String> voteProposal(@RequestParam("id") int proposalId,
	                                           @RequestParam("voteType") String voteType,
	                                           HttpSession session) {

	    UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
	    if (user == null) {
	        // 로그인 안 되어 있으면 401
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("UNAUTHORIZED");
	    }

//	    System.out.println("===== VOTE DEBUG =====");
//	    System.out.println("user: " + user.getId());
//	    System.out.println("proposalId: " + proposalId);
//	    System.out.println("voteType: " + voteType);
//	    System.out.println("=======================");

	    if (!"LIKE".equalsIgnoreCase(voteType) && !"DISLIKE".equalsIgnoreCase(voteType)) {
	        return ResponseEntity.badRequest().body("잘못된 투표 타입입니다.");
	    }

	    ProposalVoteVO existingVote = mapper.checkVote(proposalId, user.getId());
	    if (existingVote != null) {
	        // 이미 투표했으면 403 + 명확한 키워드
	        return ResponseEntity.status(HttpStatus.FORBIDDEN).body("ALREADY_VOTED");
	    }

	    ProposalVoteVO newVote = new ProposalVoteVO(proposalId, user.getId(), voteType);
	    int result = mapper.insertVote(newVote);
	    if (result == 0) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("투표 저장 실패");
	    }

	    if ("LIKE".equalsIgnoreCase(voteType)) {
	        mapper.incrementAgree(proposalId);
	    } else {
	        mapper.incrementDisagree(proposalId);
	    }

	    return ResponseEntity.ok("투표 완료");
	}


	// 토론방 목록 띄우기 메서드(discuss_list)
	@RequestMapping("/discuss_list")
	public String discuss_list() {
		return "discuss_list";
	}

	// 토론방 생성하기 메서드(discuss_post)
	@RequestMapping("/discuss_post")
	public String discuss_post() {
		return "discuss_post";
	}
	
	// 정책 상세페이지
	@RequestMapping("/similar_search_detail")
	public String similar_search_detail(@RequestParam("name") String name, @RequestParam("title") String title, @RequestParam("category") String category, @RequestParam("similar") String similarity, @RequestParam("date") String date, @RequestParam("summary") String summary, Model model) {
		model.addAttribute("name", name);
        model.addAttribute("title", title);
        model.addAttribute("category", category);
        model.addAttribute("similar", similarity);
        model.addAttribute("date", date);
        model.addAttribute("summary", summary);
        
		return "similar_search_detail";
	}
	// 클래스 맨 위에
	private static final int PAGE_SIZE = 6;

	// /proposal_list 핸들러 전체 교체
	@GetMapping("/proposal_list")
	public String showProposalList(
	    @RequestParam(value = "category", required = false, defaultValue = "전체") String category,
	    Model model) {

	    // 탭
	    List<String> categories = Arrays.asList("전체", "학교생활", "지역사회", "문화생활", "사회문제");
	    model.addAttribute("categories", categories);
	    model.addAttribute("selectedCategory", category);

	    // 전체 건수 & 첫 페이지(0~5) 데이터
	    int totalCount;
	    List<ProposalVO> proposals;
	    if ("전체".equals(category)) {
	        totalCount = mapper.countAllProposals();
	        proposals = mapper.selectProposalsPage(0, PAGE_SIZE);
	    } else {
	        totalCount = mapper.countProposalsByCategory(category);
	        proposals = mapper.selectProposalsByCategoryPage(category, 0, PAGE_SIZE);
	    }
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("pageSize", PAGE_SIZE);
	    model.addAttribute("proposals", proposals);

	    return "proposal_list";
	}

	// AJAX용 loadMore 핸들러
	@GetMapping("/proposal_list/loadMore")
	@ResponseBody
	public ResponseEntity<List<ProposalVO>> loadMore(
	    @RequestParam("category") String category,
	    @RequestParam("offset")   int offset) {

	    List<ProposalVO> more;
	    if ("전체".equals(category)) {
	        more = mapper.selectProposalsPage(offset, PAGE_SIZE);
	    } else {
	        more = mapper.selectProposalsByCategoryPage(category, offset, PAGE_SIZE);
	    }
	    return new ResponseEntity<>(more, HttpStatus.OK);
	}

}
