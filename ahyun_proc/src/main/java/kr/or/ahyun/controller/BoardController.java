package kr.or.ahyun.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.KeyGenerator;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ahyun.service.IBoardService;

@Controller
public class BoardController {
	
	@Inject
	public IBoardService service;
	
	@RequestMapping("jsonDownload")
	@ResponseBody
	public String jsonDownload() throws Exception{
		
		JSONObject resultObj = new JSONObject();
		
		String randomStr = "key"+Math.random();
		
		resultObj.put("msg","success");
		resultObj.put("key", randomStr);
		
		String result = resultObj.toString();
		
		return result;
	}
	
	@RequestMapping("/boardMain")
	public ModelAndView boardMain(ModelAndView mv) throws Exception{
		
		//게시판 전체 데이터 출력
		List<Map<String,String>> boardInfoList = service.boardInfoList();
		//부서 리스트 출력
		List<Map<String,String>> departListInfo = service.departListInfo();
		
		mv.addObject("boardInfoList", boardInfoList);
		mv.addObject("departListInfo",departListInfo);
		mv.setViewName("board");
		return mv;
	}
	

	@RequestMapping("/boardInsert")
	@ResponseBody
	public String fileUpload(@RequestParam("board_file") MultipartFile file , HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		AttachFileMapper attachFileMapper = new AttachFileMapper(file);
		Map<String,Object> fileList =  attachFileMapper.item_info;
		
		Map<String,Object> mapList = new HashMap<String, Object>();
		
		mapList.put("board_id", request.getParameter("board_id"));
		mapList.put("board_subject", request.getParameter("board_subject"));
		mapList.put("board_content", request.getParameter("board_content"));
		mapList.put("board_depart_id", request.getParameter("board_depart_id"));
		mapList.put("org_file_name", fileList.get("org_file_name"));
		mapList.put("save_file_name", fileList.get("save_file_name"));
		mapList.put("file_size", fileList.get("file_size"));
		
		int chk = service.BoardInsertInfo(mapList);
		
		return "redirect:board";
	}
	
	@ResponseBody
	@RequestMapping("/boardDetailInfo")
	public Map<String,String> boardDetailInfo(String board_id) throws Exception{
		
		Map<String,String> boardDetailInfo = service.boardDetailInfo(board_id);
		
		return boardDetailInfo;
	}
	

}
