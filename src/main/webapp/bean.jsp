<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>jsp bean action tag</title>
</head>
<body>
  <jsp:useBean id="user1" scope="session" class="com.nhnacademy.jsp.User" />
  <jsp:setProperty name="user1" property="name" param="userName" />
  <jsp:setProperty name="user1" property="age" param="userAge" />
  <p>my name is <jsp:getProperty name="user1" property="name"/>.</p>
  <p>i am <jsp:getProperty name="user1" property="age"/>years old.</p>
  <p>toString : <%=session.getAttribute("user1")%></p>
</body>
</html>
