package com.myWeb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BoardVO {
	
	private long bno;
	private String title;
	private String writer;
	private String content;
	private String regAt;
	private String modAt;
	private int readCount;
	private int cmtQty;
	private int hasFile;
	
}
