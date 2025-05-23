package com.core.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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
    		@RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        List<Discussion_postVO> posts;
        if (category != null && !category.isEmpty()) {
            posts = mapper.selectByDiscussCategory(category);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            posts = mapper.searchPostsByTitle(keyword);
        } else {
            posts = mapper.selectAllPosts();
        }

        model.addAttribute("posts", posts);
        model.addAttribute("currentCategory", category);
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

    /**
     * 4) 토론방 상세 보기 (discuss_room.jsp)
     *    - 게시글 + 댓글 목록을 한 번에 모델에 담아서 반환
     */
    @GetMapping("/discuss_room")
    public String showDiscussionRoom(
            @RequestParam("id") int discussionId,
            Model model) {

        Discussion_postVO post = mapper.selectPostById(discussionId);
        if (post == null) {
            return "redirect:/discuss_list";
        }
        model.addAttribute("post", post);

        // 댓글 목록 조회
        List<Discussion_commentVO> comments =
            mapper.selectCommentsByDiscussionId(discussionId);
        model.addAttribute("comments", comments);

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
        // CREATED_AT은 DB DEFAULT가 SYSDATE/SYSTIMESTAMP 이므로 생략 가능하지만,
        // 명시하려면 아래와 같이 설정해도 됩니다.
        c.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

        mapper.insertDiscussionComment(c);
        return "redirect:/discuss_room?id=" + discussionId;
    }
}
