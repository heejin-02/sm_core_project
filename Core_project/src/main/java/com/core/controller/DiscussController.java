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
import com.core.model.Discuss_roomVO;
import com.core.model.UserinfoVO;

@Controller
public class DiscussController {

    @Autowired
    private CoreMapper mapper;

    // ✅ discuss_list 띄워주는거
    @GetMapping("/discuss_list")
    public String showDiscussList(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Discuss_roomVO> rooms;
        if (keyword != null && !keyword.trim().isEmpty()) {
            rooms = mapper.searchRoomsByTitle(keyword);
        } else {
            rooms = mapper.selectAllRooms();
        }
        model.addAttribute("rooms", rooms);
        model.addAttribute("keyword", keyword);
        return "discuss_list";  
    }

    @GetMapping("/discuss_post")
    public String showCreateForm(Model model) {
        model.addAttribute("room", new Discuss_roomVO());
        return "discuss_post";  
    }

    @PostMapping("/discuss_post")
    public String createRoom(@ModelAttribute("room") Discuss_roomVO room, HttpSession session) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) return "redirect:/login";

        room.setId(user.getId());
        room.setCreate_at(Timestamp.valueOf(LocalDateTime.now()));
        room.setDroom_st("진행중");
        room.setDroom_mg(user.getId());

        mapper.insertDiscussRoom(room);
        return "redirect:/discuss_list";
    }
}
