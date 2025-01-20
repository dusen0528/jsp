# Java Beans
>  “빌더 형식의 개발도구에서 가시적으로 조작이 가능하고 또한 재사용이 가능한 소프트웨어 컴포넌트이다.”
- 객체 지향 프로그래밍의 가장 큰 이점중 하나는 다른 프로그램에서도 객체 재사용이 가능하다는 것
- 예시로 워드에서 동작하는 맞춤법 검사 프로그램을 만들었을 때 이메일 프로그램에서도 그 객체를 사용할 수 있어야함
- 자바빈은 자바빈 규격이라는 엄격한 지침에 따라 다른 객체와 아주 쉽게 쓰일 수 있게 됨
- Java Bean = 자바로 작성된 재사용 가능한 소프트웨어 컴포넌트 

# POJO
- 특정 규약에 종속되지 않는다
  - JAVA 언어와 꼭 필요한 API 외에는 종속되면 안됨
- 특정 환경에 종속되지 않음
  - 특정 기업의 프레임워크나 서버에서 동작하는 코드라면 POJO라고 할 수 없음
  - 예시로 웹관련(HttpServletRequest .. ) 즉 특정 환경에 종속적인 기술을 담고있는 인터페이스나 클래스 사용해선 안됨
- 객체지향 원리에 충실 해야함
  - 자바 문법을 사용했다고 해서 객체지향 프로그래밍과 설계가 적용되었다고 볼 수 없음
  - 책임과 역할이 각기 다른 코드를 한 클래스에 몰아넣어 덩치 큰 만능 클래스를 만들고, 상속돠 다형성의 적용이 아닌 if/switch 문으로 가득 설계된 오브젝트라면 POJOrk dksla

**POJO 장점**
- 깔끔한 코드
- 간편한 테스트
- 객체지향 설계
- 복잡한 도메인을 가진곳에서 효과적으로 사용됨

**POJO 프레임워크**
- 스프링 프레임워크가 대표적인 POJO 프레임워크 
- 엔터프라이즈 환경에서의 각종 서비스와 기술적인 필요를 POJO방식으로 만들어 코드에 적용 가능

## Java Beans 지켜야할 관례
- 클래스는 직렬화 되어야 합니다. 
- 클래스는 기본 생성자를 가지고 있어야 합니다. 
- 클래스의 속성들은 get, set 혹은 표준 명명법을 따르는 메서드들을 사용해 접근할 수 있어야 합니다.
- 클래스는 필요한 이벤트 처리 메소드들을 포함하고 있어야 합니다.

## Java Beans의 간단한 예제
- User 클래스는 직렬화를 위해서 Serializable 구현합니다. 
- User 클래스는 Default 생성자인 public User() 가지고 있습니다. 
- User 클래스는 get, set 메소드를 가지고 있습니다. 
- User 클래스는 isCoding(), setCoding(Boolean coding) 표준 명명법을 따르는 메서드들을 사용해 접근할 수 있습니다.

```java
public class User implements Serializable {
    private String userName;
    private int userAge;
    private boolean coding;

    public User(){}

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getUserAge() {
        return userAge;
    }

    public void setUserAge(int userAge) {
        this.userAge = userAge;
    }

    public boolean isCoding() {
        return coding;
    }
}
```
## POJO VS Java Beans

JavaBeans는 특별한 POJO의 변형이라고 할 수 있다. 또한 JavaBeans는 POJO이다.
하지만 POJO는 JavaBeans라고 할 수는 없다. 즉 POJO는 JavaBeans보다는 넓은 개념이다.
POJO 클래스와 Bean은 모두 가독성과 재사용성을 높이기 위해 Java 객체를 정하는데 사용된다.
POJO에는 다른 제한 사항이 없지만 빈은 몇가지 제한 사항이 있는 특수한 POJO이다.

**코드**
```
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>jsp bean action tag</title>
</head>
<body>
  <jsp:useBean id="user1" scope="request" class="com.nhnacademy.jsp.User" />
  <jsp:setProperty name="user1" property="name" param="userName" />
  <jsp:setProperty name="user1" property="age" param="userAge" />
  <p>my name is <jsp:getProperty name="user1" property="name"/>.</p>
  <p>i am <jsp:getProperty name="user1" property="age"/>years old.</p>
  <p>toString : <%=request.getAttribute("user1")%></p>
</body>
</html>
```
-  URL 파라미터(userName=marco&userAge=38)를 사용하려면 value 속성 대신 param 속성을 사용해야 함 
-  기존 코드는 value로 직접 값을 지정했기 때문에 URL 파라미터와 상관없이 항상 같은 값("marco", 38)이 설정됨

