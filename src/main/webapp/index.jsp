<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath() %>/style/mycss.css" rel="stylesheet"></link>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
    <div class="d-flex">
   		<%if(jwtToken==null){ %>

        <!-- 未登入狀態，顯示登入和註冊按鈕 -->
        <form class="d-flex" action="<%=request.getContextPath()%>/login" style="margin-right: 10px;">
          <button class="btn btn-outline-success" type="submit">LOGIN</button>
        </form>
        <form class="d-flex" action="<%=request.getContextPath()%>/register">
          <button class="btn btn-outline-primary" type="submit">REGISTER</button>
        </form>
 		<%}else{ %>
        <!-- 已登入狀態，顯示登出按鈕 -->
        <form class="d-flex" action="<%=request.getContextPath()%>/logout">
          <button class="btn btn-outline-danger" type="submit">LOGOUT</button>
        </form>
      	<%} %>
    </div>
  </div>
</nav>

<div class="container">
  <div class="row">
    <h1>welcome </h1>
  </div>
  <div class="row">
    <div class="col">

    </div>
    <div class="col d-flex justify-content-center">
      <form action="<%=request.getContextPath()%>/main">   
      <% if (jwtToken != null) { %>
      <input type="hidden" id="jwtToken" name="jwtToken" value="<%= jwtToken %>">
      <%} %>  
        <button type="submit" class="btn btn-primary btn-lg">Lottery</button>
      </form>
    </div>
    <div class="col">

    </div>
  </div>
</div>


</body>
</html>