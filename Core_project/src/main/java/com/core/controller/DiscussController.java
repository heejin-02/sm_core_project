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

    /**
     * 1) 토론 목록 페이지 (discuss_list.jsp)
     *    URL: /discuss_list
     */
    @GetMapping("/discuss_list")
    public String showDiscussList(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

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

    /**
     * 2) 토론방 생성 폼 (discuss_post.jsp)
     *    URL: /discuss_post
     *    로그인된 사용자만 접근 가능
     */
    @GetMapping("/discuss_post")
    public String showCreateForm(HttpSession session, Model model) {
        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            // 로그인 안 된 상태면 /login 으로 보내기
            return "redirect:/login";
        }
        model.addAttribute("room", new Discuss_roomVO());
        return "discuss_post";
    }

    /**
     * 3) 토론방 생성 처리
     *    URL: POST /discuss_post
     */
    @PostMapping("/discuss_post")
    public String createRoom(
            @ModelAttribute("room") Discuss_roomVO room,
            HttpSession session) {

        UserinfoVO user = (UserinfoVO) session.getAttribute("mvo");
        if (user == null) {
            return "redirect:/login";
        }

        room.setId(user.getId());
        room.setCreate_at(Timestamp.valueOf(LocalDateTime.now()));
        room.setDroom_st("진행중");
        room.setDroom_mg(user.getId());

        mapper.insertDiscussRoom(room);
        // 생성 후 목록으로
        return "redirect:/discuss_list";
    }

    /**
     * 4) 토론방 상세 보기 (discuss_room.jsp)
     *    URL: /discuss_room?id={droom_no}
     */
    @GetMapping("/discuss_room")
    public String showRoomDetail(
            @RequestParam("id") int droomNo,
            Model model) {

        Discuss_roomVO room = mapper.selectRoomById(droomNo);
        if (room == null) {
            // 잘못된 id 이면 목록으로
            return "redirect:/discuss_list";
        }
        model.addAttribute("room", room);
        return "discuss_room";
    }

}
