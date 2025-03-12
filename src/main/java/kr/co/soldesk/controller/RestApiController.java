package kr.co.soldesk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import kr.co.soldesk.service.MemberService;

@RestController
public class RestApiController {

   @Autowired
   private MemberService memberService;
   
   @GetMapping("/member/checkId/{id}")
   public String checkId(@PathVariable String id) {
      return memberService.checkId(id) ? "true" : "false";
   }

}
