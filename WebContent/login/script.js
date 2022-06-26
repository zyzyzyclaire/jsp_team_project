function check_ok(){
	if(reg_frm.user_id.value.length == 0){
		alert("아이디를 써주세요.");
		reg_frm.user_id.focus();
		return;
	}
	
	if(reg_frm.user_pwd.value.length == 0){
		alert("패스워드는 반드시 입력해야 합니다.");
		reg_frm.user_pwd.focus();
		return;
	}	
	
	if(reg_frm.user_pwd.value != reg_frm.pwd_check.value){
		alert("패스워드가 일치하지 않습니다.");
		reg_frm.pwd_check.focus();
		return;
	}	
	
	if(reg_frm.user_name.value.length == 0){
		alert("이름을 써주세요.");
		reg_frm.user_name.focus();
		return;
	}
	
	if(reg_frm.user_email.value.length == 0){
		alert("Email을 써주세요.");
		reg_frm.user_email.focus();
		return;
	}
	
	// register.jsp의 form action값으로 submit함
	document.reg_frm.submit();
}

function update_check_ok(){
	if(document.upd_frm.user_pwd.value.length == 0){
		alert("패스워드는 반드시 입력해야 합니다.");
		document.upd_frm.user_pwd.focus();
		return;
	}	
	
	if(document.upd_frm.user_pwd.value != document.upd_frm.pwd_check.value){
		alert("패스워드가 일치하지 않습니다.");
		upd_frm.pwd_check.focus();
		return;
	}	
	
	if(document.upd_frm.user_email.value.length == 0){
		alert("Email을 써주세요.");
		document.upd_frm.user_email.focus();
		return;
	}
	
	// userUpdate.jsp의 form action값으로 submit함
	document.upd_frm.submit();
}

function delete_check_admin(u_id) {
	if(confirm("정말 탈퇴 처리하시겠습니까?")) {
		location.href = "deleteMember.jsp?delete_uid=" + u_id;
	} else {
		location.reload();
	}
}