### request
**http://localhost:8080/bean.jsp**
![스크린샷 2025-01-20 오전 10.02.18.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_eMm8JP/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.02.18.png)

**http://localhost:8080/bean.jsp?userName=inho&userAge=26**
![스크린샷 2025-01-20 오전 10.02.34.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_pE2mdY/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.02.34.png)

- 이후 다시 돌아가면 1번의 요청에서만 user1 객체 유지하는 것을 확인가능 
![스크린샷 2025-01-20 오전 10.03.13.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_Fa6u7f/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.03.13.png)


### session
```
<jsp:useBean id="user1" scope="session" class="com.nhnacademy.jsp.User" />
// ...
<p>toString : <%=session.getAttribute("user1")%></p>
```
**http://localhost:8080/bean.jsp?userName=inho&userAge=26**
![스크린샷 2025-01-20 오전 10.06.13.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_9FzOdn/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.06.13.png)
- 이후 새로 고침을 해도 데이터가 유지되며, 브라우저 닫기전 까지 user1 객체 유지

![스크린샷 2025-01-20 오전 10.11.44.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_IvUZDm/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.11.44.png)

>💡새탭을 생성해서 bean.jsp에 들어가도 똑같은 정보가 나오는 이유
같은 세션 (데이터 공유됨)
    - 같은 브라우저의 새 탭 
    - 같은 브라우저의 새 창
다른 세션 (데이터 공유 안됨)
    - 다른 브라우저  
    - 시크릿/비공개 창
    - 브라우저 완전 종료 후 재시작
즉 session scope는 브라우저 단위가 아닌 세션 단위로 동작한다.

### application
```
<jsp:useBean id="user1" scope="application" class="com.nhnacademy.jsp.User" />
<p>toString : <%=application.getAttribute("user1")%></p>
```
![스크린샷 2025-01-20 오전 10.08.09.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_7lcBRm/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.08.09.png)
- 서버가 실행되는 동안 user1 객체 유지
- 다른 브라우저에서도 동일한 데이터 확인 가능 

---
# html beautify JavaBeans 버전
- jsoup 라이브러리 사용
```
<dependency>
    <groupId>org.jsoup</groupId>
    <artifactId>jsoup</artifactId>
    <version>1.15.3</version>
</dependency>
```

---
# 실습 3 Beautifier JavaBeans구현

**HtmlBeautifier.java**
```java
public class HtmlBeautifier implements Serializable {

    public HtmlBeautifier() {}

    private String html;

    public String getHtml() {
        return Jsoup.parse(this.html).html();
    }

    public void setHtml(String html) {
        this.html = html;
    }

}
```

**beautify.html**
```html
<html>
    <head>
        <meta charset="UTF-8">
        <title>정리되지 않은 Html 내용을 입력받아 beautify 해서 응답</title>
    </head>
    <body>
    <form method="post" action="beautify.jsp" >
        <textarea name="html" rows="10" cols="200"></textarea>
        <p>
            <button type="submit">전송</button>
        </p>
    </form>
    </body>
</html>
```
- 사용자로부터 HTML 코드를 입력받는 폼 제공
- `<textarea>`를 통해 정리되지 않은 HTML을 입력받음
- POST 방식으로 beautify.jsp에 데이터 전송
![스크린샷 2025-01-20 오전 10.42.39.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_yEmqTf/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.42.39.png)
**beautify.jsp**
```
<%@ page contentType="text/plan;charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<jsp:useBean id="htmlBeautifier" scope="request" class="com.nhnacademy.jsp.beans.HtmlBeautifier" />
<jsp:setProperty name="htmlBeautifier" property="html" param="html" />
<jsp:getProperty name="htmlBeautifier" property="html" />
```
- 입력받은 HTML을 실제로 처리하는 페이지
- JavaBean을 사용하여 HTML 코드를 정리(beautify)
- 처리된 결과를 출력
![스크린샷 2025-01-20 오전 10.42.46.png](../../../../../var/folders/lf/y10g6sqx1r31qpbktbvwk_f00000gn/T/TemporaryItems/NSIRD_screencaptureui_Y57ACQ/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-01-20%20%EC%98%A4%EC%A0%84%2010.42.46.png)