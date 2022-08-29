<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>

	<title>구매 목록조회</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		function fncGetList(currentPage) {
			//document.getElementById("currentPage").value = currentPage;
			//document.detailForm.submit();
			
			$("#currentPage").val(currentPage);
			$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
		}
		
		$(function(){
			$(".ct_list_pop td:nth-child(1)").bind("click", function(){
				
				alert($(this).parent().find("td:eq(0)").text().trim());
				self.location = "/purchase/getPurchaseByOrder?orderNo=" + $(this).parent().find("td:eq(0)").text().trim();
			});
		});
		
	</script>
	
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${menu eq 'manage' ? '주문관리' : '구매조회'}
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">주문 번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">구매 상품</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매 수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">개당 금액</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">총 금액</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">수령인</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">배송지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">정보수정</td>
	</tr>
	<tr>
		<td colspan="23" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var = "i" value = "0"></c:set>
	<c:forEach var = "list" items = "${list}">
		<c:set var = "i" value = "${i + 1}"></c:set>
		<tr class="ct_list_pop">
			<td align="center" style="text-decoration:underline">
				<!-- 
				<a href="/purchase/getPurchase?tranNo=${list.tranNo}">${list.tranNo}</a>
				-->
				${list.orderNo}
			</td>
		
			<td></td>
			
			<td align="center">
			
			<a href="/product/getProduct?prodNo=${list.purchaseProd.prodNo}&menu=search">${list.purchaseProd.prodName}</a>
			</td>
		
			<td></td>
			
			<td align="center">
				${list.buyQuantity}
			</td>
		
			<td></td>
			
			<td align="center">
				<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${list.purchaseProd.price}"></fmt:formatNumber>
			</td>
		
			<td></td>
			
			<td align="center">
				<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${list.buyQuantity * list.purchaseProd.price}"/>
				
			</td>
		
			<td></td>
			
			<td align="center">
				<a href="/user/getUser?userId=${list.buyer.userId}">${list.buyer.userId}</a>
			</td>
			
			<td></td>
			
			<td align="center">${list.receiverName}</td>
			<td></td>
			<td align="center">${list.receiverPhone}</td>
			<td></td>
			<td align="center">${list.divyAddr}</td>
			<td></td>
			
			<td align="center">
				<c:if test="${fn:trim(user.role) eq 'user'}">
					<c:if test="${fn:trim(list.tranCode) eq '1'}">
						배송 대기
					</c:if>
					
					<c:if test="${fn:trim(list.tranCode) eq '2'}">
						배송중
					</c:if>
					
					<c:if test="${! (fn:trim(list.tranCode) eq '1') && ! (fn:trim(list.tranCode) eq '2')}">
						수령 완료
					</c:if>
				</c:if>
				
				<c:if test="${fn:trim(user.role) ne 'user'}">
					
					<c:if test ="${fn:trim(list.tranCode) == '1'}" >
						배송 대기
					<%--						
						<a href="/updateTranCodeByProd.do?prodNo=${list.purchaseProd.prodNo}&tranCode=1">배송 하기</a>
						
						--%>
					</c:if>
					
					<c:if test ="${fn:trim(list.tranCode) == '2'}" >
						배송중
					</c:if>
					
					<c:if test ="${fn:trim(list.tranCode) == '3'}" >
						판매 완료
					</c:if>
				</c:if>
				
			</td>
			
			<td></td>
			
			<td align="center">
			
				<a href="/purchase/updateTranCode?tranNo=${list.tranNo}&tranCode=${fn:trim(list.tranCode)}&menu=${menu}&currentPage=${search.currentPage}">  

					<c:if test="${(fn:trim(list.tranCode) eq '1')&& user.role eq 'admin'}">
						배송 하기
					</c:if>
					
					<c:if test="${(fn:trim(list.tranCode) eq '2') && user.role eq 'user'}">
						배송 완료
					</c:if>
				</a>
			</td>
		</tr>
	
	<tr>
		<td colspan="23" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
	</c:forEach>
			
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="currentPage" value="1"/>
			
		<jsp:include page="../common/pageNavigator.jsp"/>
		
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>