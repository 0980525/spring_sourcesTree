<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>


<div class="container my-3">
	<div class="mb-3">
		<c:forEach items="${list }" var="mvo">
			<div class="col">
				<div class="card" style="width: 18rem">
					<img src="/resources/image/peng.jpg" class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title">${mvo.nickName }</h5>
						<p class="card-text">${mvo.email }</p>
						<p>
							(
							<c:forEach items="${mvo.authList }" var="authList">${authList.auth }</c:forEach>
							)
						</p>
						<a href="/member/modify?email=${mvo.email }" class="btn btn-primary">Go somewhere</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>