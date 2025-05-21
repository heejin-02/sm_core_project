package com.core.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.core.mapper.CoreMapper;
import com.core.model.Discuss_roomVO;
import com.core.model.UserinfoVO;

@Controller
@RequestMapping("/discuss")
public class DiscussController {

    @Autowired
    private CoreMapper discussMapper;

    // 토론 목록 페이지
    @GetMapping("/list")
    public String showDiscussList(Model model) {
        List<Discuss_roomVO> allRooms = discussMapper.selectAllRooms();
        model.addAttribute("rooms", allRooms);
        return "discuss_list"; // discuss_list.jsp
    }

    // 토론방 생성 폼
    @GetMapping("/post")
    public String showCreateForm(Model model) {
        model.addAttribute("room", new Discuss_roomVO());
        return "discuss_post"; // discuss_post.jsp
    }

    // 토론방 생성 처리
    @PostMapping("/post")
    public String createRoom(@ModelAttribute("room") Discuss_roomVO room, HttpSession session) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) return "redirect:/login";

        room.setId(user.getId());
        room.setCreate_at(LocalDateTime.now());
        room.setDroom_st("진행중");
        room.setDroom_mg(user.getId());

        discussMapper.insertDiscussRoom(room);
        return "redirect:/discuss/list";
    }
}
