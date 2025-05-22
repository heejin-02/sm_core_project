package com.core.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.core.service.discussService;

@Controller
@RequestMapping("/discuss")
public class discussController {

	    @Resource
	    private discussService discussService;

	    // 게시글 목록
	    @RequestMapping("/list")
	    public String list(@RequestParam Map<String, Object> paramMap, Model model) {
	        model.addAttribute("postList", discussService.getPostList(paramMap));
	        return "discussList";
	    }

	    // 게시글 상세
	    @RequestMapping("/view")
	    public String view(@RequestParam Map<String, Object> paramMap, Model model) {
	        model.addAttribute("post", discussService.getPost(paramMap));
	        model.addAttribute("commentList", discussService.getCommentList(paramMap));
	        return "discussView";
	    }

	    // 게시글 등록 폼
	    @RequestMapping("/write")
	    public String write() {
	        return "discussWrite";
	    }

	    // 게시글 저장 (AJAX)
	    @RequestMapping(value = "/save", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> save(@RequestParam Map<String, Object> paramMap) {
	        Map<String, Object> result = new HashMap<>();
	        int r = discussService.createPost(paramMap);
	        result.put("code", r > 0 ? "OK" : "FAIL");
	        return result;
	    }

	    // 댓글 저장 (AJAX)
	    @RequestMapping(value = "/comment/save", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> saveComment(@RequestParam Map<String, Object> paramMap) {
	        Map<String, Object> result = new HashMap<>();
	        int r = discussService.addComment(paramMap);
	        result.put("code", r > 0 ? "OK" : "FAIL");
	        return result;
	    }
	}
