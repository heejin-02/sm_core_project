package com.core.controller;

import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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

    // 한 페이지에 보여줄 글 개수
    private static final int PAGE_SIZE = 6;

    /** 1) 토론 목록 첫 화면 — 최초 6개만 **/
    @GetMapping("/discuss_list")
    public String showDiscussionList(
        @RequestParam(value = "category", required = false) String category,
        @RequestParam(value = "keyword",  required = false) String keyword,
        Model model
    ) {
        Map<String,Object> params = new HashMap<>();
        params.put("category", category);
        params.put("keyword",  keyword);

        // 전체 글 조회
        List<Discussion_postVO> all = mapper.searchDiscussPosts(params);
        int totalCount = all.size();

        // 처음 PAGE_SIZE 개만
        List<Discussion_postVO> page = all.size() > PAGE_SIZE
            ? all.subList(0, PAGE_SIZE)
            : all;

        // 각 글에 AI 요약 채워넣기
        page.forEach(post -> {
            Discussion_summaryVO sum = mapper.selectSummaryByDiscussionId(post.getDiscussionId());
            post.setSummary(
                sum != null && sum.getSummary() != null
                    ? sum.getSummary()
                    : "요약된 내용이 없습니다."
            );
        });

        model.addAttribute("posts", page);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", PAGE_SIZE);
        model.addAttribute("currentCategory", category);
        model.addAttribute("keyword", keyword);
        return "discuss_list";
    }

    /** 2) AJAX «더보기» — 다음 6개 **/
    @GetMapping("/discuss_list/loadMore")
    @ResponseBody
    public ResponseEntity<List<Discussion_postVO>> loadMore(
        @RequestParam("offset") int offset,
        @RequestParam(value = "category", required = false) String category,
        @RequestParam(value = "keyword",  required = false) String keyword
    ) {
        Map<String,Object> params = new HashMap<>();
        params.put("category", category);
        params.put("keyword",  keyword);

        List<Discussion_postVO> all = mapper.searchDiscussPosts(params);
        if (offset >= all.size()) {
            return ResponseEntity.ok(Collections.emptyList());
        }
        int end = Math.min(offset + PAGE_SIZE, all.size());
        List<Discussion_postVO> slice = all.subList(offset, end);
        slice.forEach(post -> {
            Discussion_summaryVO sum = mapper.selectSummaryByDiscussionId(post.getDiscussionId());
            post.setSummary(
                sum != null && sum.getSummary() != null
                    ? sum.getSummary()
                    : "요약된 내용이 없습니다."
            );
        });
        return ResponseEntity.ok(slice);
    }

    /** 3) 토론 생성 폼 — 로그인 필요 **/
    @GetMapping("/discuss_post")
    public String showCreateForm(HttpSession session, Model model) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            session.setAttribute("redirectAfterLogin", "/discuss_post");
            return "redirect:/login";
        }
        model.addAttribute("post", new Discussion_postVO());
        return "discuss_post";
    }

    /** 4) 토론 생성 처리 **/
    @PostMapping("/discuss_post")
    public String createDiscussion(
        @ModelAttribute("post") Discussion_postVO post,
        HttpSession session,
        RedirectAttributes rttr
    ) {
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

    /** 5) 토론 방 보기 **/
    @GetMapping("/discuss_room")
    public String showDiscussionRoom(
        @RequestParam("id") int discussionId,
        Model model
    ) {
        Discussion_postVO post = mapper.selectPostById(discussionId);
        if (post == null) {
            return "redirect:/discuss_list";
        }
        model.addAttribute("post", post);

        List<Discussion_commentVO> comments = mapper.selectCommentsByDiscussionId(discussionId);
        model.addAttribute("comments", comments);

        Discussion_summaryVO sum = mapper.selectSummaryByDiscussionId(discussionId);
        model.addAttribute("aiSummary",
            sum != null && sum.getSummary() != null
                ? sum.getSummary()
                : "요약된 내용이 없습니다."
        );
        return "discuss_room";
    }

    /** 6) 댓글 쓰기 **/
    @PostMapping("/discuss_room/comment")
    public String postComment(
        @RequestParam int discussionId,
        @RequestParam String opinionType,
        @RequestParam String content,
        HttpSession session
    ) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            return "redirect:/login";
        }
        Discussion_commentVO c = new Discussion_commentVO();
        c.setDiscussionId(discussionId);
        c.setUserId(user.getId());
        c.setOpinionType(opinionType);
        c.setContent(content);
        c.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));
        mapper.insertDiscussionComment(c);

        // FastAPI 요약 갱신
        try {
            URL url = new URL("http://192.168.219.72:8001/summary/update/" + discussionId);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3000);
            conn.setReadTimeout(15000);
            conn.getResponseCode();
            conn.disconnect();
        } catch (Exception e) {
            // 로그만 남깁니다
            System.out.println("요약 갱신 실패: " + e.getMessage());
        }

        return "redirect:/discuss_room?id=" + discussionId;
    }

    /** 7) 댓글 삭제 **/
    @GetMapping("/discuss_room/delete_comment")
    public String deleteComment(
        @RequestParam("id")    int commentId,
        @RequestParam("discussionId") int discussionId,
        HttpSession session,
        RedirectAttributes rttr
    ) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }
        String writerId = mapper.selectCommentWriter(commentId);
        if (!user.getId().equals(writerId)) {
            rttr.addFlashAttribute("msg", "본인의 댓글만 삭제할 수 있습니다.");
            return "redirect:/discuss_room?id=" + discussionId;
        }
        mapper.deleteComment(commentId);

        // FastAPI 요약 갱신
        try {
            URL url = new URL("http://192.168.219.72:8001/summary/update/" + discussionId);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3000);
            conn.setReadTimeout(10000);
            conn.getResponseCode();
            conn.disconnect();
        } catch (Exception e) {
            System.out.println("요약 갱신 실패: " + e.getMessage());
        }

        return "redirect:/discuss_room?id=" + discussionId;
    }
    
    // 토론방 삭제
    @PostMapping("/discuss_delete")
    public String deleteDiscussionPost(@RequestParam("id") int discussionId,
                                       HttpSession session,
                                       RedirectAttributes rttr) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");

        if (user == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        Discussion_postVO post = mapper.selectPostById(discussionId);

        if (post == null || !post.getAuthorId().equals(user.getId())) {
            rttr.addFlashAttribute("msg", "삭제 권한이 없습니다.");
            return "redirect:/discuss_list";
        }

        int result = mapper.deleteDiscussionPostById(discussionId);

        if (result > 0) {
            rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "게시글 삭제에 실패했습니다.");
        }

        return "redirect:/discuss_list";
    }

    
    



}
