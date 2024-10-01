<%@page import="io.jsonwebtoken.Claims"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="<%=request.getContextPath() %>/style/mycss.css" rel="stylesheet"/>
<title>lottery</title>
</head>
<body>
<% 
    // 從 request 中取得 Claims
    String jwtToken =  (String)session.getAttribute("token");
%>
<nav class="navbar navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand">Lottery</a>
    <!-- 將首頁按鈕放在左側 -->
    <form class="d-flex" action="<%=request.getContextPath()%>/index.jsp" style="margin-right: 10px;">
      <button class="btn btn-outline-success" type="submit">HOME</button>
    </form>
    <!-- 其他按鈕放在右側 -->
    <div class="ms-auto d-flex">
      <% if (jwtToken == null) { %>
        <!-- 未登入狀態，顯示登入和註冊按鈕 -->
        <form class="d-flex" action="<%=request.getContextPath()%>/login" style="margin-right: 10px;">
          <button class="btn btn-outline-success" type="submit">LOGIN</button>
        </form>
        <form class="d-flex" action="<%=request.getContextPath()%>/register">
          <button class="btn btn-outline-primary" type="submit">REGISTER</button>
        </form>
      <% } else { %>
        <!-- 已登入狀態，顯示登出按鈕 -->
        <form class="d-flex" action="<%=request.getContextPath()%>/logout">
          <button class="btn btn-outline-danger" type="submit">logout</button>
        </form>
      <% } %>
    </div>
  </div>
</nav>

<%String errors = (String)request.getAttribute("errors"); %>
		<%if(errors!=null && !errors.isEmpty()){ %>
			<h3 class="error"><%=errors %></h3>
		<%} %>
	<h1>Lottery</h1>
	<table class="myTable"  style=" width: 500px; height: 200px;">
		<tbody>
			<form action="lotteryController.do" method="post">
			<%if(jwtToken != null) {%>
			<input type="hidden" id="jwtToken" name="jwtToken" value="<%= jwtToken %>">
			<%}%>
				<tr>
					<td>產生號碼組數 <br/>(介於1~100)</td>
					<td><input type="number" name="sets" size="20" min="1" max="100" ></td>
				</tr>
				<tr>
					<td>排除數字<br/>(請以 空白建分隔數字) </td>
					<td><input type="text" name="excludeNumbersString" size="30" ></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="送號"  class="btn btn-outline-primary"> 
						<input type="reset" value="重製"  class="btn btn-outline-primary">
					</td>
				</tr>

			</form>
		</tbody>	
	</table>
</body>
</html>