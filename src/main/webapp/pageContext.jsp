<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--  <title> forward vs include </title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<h1>THIS IS pageContext.jsp.</h1>--%>

<%--<%--%>
<%--  String type = request.getParameter("type");--%>
<%--  if ("include".equals(type)) {--%>
<%--    pageContext.include("sub.jsp");--%>
<%--  } else if ("forward".equals(type)) {--%>
<%--    pageContext.forward("sub.jsp");--%>
<%--  } else {--%>
<%--    out.println("type parameter is needed.");--%>
<%--  }--%>
<%--%>--%>

<%--</body>--%>
<%--</html>--%>

<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--  <title>forward vs include</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<h1>THIS IS pageContext.jsp.</h1>--%>

<%--<%--%>
<%--  String type = request.getParameter("type");--%>
<%--  String id = "testUser"; // 테스트용 ID 추가--%>
<%--%>--%>

<%--&lt;%&ndash; type 파라미터에 따라 include 또는 forward 실행 &ndash;%&gt;--%>
<%--<% if ("include".equals(type)) { %>--%>
<%--<jsp:include page="sub.jsp">--%>
<%--  <jsp:param name="id" value="<%=id%>"/>--%>
<%--</jsp:include>--%>
<%--<% } else if ("forward".equals(type)) { %>--%>
<%--<jsp:forward page="sub.jsp">--%>
<%--  <jsp:param name="id" value="<%=id%>"/>--%>
<%--</jsp:forward>--%>
<%--<% } else { %>--%>
<%--<% out.println("type parameter is needed."); %>--%>
<%--<% } %>--%>

<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> forward vs include </title>
</head>
<body>
<%
  String id="marco";
%>
<h1>THIS IS pageContext.jsp.</h1>
<%
  String type = request.getParameter("type");
  if ("include".equals(type)) {
    //pageContext.include("sub.jsp");
%>
<jsp:include page="sub.jsp">
  <jsp:param name="id" value="<%=id%>"/>
</jsp:include>
<%
} else if ("forward".equals(type)) {
  //    pageContext.forward("sub.jsp");
%>
<jsp:forward page="sub.jsp">
  <jsp:param name="id" value="<%=id%>"/>
</jsp:forward>
<%
  } else {
    out.println("type parameter is needed.");
  }
%>

<p>
  pageContext : ID is <%=request.getParameter("id")%>
</p>

</body>
</html>