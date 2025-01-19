# JSP 문법

## <%@ %>
- page : JSP 페이지에 대한 정보
```
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
```

- include : JSP 파일 안에 다른 JSP나 HTML 파일 포함
```
<%@ include file="/some/path/content.html %>
```

- tablib : 태그 라이브러리 선언 
```
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

## JSP 기본 문법 (Expression)
### <%=%>
- 변수, 메소드 호출 등 표현식(expression)의 실행 결과 출력
```
<%= "Hello, World"%>
```
```
<%= 17*5 %>
```
```
<%= request.getParameter('name') %>
```

## JSP 기본 문법 (Declaration)
- 전역변수
  - outside the _jspService() method

<%!%>
- 변수나 메소드 등을 선언
```
<%! String name = "James" %>
```
```
<%! 
    public int minus(int i, int j){
        return i-j;
    }
%>
```
```
JSP(JavaServer Pages)에서 <%! %>는 선언문(Declaration)을 나타내는 태그입니다.
“전역 선언문”이라고 생각하면 됨
이 태그 안에 쓰는 내용은 페이지 전체에서 사용할 수 있는 “도구”를 만드는 것
즉 <JSP 페이지의 전역 범위(Global scope)에서 사용할 수 있는 변수, 메소드, 클래스 등을 선언할 때 사용됨>
<%! String 인사말 = “안녕하세요!”;> 이렇게 하면 페이지 어디서든 “인사말”이라는 변수를 사용
```

## JSP 기본 문법 (Scriptlet)
- 지역변수 
  - inside the _jspService() method

### <% %>
- <%와 %> 사이에 있는 코드 실행
```
<%
    int a = 3;
    int b = 2;
    
    if(a>b){
      out.println(minus(a,b));
    }
```

---
# IntelliJ Tomcat 작동 방식

## Tomcat 서버 실행 경로 
```
/Users/nhn/IdeaProjects/was/apache-tomcat-9.0.71/bin/catalina.sh run
```

## CATALINA_BASE 이해하기
- 위치: /Users/nhn/Library/Caches/JetBrains/IntelliJIdea2021.2/tomcat/[고유ID]
- 역할: Tomcat의 작업 디렉토리
- 중요성: JSP → Servlet 변환이 이루어지는 곳

## JSP 변환 경로
```
CATALINA_BASE/work/Catalina/localhost/jsp_war/org/apache/jsp
```
- 이 경로에서 JSP 파일이 Java Servlet 코드로 자동 변환
- 변환된 Servlet이 실제로 실행되는 위치

💡 핵심: JSP 파일을 작성하면 Tomcat이 이를 해당 경로에서 Servlet으로 자동 변환하여 실행

---
```
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>sessionCounter</title>
</head>
<body>
<%
    Long counter = 0l;
    if(Objects.nonNull(session.getAttribute("counter"))){
        counter = (Long) session.getAttribute("counter");
    }
    session.setAttribute("counter",++counter);
%>
<h1>
    counter:<%=counter%>
</h1>
</body>
</html>
```
- <% %> 안에는 자바 코드를, 밖에는 HTML 코드를 작성
- 주석 차이점
```
<!-- <%= i %>단 시작 - html comment -->   // HTML 주석
<%-- <%= i %>단 시작 - Scriptlet comment --%>  // JSP 주석
```
**HTML 주석(<!-- -->)**
- 클라이언트로 전송됨
- 브라우저에서 소스 보기로 확인 가능
- JSP 표현식(<%= %>)이 실행되어 값이 주석에 포함됨


**JSP 주석(<%-- --%>)**
- 서버에서 처리되어 클라이언트로 전송되지 않음
- 브라우저에서 볼 수 없음
- JSP 표현식이 실행되지 않음