<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>

<div class="container my-3">
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.mvo.email" var="authEmail"/>
       	<sec:authentication property="principal.mvo.pwd" var="authPwd"/>
       	<sec:authentication property="principal.mvo.nickName" var="authNick"/>
		<form action="/member/modify" method="post">
			<div class="mb-3">
				<label for="e" class="form-label">email</label> 
				<input type="email" name="email" class="form-control" id="e" value="${authEmail }" readonly>
			</div>
			<div class="mb-3">
				<label for="p" class="form-label">password</label> 
				<input type="password" name="pwd" class="form-control" id="p" value="${authPwd }">
			</div>
			<div class="mb-3">
				<label for="n" class="form-label">nick_name</label> 
				<input type="text" name="nickName" class="form-control" id="n" value="${authNick }">
			</div>

			<!-- 해당 멤버의 권한을 출력 (2개일 수도 있음) -->
			<button type="submit" class="btn btn-success" id="modBtn">회원정보수정</button>
			<a href="/member/remove?email=${authEmail}"><button type="button" class="btn btn-danger">계정삭제</button></a>
		</form>
	</sec:authorize>
</div>
<script type="text/javascript">
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>