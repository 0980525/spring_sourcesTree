package com.myWeb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myWeb.www.domain.BoardVO;
import com.myWeb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(long bno);

	int updateReadCnt(@Param("bno") long bno, @Param("count") int count);

	int update(BoardVO bvo);

	void delete(BoardVO bvo);

	int getTotalCount(PagingVO pgvo);

	long selectOneBno();

	void updateCommentCount();

	void updateFileCount();

}
