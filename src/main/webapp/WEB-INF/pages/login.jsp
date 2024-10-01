<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/style/mycss.css" rel="stylesheet"></link>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-light bg-light ">
  <div class="container-fluid">
    <a class="navbar-brand">Lottery</a>
    <!-- 將首頁按鈕放在左側 -->
    <form class="d-flex" action="<%=request.getContextPath()%>/index.jsp" style="margin-right: 10px;">
      <button class="btn btn-outline-success" type="submit">HOME</button>
    </form>
  </div>
</nav>
<%String errors = (String)request.getAttribute("errors"); %>
		<%if(errors!=null && !errors.isEmpty()){ %>
			<h3 class="error"><%=errors %></h3>
		<%} %>
<div class="container mt-5">
  <div class="row">
  
	<table class="myTable"  style=" width: 500px; height: 200px;">
	
		<h3>LOGIN</h3>
		<tbody>
			<form action="login" method="post">
				<tr>
					<td>ACCOUNT </td>
					<td><input type="text" name="username" placeholder="username"></td>
				</tr>
				<tr>
					<td>PASSWORD </td>
					<td><input type="password" name="password"  ></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="LOGIN" class="btn btn-outline-primary">
					</td>
				</tr>

			</form>
		</tbody>	
	</table>
	</div>
</div>	
</body>
</html>