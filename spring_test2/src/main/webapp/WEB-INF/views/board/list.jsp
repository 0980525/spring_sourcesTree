<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>
<div class="container-md">
	<h2>Board List Page</h2><br>
	<!-- search line -->
	<div class="col-sm-12 col-md-6">
		<form action="/board/list" method="get">
			<div class="input-group mb-3">
				<c:set value="${ph.pgvo.type }" var="typed"></c:set>
				<select class="form-select" name="type" id="inputGroupSelect01">
					<option ${typed eq null ? 'selected' : '' }>선택</option>
					<option value="t" ${typed eq 't' ? 'selected' : '' }>Title</option>
					<option value="w" ${typed eq 'w' ? 'selected' : '' }>Writer</option>
					<option value="c" ${typed eq 'c' ? 'selected' : '' }>Content</option>
					<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>Title & Writer</option>
					<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>Title & Content</option>
					<option value="wc" ${typed eq 'wc' ? 'selected' : '' }>Writer & Content</option>
					<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>All</option>
				</select> 
				<input type="hidden" name="pageNo" value="1">
				<input type="hidden" name="qty" value="${ph.pgvo.qty }">
				<input type="search" class="form-control me-2" name="keyword" value="${ph.pgvo.keyword }" placeholder="Search...">
				<button class="btn btn-outline-success" type="submit"> Search 
					<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
						${ph.totalCount }
						<span class="visually-hidden">unread messages</span>
					</span>
				</button>
			</div>
		</form>
	</div>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">title</th>
				<th scope="col">writer</th>
				<th scope="col">read Count</th>
				<th scope="col">comment_qty</th>
				<th scope="col">file_qty</th>
				<th scope="col">Mod At</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="bvo">
				<tr>
					<th scope="row">${bvo.bno}</th>
					<td><a href="/board/detail?bno=${bvo.bno}">${bvo.title}</a></td>
					<td>${bvo.writer}</td>
					<td>${bvo.readCount}</td>
					<td>${bvo.cmtQty}</td>
					<td>${bvo.hasFile}</td>
					<td>${bvo.modAt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 라인  -->
	<nav aria-label="Page navigation example">
		<ul class="pagination">
			<li class="page-item ${(ph.prev eq false) ? 'disabled' : '' }">
				<a class="page-link"
				href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${py.pgvo.keyword}"
				aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
			</li>
			<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
				<li class="page-item">
					<a class="page-link" 
					href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${py.pgvo.keyword}">${i}</a>
				</li>
			</c:forEach>
			<li class="page-item ${(ph.next eq false) ? 'disabled' : '' }">
				<a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${py.pgvo.keyword}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
			</li>
		</ul>
	</nav>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>