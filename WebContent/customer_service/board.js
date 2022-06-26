function canWrite(id) {
	if	(id == null || id.length == 0) {
		alert("로그인 해주세요.");
	} else {
		location.href="qnaWrite.jsp";
	}
}

function doWrite() {
	if (document.boardForm.u_id.value.length == 0) {
		alert("잘못된 접근입니다.");
		location.href="qnaList.jsp";
		return;
	}
	if (document.boardForm.b_title.value.length == 0) {
		alert("글 제목을 입력해 주세요.");
		document.boardForm.b_title.focus();
		return;
	}
	if (document.boardForm.b_content.value.length == 0) {
		alert("글 내용을 입력해 주세요.");
		document.boardForm.b_content.focus();
		return;
	}
	if(document.boardForm.b_pwd.value.length == 0){
		alert("비밀번호를 입력해 주세요.");
		boardForm.b_pwd.focus();
		return;
	}
	
	document.boardForm.submit();
}


