package com.core.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.core.mapper.CoreMapper;
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
            HttpSession session) {

        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            return "redirect:/login";
        }

        post.setAuthorId(user.getId());
        post.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));
        mapper.insertDiscussionPost(post);
        return "redirect:/discuss_list";
    }

    /** 4) 토론 상세 보기 (discuss_room.jsp) */
    @GetMapping("/discuss_room")
    public String showDiscussionDetail(
            @RequestParam("id") int discussionId,
            Model model) {

        Discussion_postVO post = mapper.selectPostById(discussionId);
        if (post == null) {
            return "redirect:/discuss_list";
        }
        model.addAttribute("post", post);
        return "discuss_room";
    }
}