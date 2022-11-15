package kr.or.ahyun.dao;

import java.util.List;
import java.util.Map;

public interface IBaordDao {
	
	public List<Map<String,String>> boardInfoList() throws Exception;
	public List<Map<String,String>> departListInfo() throws Exception;
	public int BoardInsertInfo(Map<String, Object> param) throws Exception;
	public int FileInsertInfo(Map<String, Object> param) throws Exception;
	public Map<String,String> boardDetailInfo(String board_id) throws Exception;

}
