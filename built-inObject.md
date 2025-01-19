# JSP 내장 객체
![img_1.png](img_1.png)

markdownCopy# JSP 내장 객체와 Scope 쉽게 이해하기

## 주요 내장 객체
- **request**: 클라이언트의 요청 정보를 담고 있는 객체
- **response**: 클라이언트에게 응답을 보내기 위한 객체
- **session**: 클라이언트별 세션 정보를 저장하는 객체
- **application**: 모든 클라이언트가 공유하는 정보를 담는 객체
- **out**: HTML 출력을 위한 객체
- **pageContext**: JSP 페이지에 대한 정보를 담고 있는 객체
- **page**: JSP 페이지 자체를 나타내는 객체
- **config**: 서블릿 설정 정보를 담는 객체
- **exception**: 예외 처리를 위한 객체

## Scope(범위) 이해하기

### 1. page scope
- 현재 JSP 페이지 내에서만 사용 가능
- 다른 페이지로 이동하면 사용 불가
- `pageContext` 객체로 접근

### 2. request scope
- 하나의 요청이 처리되는 동안 사용 가능
- forward될 때도 값 유지됨
- `request` 객체로 접근

> # Forward란?
- 하나의 서블릿/JSP에서 다른 서블릿/JSP로 요청을 전달하는 방식
- 클라이언트는 이 이동을 알 수 없음 (URL이 변경되지 않음)
- **page scope**: forward하면 사라짐 (새로운 페이지니까)
- **request scope**: forward해도 유지됨 (같은 요청이니까)


### 3. session scope
- 브라우저가 종료되기 전까지 사용 가능
- 로그인 정보 같은 사용자별 정보 저장에 활용
- `session` 객체로 접근

### 4. application scope
- 서버가 실행되는 동안 계속 유지
- 모든 사용자가 공유하는 데이터 저장
- `application` 객체로 접근

> 💡 **scope의 크기**: page < request < session < application

---
# 코드 분석

## 1. 페이지 설정
```jsp
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" 
         trimDirectiveWhitespaces="true" 
         language="java" %>
```
- 필요한 자바 클래스들을 임포트 
- 페이지의 인코딩과 언어 설정

## 2. 유틸리티 메소드 선언
```
<%!
    private List getClasses(Class clazz) {
        // 클래스의 상속 계층구조를 리스트로 반환하는 메소드
        if (Objects.isNull(clazz)) {
            return Collections.emptyList();
        }
        List classes = new ArrayList<>();
        while (clazz != null) {
            classes.add(clazz.getName());
            clazz = clazz.getSuperclass();
        }
        return classes;
    }
%>
```

- response: 응답 설정하기
```jspCopyresponse.setContentType("text/plain");```

- request: 요청 파라미터 받기
```jspCopyrequest.getParameter("name")```

- config: 서블릿 정보 얻기
```jspCopyconfig.getServletName()```

- application: 애플리케이션 정보 얻기
```jspCopyapplication.getContextPath()```


## 3. Declaration(<%! %>) vs Scriptlet(<% %>)
- Declaration: 메서드나 변수를 클래스 레벨에서 선언
- Scriptlet: 실행될 자바 코드 작성

**코드**
```
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" language="java" %>
<%!
    private List<String> getClasses(Class<?> clazz) {
        if (Objects.isNull(clazz)) {
            return Collections.emptyList();
        }

        List<String> classes = new ArrayList<>();
        while (clazz != null) {
            classes.add(clazz.getName());
            clazz = clazz.getSuperclass();
        }

        return classes;
    }
%>
<%
    response.setContentType("text/plain");                                  // response

    out.println("Hello, " + request.getParameter("name"));                  // request
    out.println("servlet name = " + config.getServletName());               // config
    out.println("context path = " + application.getContextPath());          // application

    out.println("this == page? " + (this == page));

    List<String> classes = getClasses(getClass());                          // page
    out.println("page classes = " + String.join(" > ", classes));

    classes = getClasses(pageContext.getClass());                           // pageContext
    out.println("pageContext classes = " + String.join(" > ", classes));
%>
```

**결과**
```
Hello, null
servlet name = jsp
context path = 
this == page? true
page classes = org.apache.jsp.implicit_jsp > org.apache.jasper.runtime.HttpJspBase > jakarta.servlet.http.HttpServlet > jakarta.servlet.GenericServlet > java.lang.Object
pageContext classes = org.apache.jasper.runtime.PageContextImpl > jakarta.servlet.jsp.PageContext > jakarta.servlet.jsp.JspContext > java.lang.Object
```

# trimDirectiveWhitespaces 속성 이해하기
- JSP 페이지 디렉티브의 속성 중 하나
- JSP 페이지의 출력에서 불필요한 공백이나 빈 줄을 제거할지 결정

true: JSP 페이지의 디렉티브나 스크립틀릿 등으로 인해 생기는 불필요한 공백 제거
false: 모든 공백을 유지 (기본값)

> 💡 실무에서는 주로 true로 설정하여 불필요한 공백을 제거하고 응답 크기를 최적화합니다.


---
# 실습 - forward vs include

**pageContext.jsp**
```
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title> forward vs include </title>
    </head>
    <body>
        <h1>THIS IS pageContext.jsp.</h1>

        <%
            String type = request.getParameter("type");
            if ("include".equals(type)) {
                pageContext.include("sub.jsp");
            } else if ("forward".equals(type)) {
                pageContext.forward("sub.jsp");
            } else {
                out.println("type parameter is needed.");
            }
        %>

    </body>
</html>
```

**sub.jsp**
```
<p>THIS IS SUB PAGE. TYPE IS <%= request.getParameter("type") %>.</p>
```

## 다음 두 요청의 차이점은?
- /pageContext.jsp?type=include
include는 해당 URL로 제어권을 넘기지만 include처리가 끝나면 다시 제어권은 원래의 페이지로 돌아옴 ( 즉 해당 페이지에 삽입하는것과 같음 )
- /pageContext.jsp?type=forward
forward는 요청과 응답에 대한 제어권을 URL로 지정된 주소로 영구적으로 넘김. -> 종료


## include 방식
- 🔄 "다른 페이지를 가져와서 현재 페이지에 붙여넣기"
- 예시:
- A.jsp에서 B.jsp를 include
- A.jsp가 실행되다가
- B.jsp 내용을 가져와서 실행하고
- 다시 A.jsp로 돌아와서 계속 실행

## forward 방식
- ➡️ "다른 페이지로 완전히 이동하기"
- 예시:
- A.jsp에서 B.jsp로 forward
- A.jsp 실행이 중단되고
- B.jsp로 완전히 이동
- A.jsp로 돌아오지 않음

## 쉬운 비유
- include는 "복사 붙여넣기" 같은 것
- forward는 "페이지 이동" 같은 것

> 💡 핵심 차이: include는 돌아오지만, forward는 돌아오지 않음


