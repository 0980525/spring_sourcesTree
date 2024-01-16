<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>
<h2>Board Modify Page</h2><br>
<form action="/board/modify" method="post" enctype="multipart/form-data">
	<div class="container-md">
	<c:set value="${bdto.bvo }" var="bvo"></c:set>	
		<div class="mb-3">
			<label for="bno" class="form-label">No.</label>
			<input type="text" name="bno" class="form-control" id="bno" readonly value="${bvo.bno }">
		</div>
		<div class="mb-3">
			<label for="title" class="form-label">제목</label> 
			<input type="text" name="title" class="form-control" id="title" value="${bvo.title }">
		</div>
		<div class="mb-3">
			<label for="writer" class="form-label">작성자</label> 
			<input type="text" name="writer" class="form-control" id="writer" readonly value="${bvo.writer }">
		</div>
		<div class="mb-3">
			<label for="reg_date" class="form-label">작성일</label> 
			<span class="badge text-bg-primary">${bvo.readCount }</span> 
			<input type="text" name="reg_date" class="form-control" id="reg_date" readonly value="${bvo.regAt }">
		</div>
		<div class="mb-3">
			<label for="mod_date" class="form-label">수정일</label> 
			<input type="text" name="mod_date" class="form-control" id="mod_date" readonly value="${bvo.modAt }">
		</div>
		<div class="mb-3">
			<label for="content" class="form-label">내용</label> 
			<input type="text" name="content" class="form-control" id="content" value="${bvo.content }">
		</div>
		
		<!-- file line -->
	<c:set value="${bdto.flist }" var="flist"></c:set>
		<div class="col-12">
			<label for="f" class="form-label"></label>
			<ul class="list-group list-group-flush">
				<c:forEach items="${flist }" var="fvo">
					<li class="list-group-item">
						<c:choose>
							<c:when test="${fvo.fileType == 1 }">
								<div>
									<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<!-- 일반 파일을 표시할 아이콘 -->
									<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-file-earmark-arrow-down" viewBox="0 0 16 16">
  <path d="M8.5 6.5a.5.5 0 0 0-1 0v3.793L6.354 9.146a.5.5 0 1 0-.708.708l2 2a.5.5 0 0 0 .708 0l2-2a.5.5 0 0 0-.708-.708L8.5 10.293V6.5z"/>
  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2zM9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5v2z"/>
</svg>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="ms-2 me-auto">
							<div class="fw-bold">
								${fvo.fileName}<br>
								<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
								<button type=button data-uuid="${fvo.uuid }" class="btn btn-outline-danger btn-sm file-x">X</button>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<!-- 파일 등록 라인 -->
		<!-- file 입력 라인 추가 -->
 		<div class="mb-3">
			<label for="file" class="form-label">fileUpload</label> 
			<input type="file" name="files" class="form-control" id="files" multiple="multiple" style="display: none"><br>
			<!-- 파일 버튼 트리거 사용하기 위해서 주는 버튼 -->
			<button type="button" class="btn btn-primary" id="trigger">File Upload</button>
		</div>

		<!-- 파일 목록 표시라인 -->
 		<div class="mb-3" id="fileZone">
 			
		</div>
		
		<button type="submit"  class="btn btn-success" id="regBtn">수정</button>
		<a href="/board/list"><button type="button" class="btn btn-primary">목록</button></a>
	</div>
</form>

<script src="/resources/js/boardRegister.js"></script>
<script type="text/javascript" src="/resources/js/boardModify.js"></script>

<jsp:include page="../layout/footer.jsp"></jsp:include>