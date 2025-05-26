package com.core.controller;

import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.core.mapper.CoreMapper;
import com.core.model.Discussion_commentVO;
import com.core.model.Discussion_postVO;
import com.core.model.Discussion_summaryVO;
import com.core.model.UserinfoVO;

@Controller
public class DiscussController {

    @Autowired
    private CoreMapper mapper;

    /** 1) 토론 목록 (discuss_list.jsp) */
    @GetMapping("/discuss_list")
    public String showDiscussionList(
        @RequestParam(value = "category", required = false) String category,
        @RequestParam(value = "keyword", required = false) String keyword,
        Model model) {

        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("keyword", keyword);

        List<Discussion_postVO> posts = mapper.searchDiscussPosts(params);
        model.addAttribute("posts", posts);
        model.addAttribute("currentCategory", category);
        model.addAttribute("keyword", keyword);
        
        // ✅ 각 게시글에 AI 요약 붙이기
        for (Discussion_postVO post : posts) {
            Discussion_summaryVO summaryVO = mapper.selectSummaryByDiscussionId(post.getDiscussionId());
            if (summaryVO != null && summaryVO.getSummary() != null) {
                post.setSummary(summaryVO.getSummary());
            } else {
                post.setSummary("요약된 내용이 없습니다.");
            }
        }

        return "discuss_list";
    }

    /** 2) 토론 생성 폼 (discuss_post.jsp) — 로그인 필요 */
    @GetMapping("/discuss_post")
    public String showCreateForm(HttpSession session, Model model) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            // 로그인 페이지로 보낼 때 원래 요청을 저장
            String original = "/discuss_post";
            session.setAttribute("redirectAfterLogin", original);
            return "redirect:/login";
        }
        model.addAttribute("post", new Discussion_postVO());
        return "discuss_post";
    }

    /** 3) 토론 생성 처리 */
    @PostMapping("/discuss_post")
    public String createDiscussion(
            @ModelAttribute("post") Discussion_postVO post,
            HttpSession session,
            RedirectAttributes rttr) {

        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            return "redirect:/login";
        }

        post.setAuthorId(user.getId());
        post.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));
        mapper.insertDiscussionPost(post);

        rttr.addFlashAttribute("msg", "게시글이 성공적으로 등록되었습니다.");
        return "redirect:/discuss_list";
    }
    @GetMapping("/discuss_room")
    public String showDiscussionRoom(
            @RequestParam("id") int discussionId,
            Model model) {

        // 1. 게시글 조회
        Discussion_postVO post = mapper.selectPostById(discussionId);
        if (post == null) {
            return "redirect:/discuss_list";
        }
        model.addAttribute("post", post);

        // 2. 댓글 목록 조회
        List<Discussion_commentVO> comments =
            mapper.selectCommentsByDiscussionId(discussionId);
        model.addAttribute("comments", comments);

        // ✅ 3. AI 요약 조회 (VO 사용)
        Discussion_summaryVO summaryVO = mapper.selectSummaryByDiscussionId(discussionId);
        String summary = (summaryVO != null && summaryVO.getSummary() != null)
            ? summaryVO.getSummary()
            : "요약된 내용이 없습니다.";
        model.addAttribute("aiSummary", summary);

        // 4. 최종 JSP로 이동
        return "discuss_room";
    }

    /** 5) 댓글 쓰기 */
    @PostMapping("/discuss_room/comment")
    public String postComment(
            @RequestParam int discussionId,
            @RequestParam String opinionType,
            @RequestParam String content,
            HttpSession session) {

        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            return "redirect:/login";
        }

        // 1. 댓글 객체 생성 및 저장
        Discussion_commentVO c = new Discussion_commentVO();
        c.setDiscussionId(discussionId);
        c.setUserId(user.getId());
        c.setOpinionType(opinionType);       // "T" or "F"
        c.setContent(content);
        c.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

        mapper.insertDiscussionComment(c); // DB에 댓글 저장

        // 2. FastAPI에 요약 갱신 요청
        try {
            String url = "http://localhost:8001/summary/update/" + discussionId;
            java.net.URL requestUrl = new java.net.URL(url);
            java.net.HttpURLConnection conn = (java.net.HttpURLConnection) requestUrl.openConnection();

            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3000);  // 3초 timeout
            conn.setReadTimeout(15000);

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                System.out.println("✅ FastAPI 요약 갱신 성공");
            } else {
                System.out.println("⚠️ FastAPI 응답 코드: " + responseCode);
            }

            conn.disconnect();
        } catch (Exception e) {
            System.out.println("❌ FastAPI 요약 요청 실패: " + e.getMessage());
        }

        // 3. 글 상세 페이지로 리디렉션
        return "redirect:/discuss_room?id=" + discussionId;
    }


 // 찬/반 댓글 삭제
    @GetMapping("/discuss_room/delete_comment")
    public String deleteComment(@RequestParam("id") int commentId,
                                @RequestParam("discussionId") int discussionId,
                                HttpSession session,
                                RedirectAttributes rttr) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");

        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        // 본인 댓글인지 확인
        String writerId = mapper.selectCommentWriter(commentId);
        if (!user.getId().equals(writerId)) {
            rttr.addFlashAttribute("msg", "본인의 댓글만 삭제할 수 있습니다.");
            return "redirect:/discuss_room?id=" + discussionId;
        }

        // ✅ 댓글 삭제
        mapper.deleteComment(commentId);

        // ✅ FastAPI에 요약 갱신 요청
        try {
            String url = "http://localhost:8001/summary/update/" + discussionId;
            URL requestUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) requestUrl.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3000);
            conn.setReadTimeout(10000);
            conn.getResponseCode();
            conn.disconnect();
        } catch (Exception e) {
            System.out.println("❌ 요약 갱신 실패 (댓글 삭제 후): " + e.getMessage());
        }

        return "redirect:/discuss_room?id=" + discussionId;
    }




}
