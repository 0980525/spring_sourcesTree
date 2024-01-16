package com.myWeb.www.service;

import java.util.List;

import com.myWeb.www.domain.BoardDTO;
import com.myWeb.www.domain.BoardVO;
import com.myWeb.www.domain.FileVO;
import com.myWeb.www.domain.PagingVO;

public interface BoardService {

	int insert(BoardDTO bdto);

	List<BoardVO> getList(PagingVO pgvo);

	BoardDTO getDetail(long bno);

	int update(BoardDTO bdto);

	void remove(BoardVO bvo);

	int getTotalCount(PagingVO pgvo);

	int removeFile(String uuid);

}
