package com.myWeb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Slf4j
@Setter
@Getter
public class CommentVO {

		private long cno;
		private long bno;
		private String writer;
		private String content;
		private String regAt;
		private String modAt;
}
