package kr.or.ahyun.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoimpl implements IBaordDao{

	@Inject
	public SqlSession session;

	@Override
	public List<Map<String, String>> boardInfoList() throws Exception {
		return session.selectList("board.boardInfoList");
	}

	@Override
	public List<Map<String, String>> departListInfo() throws Exception {
		return session.selectList("board.departListInfo");
	}

	@Override
	public int BoardInsertInfo(Map<String, Object> param) throws Exception {
		return session.insert("board.BoardInsertInfo", param);
	}

	@Override
	public int FileInsertInfo(Map<String, Object> param) throws Exception {
		return session.insert("board.FileInsertInfo",param);
	}

	@Override
	public Map<String, String> boardDetailInfo(String board_id) throws Exception {
		return session.selectOne("board.boardDetailInfo",board_id);
	}
}
