package com.myWeb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myWeb.www.domain.CommentVO;
import com.myWeb.www.domain.PagingVO;

public interface CommentDAO {

	int insert(CommentVO cvo);

	// @Param = mapper가 여러개를 인식하기 위해서
	List<CommentVO> getList(@Param("bno")long bno, @Param("pgvo")PagingVO pgvo);

	int selectOneBnoTotolCount(long bno);

	int update(CommentVO cvo);

	int delete(long cno);

}
