package com.myWeb.www.repository;

import java.util.List;

import com.myWeb.www.domain.FileVO;

public interface FileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long bno);

	int delete(String uuid);

	List<FileVO> selectListAllFile();

}
