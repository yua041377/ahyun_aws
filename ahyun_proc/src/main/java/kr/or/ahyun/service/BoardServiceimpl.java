package kr.or.ahyun.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ahyun.dao.IBaordDao;

@Service
public class BoardServiceimpl implements IBoardService{

	@Inject
	public IBaordDao dao;

	@Override
	public List<Map<String, String>> boardInfoList() throws Exception {
		return dao.boardInfoList();
	}

	@Override
	public List<Map<String, String>> departListInfo() throws Exception {
		return dao.departListInfo();
	}

	@Override
	public int BoardInsertInfo(Map<String, Object> param) throws Exception {
		
		int chk = dao.BoardInsertInfo(param);
		int chk2 = 0;
		
		if(chk > 0){
			chk2 = dao.FileInsertInfo(param);
			if(chk2 > 0){
				chk = 1;
			}
		}else{
			chk = 0;
		}
		
		
		return chk;
	}

	@Override
	public Map<String, String> boardDetailInfo(String board_id) throws Exception {
		return dao.boardDetailInfo(board_id);
	}
}
