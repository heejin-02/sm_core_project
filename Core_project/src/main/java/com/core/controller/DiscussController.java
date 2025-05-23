package com.core.controller;

import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.core.mapper.CoreMapper;
import com.core.model.Discussion_commentVO;
import com.core.model.Discussion_postVO;
import com.core.model.UserinfoVO;

@Controller
public class DiscussController {

    @Autowired
    private CoreMapper mapper;

    /** 1) 토론 목록 (discuss_list.jsp) */
    @GetMapping("/discuss_list")
    public String showDiscussionList(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        List<Discussion_postVO> posts;
        if (keyword != null && !keyword.trim().isEmpty()) {
            posts = mapper.searchPostsByTitle(keyword);
        } else {
            posts = mapper.selectAllPosts();
        }

        model.addAttribute("posts", posts);
        model.addAttribute("keyword", keyword);
        return "discuss_list";
    }

    /** 2) 토론 생성 폼 (discuss_post.jsp) — 로그인 필요 */
    @GetMapping("/discuss_post")
    public String showCreateForm(HttpSession session, Model model) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
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
    //게시글 리스트 + ai 요약
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

        // 3. FastAPI를 통한 GPT 요약 요청
        try {
            String apiUrl = "http://192.168.219.72:8001/summary/" + discussionId;

            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(0,
                new org.springframework.http.converter.StringHttpMessageConverter(java.nio.charset.StandardCharsets.UTF_8));

            String result = restTemplate.getForObject(apiUrl, String.class);
            System.out.println("🔥 FastAPI 응답 내용:\n" + result);

            // JSON에서 요약만 추출
            String summary = result.replaceAll("^.*\"overall_summary\"\\s*:\\s*\"|\"\\s*\\}\\s*$", "");
            model.addAttribute("aiSummary", summary);
        } catch (Exception e) {
            System.out.println("❌ FastAPI 요청 중 에러 발생:");
            e.printStackTrace();
            model.addAttribute("aiSummary", "요약 실패: " + e.getMessage());
        }

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

        Discussion_commentVO c = new Discussion_commentVO();
        c.setDiscussionId(discussionId);
        c.setUserId(user.getId());
        c.setOpinionType(opinionType);       // "T" or "F"
        c.setContent(content);
        c.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

        mapper.insertDiscussionComment(c);
        return "redirect:/discuss_room?id=" + discussionId;
    }
    

}
