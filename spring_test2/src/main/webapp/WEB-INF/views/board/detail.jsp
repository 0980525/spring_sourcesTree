<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>
<h2>Board Detail Page</h2><br>
<div class="container-md">
<c:set value="${bdto.bvo }" var="bvo"></c:set>	
	<div class="mb-3">
		<label for="bno" class="form-label">No.</label> 
		<input type="text" name="bno" class="form-control" id="bno" readonly value="${bvo.bno }">
	</div>
	<div class="mb-3">
		<label for="title" class="form-label">제목</label>
		<input type="text" name="title" class="form-control" id="title" readonly value="${bvo.title }">
	</div>
	<div class="mb-3">
		<label for="writer" class="form-label">작성자</label>
		<input type="text" name="writer" class="form-control" id="writer" readonly	value="${bvo.writer }">
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
		<input type="text" name="content" class="form-control" id="content" readonly value="${bvo.content }">
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
									<a href="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}" download="${fvo.fileName }">
									<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-file-earmark-arrow-down" viewBox="0 0 16 16">
  <path d="M8.5 6.5a.5.5 0 0 0-1 0v3.793L6.354 9.146a.5.5 0 1 0-.708.708l2 2a.5.5 0 0 0 .708 0l2-2a.5.5 0 0 0-.708-.708L8.5 10.293V6.5z"/>
  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2zM9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5v2z"/>
</svg>
									</a>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="ms-2 me-auto">
							<div class="fw-bold">
								${fvo.fileName}<br>
								<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	
	
	
	<a href="/board/modify?bno=${bvo.bno }"><button type="submit" class="btn btn-success">수정</button></a> 
	<a href="/board/remove?bno=${bvo.bno }"><button type="button" class="btn btn-danger">삭제</button></a> 
	<a href="/board/list"><button type="submit" class="btn btn-primary">목록</button></a><br>
	<br><hr><br>
	
	<!-- 댓글 등록 라인 -->
    <sec:authentication property="principal.mvo.email" var="authEmail"/>
	<div class="input-group mb-3">
		<span class="input-group-text" id="cmtWriter">${authEmail }</span> 
		<input type="text" class="form-control" id="cmtText" aria-label="Amount (to the nearest dollar)">
		<button type="button" class="btn btn-success" id="cmtPostBtn">Post</button>
	</div>

	<!-- 댓글 표시 라인 -->
	<ul class="list-group list-group-flush" id="cmtListArea">
		<li class="list-group-item">
			<div class="mb-3">
				<div class="fw-bold">Writer</div>
				content
			</div>
			<span class="badge rounded-pill text-bg-warning">modAt</span>
		</li>
	</ul>
	
	<!-- 댓글 더보기 버튼 -->
	<div>
		<button type="button" id="moreBtn" data-page="1" class="btn btn-outline-dark" style="visibility:hidden">More+</button>
	</div>
	
	<!-- 모달창 라인 -->
	<div class="modal" id="myModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Writer</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="cmtTextMod">
						<button type="button" class="btn btn-primary" id="cmtModBtn">Post</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

</div>



<script type="text/javascript">
	let bnoVal = `<c:out value="${bdto.bvo.bno}"/>`;
	console.log(bnoVal);
</script>
<script type="text/javascript" src="/resources/js/boardComment.js"></script>
<script type="text/javascript">
	spreadCommentList(bnoVal);
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>