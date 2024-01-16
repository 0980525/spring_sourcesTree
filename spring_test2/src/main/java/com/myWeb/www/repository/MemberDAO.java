package com.myWeb.www.repository;

import java.util.List;

import com.myWeb.www.security.AuthVO;
import com.myWeb.www.security.MemberVO;

public interface MemberDAO {

	int insert(MemberVO mvo);

	int insertAuthInit(String email);

	MemberVO selectEmail(String username);

	List<AuthVO> selectAuths(String username);

	int updateLastLoging(String authEmail);

}
