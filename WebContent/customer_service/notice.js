function check_ok(){
	if(reg_frm.n_title.value.length == 0){
		alert("제목을 써주세요.");
		reg_frm.n_title.focus();
		return;
	}
	
	if(reg_frm.n_content.value.length == 0){
		alert("내용을 써주세요.");
		reg_frm.n_content.focus();
		return;
	}
	
	if(reg_frm.n_pwd.value.length == 0){
		alert("비밀번호를 써주세요.");
		reg_frm.n_pwd.focus();
		return;
	}
	
	document.reg_frm.submit();
}

