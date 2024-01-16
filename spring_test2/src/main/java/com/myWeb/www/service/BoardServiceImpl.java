package com.myWeb.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myWeb.www.domain.BoardDTO;
import com.myWeb.www.domain.BoardVO;
import com.myWeb.www.domain.FileVO;
import com.myWeb.www.domain.PagingVO;
import com.myWeb.www.repository.BoardDAO;
import com.myWeb.www.repository.CommentDAO;
import com.myWeb.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImpl implements BoardService{

	private final BoardDAO bdao;
	private final FileDAO fdao;
	private final CommentDAO cdao;

	@Transactional
	@Override
	public int insert(BoardDTO bdto) {
		log.info("insert servbice in");
		// bvo boardMapper / flist fileMapper 등록
		int isOk = bdao.insert(bdto.getBvo());
		
		if(bdto.getFlist() == null) {
			return isOk;
		}
		
		// bvo insert 후 파일도 있다면...
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			// bno setting
			long bno = bdao.selectOneBno();	// 가장 마지막에 등록된 bno
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isOk += fdao.insertFile(fvo);
			}
		}
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		bdao.updateCommentCount();
		bdao.updateFileCount();
		return bdao.getList(pgvo);
	}

	@Transactional
	@Override
	public BoardDTO getDetail(long bno) {
		// readCount
		bdao.updateReadCnt(bno, 1);
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO>flist = fdao.getFileList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}

	@Transactional
	@Override
	public int update(BoardDTO bdto) {
		int isOk = bdao.updateReadCnt(bdto.getBvo().getBno(), -2);
		
		if(bdto.getFlist() == null) {
			return isOk;
		}
		
		// bvo insert 후 파일도 있다면...
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bdto.getBvo().getBno());
				isOk += fdao.insertFile(fvo);
			}
		}
		return isOk;
		
	}

	@Override
	public void remove(BoardVO bvo) {
		// TODO Auto-generated method stub
		bdao.delete(bvo);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pgvo);
	}

	@Override
	public int removeFile(String uuid) {
		// TODO Auto-generated method stub
		return fdao.delete(uuid);
	}

}
