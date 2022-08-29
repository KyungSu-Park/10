<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
    
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>

	<title>주문 완료</title>

</head>

<body>

	<form>
		구매 완료
	<c:set var="i" value="0"></c:set>
	
	<c:forEach var="list" items="${list}">
	
		<table border=1>
			<tr>
				<td>물품 번호</td>
				<td>${list.purchaseProd.prodNo}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자 아이디</td>
				<td>${list.buyer.userId}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자 이름</td>
				<td>${list.receiverName}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자 연락처</td>
				<td>${list.receiverPhone}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자 주소</td>
				<td>${list.divyAddr}</td>
				<td></td>
			</tr>
				<tr>
				<td>구매 요청 사항</td>
				<td>${list.divyRequest}</td>
				<td></td>
			</tr>
			<tr>
				<td>배송 희망 일자</td>
				<td>${list.divyDate}</td>
				<td></td>
			</tr>
		</table>
		
		</c:forEach>
		
	</form>

</body>

</html>