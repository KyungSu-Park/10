<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<title>??ǰ ????</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	function fncGetList(currentPage){
		//document.getElementById("currentPage").value = currentPage;
		//document.getElementById("order").value = order;
		//document.detailForm.submit();
		
		$("#currentPage").val(currentPage);
		
		$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
	}
	
	function fncGetListPrice() {
		//document.detailForm.submit();
		
		$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
	}
	
	$(function(){
		
		$("#mainSearch").bind("click", function(){
			fncGetList(1);
		});
		
		$($("input:button")[3]).bind("click", function(){
			fncGetListPrice();
		});
		
		$(".ct_list_pop td:nth-child(3)").css("color", "red");
		
		$(".ct_list_pop td:nth-child(3)").bind("click", function(){
			
			var thisRow = $(this).parent().find("td:eq(0)").text();
			
			alert(thisRow);
			self.location = "/product/getProduct?prodNo=" + $(this).parent().find("td:eq(0)").text() + "&menu=${menu}";
			
		});
		
		$("#low_price").bind("click", function(){
			
			$("#low_price").text(2);
			$("#order").val(2);
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
		});
		
		$("#high_price").bind("click", function(){
			
			$("#high_price").text(1);
			$("#order").val(1);
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
		});
		
	});
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form>

	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37">
				<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
			</td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">
							${menu.equals("manage") ? "??ǰ????" : "??ǰ ???? ??ȸ"}
						</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			
			<td align="right">
				<select name="searchCondition" class="ct_input_g" style="width:80px">
					<c:if test="${fn:trim(user.role) eq 'admin'}">
						<option value="0"  ${ (searchCondition == '0' ? "selected" : "") }>??ǰ??ȣ</option>
						<option value="1"  ${ (searchCondition == '1' ? "selected" : "") }>??ǰ??</option>
						
					</c:if>
				
					<c:if test="${(fn:trim(user.role) eq 'user') || empty user}">
						<option value="1"  ${ (searchCondition == '1' ? "selected" : "") }>??ǰ??</option>
					</c:if>				
				</select>
				
				<input type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ""}" 
												class="ct_input_g" style="width:200px; height:19px" />
			</td>
		
			<td align="right" width="70">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="17" height="23" class="ct_btn01">
							<input type="button" id="mainSearch" value="?˻?" >
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td colspan="11" >??ü ${ resultPage.totalCount } ?Ǽ?, ???? ${ resultPage.currentPage } ??????&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="low_price" value="???? ???ݼ?" >
				<input type="button" id="high_price" value="???? ???ݼ?">&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span><input type="text" name="minPrice" class="param-pricerange" maxlength="10" value="${search.minPrice != -1 ? search.minPrice : ""}"
						class="ct_input_g" style="width:100px; height:19px" > ~</span>
			    <span><input type="text" name="maxPrice" class="param-pricerange" maxlength="10" value="${search.maxPrice != -1? search.maxPrice : ""}"
			    				class="ct_input_g" style="width:100px; height:19px" > ??</span>
			
			    <input type="button" value="?˻?">
	    
			</td>
		</tr>
		<tr>
			<td class="ct_list_b" width="100">No</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">??ǰ??</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">????</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="300">????</td>	
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="100">????????</td>
			<td class="ct_line02"></td>
			
			<c:if test="${!empty user && fn:trim(user.role) == 'admin' && menu == 'manage'}">
				<td class="ct_list_b" width="100">????????</td>
			</c:if>
		</tr>
		<tr>
			<td colspan="11" bgcolor="808285" height="1"></td>
		</tr>
		
		<c:set var = "i" value = "0" />
		<c:forEach var = "list" items = "${list}">
			<c:set var = "i" value = "${i + 1}" />
			<tr class="ct_list_pop">
				<td align="center">${list.prodNo}</td>
				<td></td>
				<td align="left" style="text-decoration:underline">
					${list.prodName}
				</td>
				<td></td>
				
				<td align="left"><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" /></td>
				
				<td></td>
				<td align="left">${list.prodDetail}</td>
				<td></td>
				
				<td align="center">
					<c:if test ="${fn:trim(list.prodQuantity) ne '0'}" >
						?Ǹ???
					</c:if>
		
					<c:if test ="${fn:trim(list.prodQuantity) eq '0'}" >
						????????
					</c:if>
				</td>	
					
				<td></td>
			
			<c:if test="${!empty user && fn:trim(user.role) == 'admin' && menu == 'manage'}">
				<td align="center">${list.prodQuantity}</td>
			</c:if>	
						
			</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
		</c:forEach>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value="1"/>
			<input type="hidden" id="order" name="order" value="0"/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
	    	</td>
		</tr>
	</table>

</form>
</div>

</body>
</html>
