# jsp_team_project
JSP를 이용한 쇼핑몰 사이트 팀프로젝트입니다.
개발기간 : 3주
개발인원 : 5명
![image](https://user-images.githubusercontent.com/95404191/175819385-1931c3d2-1c2a-4338-a627-14651ba36174.png)

# 개요
개발환경
* FrontEnd : HTML, CSS, JS, JQuery, Bootstrap, Ajax
* BackEnd : Tomcat, java, jsp
* DataBase : Oracle

# 사용방법
깃허브
1. jsp_team_project.zip 파일 다운받기
2. 다운받은 zip 파일 압축을 푼다.

임포트
1. 이클립스를 실행하고 File > Import 클릭
2. General > Exisiting Projects into Workspace > next 클릭
3. Select root directory/select archive file 에 Browse... 클릭
4. 압축을 한 파일이나 압축을 푼 파일을 선택
5. Finish

DB 설정
1. cmd 실행 후 sqlplus > system 계정접속
2. create user team identified by 1234;
3. grant connect,resource,unlimited tablespace, create view to team;
4. Team 계정 접속후
5. 이클립스에있는 1.sql 파일을 드래그해서 @붙이고 넣어준다.

설정파일
<Context docBase="team" path="/team" reloadable="true" source="org.eclipse.jst.jee.server:team">
	    <Resource auth="Container" driverClassName="oracle.jdbc.OracleDriver" maxActive="100" maxIdle="30" maxWait="10000" name="jdbc/oracle" password="1234" type="javax.sql.DataSource" url="jdbc:oracle:thin:@localhost:1521:xe" username="team"/>
    	</Context>
메인을 한 번 실행 후 server.xml 파일에 들어가 위의 텍스트를 복사해서 추가

이미지 넣기
![image](https://user-images.githubusercontent.com/95404191/175819515-8250817d-ded8-4f3a-940e-3a43deec2540.png)
메인페이지 실행 후 이미지들을 해당 경로에 넣어준다.

# 설명

### ERD
![image](https://user-images.githubusercontent.com/95404191/175819550-9a4d4e62-b26d-4dc7-9ced-ac3275ad8f7e.png)

### 메인 화면
![image](https://user-images.githubusercontent.com/95404191/175819574-6058154c-85fd-44b4-b2dd-0259beda5596.png)

### 로그인 / 회원가입
![image](https://user-images.githubusercontent.com/95404191/175819596-6dcdf17b-c5ce-4ee4-b639-6f2af1731f6e.png)

### 아이디 / 비밀번호 찾기
![image](https://user-images.githubusercontent.com/95404191/175819613-9cae16f9-fa7a-4953-9742-f087475fd57d.png)

### 검색 기능
![image](https://user-images.githubusercontent.com/95404191/175819639-b54f9f5d-03e2-4ac6-a25f-4ab74931fed1.png)

### 상품 목록
![image](https://user-images.githubusercontent.com/95404191/175819657-59269bbf-5f6d-447e-b2f6-3ff79abdf57d.png)

![image](https://user-images.githubusercontent.com/95404191/175819670-ce3e1e58-951b-4369-b2cb-11eeaf791469.png)

![image](https://user-images.githubusercontent.com/95404191/175819687-3d5c5d3e-0ed3-4dbd-8822-6bf7bfc9a396.png)

### 상품 목록 기능
![image](https://user-images.githubusercontent.com/95404191/175819702-81c47df9-3c66-417d-bec0-8bbc8b24f4cb.png)

![image](https://user-images.githubusercontent.com/95404191/175819715-bfd8bcf6-5b8f-41ba-9d41-e664b21bb81d.png)

### 상품 상세 페이지
![image](https://user-images.githubusercontent.com/95404191/175819730-d69cec79-079b-4885-8db7-f6ed3776f61a.png)

![image](https://user-images.githubusercontent.com/95404191/175819745-f4903bb7-ece0-43a2-8e75-5f326be9f540.png)

### 최근 본 상품
![image](https://user-images.githubusercontent.com/95404191/175819754-d497159a-fddd-43ac-9ef0-e7d39238974c.png)

### 장바구니 목록
![image](https://user-images.githubusercontent.com/95404191/175819768-6d4a47d5-b839-4715-8b35-9a48e1a8643f.png)

### 주문하기
![image](https://user-images.githubusercontent.com/95404191/175819774-2bfeac0d-a78c-46b2-a17a-dc7a83878947.png)

### 결제 시스템
![image](https://user-images.githubusercontent.com/95404191/175819788-ebae688d-638d-4f44-a930-7ebb6adf4d07.png)

### 마이 페이지
![image](https://user-images.githubusercontent.com/95404191/175819798-83dc77eb-419e-437a-9b14-14872280d8f4.png)

### 환불 신청
![image](https://user-images.githubusercontent.com/95404191/175819807-acae07c2-bfbd-45e5-9982-7de86b1f8434.png)

### 결제시스템 / 마이페이지 추가
![image](https://user-images.githubusercontent.com/95404191/175819823-d175dfe3-7730-407f-96cd-80f4d2ce4ae3.png)

### 회원 정보 수정 / 회원 탈퇴
![image](https://user-images.githubusercontent.com/95404191/175819858-dc0ae168-fce2-43d6-96d3-ed0fb9bc9cf0.png)

### 공지사항
![image](https://user-images.githubusercontent.com/95404191/175819871-dcce55d2-053f-4d11-8851-fe1afc995362.png)

![image](https://user-images.githubusercontent.com/95404191/175819880-29e6542c-e980-4836-b096-edc7ae2cd547.png)

![image](https://user-images.githubusercontent.com/95404191/175819900-e9b61db6-4bfa-4fb7-8be3-d9f066a6588b.png)

### Q&A
![image](https://user-images.githubusercontent.com/95404191/175819908-e9eafe06-4320-44a5-b0e0-7c2e0a995263.png)

### 관리자 페이지
![image](https://user-images.githubusercontent.com/95404191/175819945-80349279-837f-449b-b9e2-de09b27f4929.png)

### Q&A 관리자 페이지
![image](https://user-images.githubusercontent.com/95404191/175819953-fc7e59a5-52d2-4ab8-971e-bb77c0664c54.png)

![image](https://user-images.githubusercontent.com/95404191/175819961-75ce8026-a2b9-49db-abe5-6de64f086da6.png)

### 상품 등록
![image](https://user-images.githubusercontent.com/95404191/175819975-d41948aa-679f-4509-ae2b-ea83599cbc3c.png)

### 상품 리스트
![image](https://user-images.githubusercontent.com/95404191/175819986-a72aff96-6af2-4ad1-8d56-b0ccd0b6852d.png)

### 주문 관리
![image](https://user-images.githubusercontent.com/95404191/175819998-3fa68549-6f63-429b-a55f-a6583afdce5e.png)

### 관리자 회원 관리
![image](https://user-images.githubusercontent.com/95404191/175820017-25d0f0db-a10f-4854-b948-80849f2709f7.png)


