<%--<p>THIS IS SUB PAGE. TYPE IS--%>
<%--  <%= request.getParameter("type") %>.</p>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<p>
  THIS IS SUB PAGE. TYPE IS <%= request.getParameter("type") %>.
</p>

<p>
  SUB : ID IS  <%=request.getParameter("id")%>
</p>