<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath() %>/style/mycss.css" rel="stylesheet"></link>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>result</title>
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
      <% if (jwtToken != null) { %>
        <!-- 已登入狀態，顯示登出按鈕 -->
        <form class="d-flex" action="<%=request.getContextPath()%>/logout">
          <button class="btn btn-outline-danger" type="submit">登出</button>
        </form>
      <% } %>
    </div>
  </div>
</nav>
<h2>result List</h2>

	<table class="myTable">
		<tbody>
			<% ArrayList<Integer>[] resultList =(ArrayList<Integer>[]) request.getAttribute("resultList"); %>
			<%for(int i=0;i<resultList.length;i++){ %>
				<tr>
					<td>第<%=i+1 %>組</td>
					<%for(Integer number:resultList[i]){%>
						<td><%=" "+ number%></td>
					<%} %>
					
				</tr>
			<%} %>
		</tbody>
	</table>
</body>
</html>