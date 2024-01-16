package com.myWeb.www.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myWeb.www.domain.BoardDTO;
import com.myWeb.www.domain.BoardVO;
import com.myWeb.www.domain.FileVO;
import com.myWeb.www.domain.PagingVO;
import com.myWeb.www.handler.FileHandler;
import com.myWeb.www.handler.PagingHandler;
import com.myWeb.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// @RequiredArgsConstructor 선언 후, private final로 객체 등록 => 생성자 주입


@Slf4j
@RequestMapping("/board/*")
@RequiredArgsConstructor
@Controller
public class BoardController {

	private final BoardService bsv;
	private final FileHandler fh;

	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String insert(BoardVO bvo, @RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>> bvo >>> {}", bvo);
		List<FileVO> flist = null;
		
		// fileHandler 생성 multipartfile -> flist 
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		int isOk = bsv.insert(new BoardDTO(bvo, flist));
		return "index";
	}
	
	@GetMapping("/list")
	public void list(Model m, PagingVO pgvo) {
		log.info(">>> pagingVO >>> {}", pgvo);
		// 페이징 처리
		List<BoardVO> list = bsv.getList(pgvo);
		// totalCount 구하기
		int totalCount =  bsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(Model m, @RequestParam("bno") long bno) {
		m.addAttribute("bdto", bsv.getDetail(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, RedirectAttributes re, 
			@RequestParam(name="files", required = false)MultipartFile[] files) {
		List<FileVO> flist = null;
		
		// fileHandler 생성 multipartfile -> flist 
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		int isOk = bsv.update(new BoardDTO(bvo, flist));
		re.addFlashAttribute("bno", bvo.getBno());
		return "redirect:/board/detail?bno=" +bvo.getBno();
	}
	
	@GetMapping("/remove")
	public String remove (BoardVO bvo) {
		bsv.remove(bvo);
		return "redirect:/board/list";
	}
	
	@DeleteMapping(value="/file/{uuid}", produces= MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid") String uuid) {
		log.info(">>> uuid {}", uuid);
		int isOk = bsv.removeFile(uuid);
		return isOk > 0 ?
				new ResponseEntity<String>("1", HttpStatus.OK) :
					new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
