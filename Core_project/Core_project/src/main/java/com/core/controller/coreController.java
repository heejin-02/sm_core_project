package com.core.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.core.mapper.CoreMapper;
import com.core.model.UserinfoVO;
import org.springframework.ui.Model;

@Controller
public class coreController {

   @Autowired
   private CoreMapper mapper;

   @RequestMapping("/similar_search")
   public String similarSearch() {
      return "similar_search";
   }

   @RequestMapping("/")
   public String home() {
      return "similar_search";
   }

   // 회원가입 메서드(join)
   // 회원가입 폼 페이지 보여주기 (GET 요청)
   @GetMapping("/join")
   public String joinForm() {
      return "join"; // join.jsp 보여줌
   }

   // 회원가입 처리 (POST 요청)
   @PostMapping("/join")
   public String join(UserinfoVO vo, 
           @RequestParam(value="id_card", required=false) MultipartFile file, 
           	Model model) {
       System.out.println("id: " + vo.getId());

       // 필수 필드 null 또는 빈값 체크
       if (vo.getId() == null || vo.getId().isEmpty() ||
           vo.getPw() == null || vo.getPw().isEmpty() ||
           vo.getNick() == null || vo.getNick().isEmpty() ||
           vo.getRegion() == null || vo.getRegion().isEmpty()) {
           System.out.println("❗ 필수 입력값 누락");
           model.addAttribute("msg", "모든 항목을 입력해주세요.");
           return "join"; 
       }

       // 파일 처리
       if (file != null && !file.isEmpty()) {
           try {
               String uploadDir = "C:/upload/";
               File dir = new File(uploadDir);
               if (!dir.exists()) dir.mkdirs();

               String filename = file.getOriginalFilename();
               file.transferTo(new File(uploadDir + filename));

               vo.setId_card(filename); // 파일명 저장
           } catch (IOException e) {
               e.printStackTrace();
               model.addAttribute("msg", "파일 업로드 실패");
               return "join";
           }
       } else {
           vo.setId_card("default.jpg");
       }
       
       // 기본값 세팅
       vo.setIs_approved("N");
       vo.setJoined_at(LocalDateTime.now());

       // DB 저장
       mapper.join(vo);

       model.addAttribute("id", vo.getId());
       return "similar_search"; // 가입 완료 후 이동할 페이지
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
         // 객체 전체 저장
         session.setAttribute("mvo", mvo);

         // 개별 속성도 따로 저장 (JSP에서 직접 접근 가능하게!)
         session.setAttribute("midx", mvo.getId());        // 로그인 여부 확인용
         session.setAttribute("nickname", mvo.getNick());  // 닉네임 출력용

         return "redirect:/"; // 홈으로 리다이렉트 (갱신을 위해 추천)
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

   // 회원탈퇴 메서드
   @RequestMapping("/delete")
   public String delete(@RequestParam("id") String id, HttpSession session) {
      int cnt = mapper.delete(id);
      if (cnt > 0) {
         session.invalidate();
      }
      return "similar_search";
   }

   // 정책 제안 올리기 메서드(proposal_post)

   // 정책 제안 목록 띄우기 메서드(proposal_list)

   // 유사도 목록 띄우기 메서드(similar_search)

   // 토론방 목록 띄우기 메서드(discuss_list)

   // 토론방 생성하기 메서드(discuss_post)

   // 토론방 안 채팅 띄우기 메서드(discuss_room)
   // (제일 나중에하기)
}