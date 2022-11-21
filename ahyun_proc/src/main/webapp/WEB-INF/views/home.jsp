<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<title>Home</title>
</head>
<body>
<script type="text/javascript">
$(function(){
	$(".btnDown").on("click",function(){
	     $.ajax({
	    		url:"${pageContext.request.contextPath}/jsonDownload",
	    		type : 'POST',
	    		dataType : 'json',
	    		success: function(data) {
	    			saveToFile_Chrome("랜덤key생성",data.key);
	    	    },
	    	    error: function(request,status,error) {
	    	    	alert(error);
	    	    } 
	    	});
	});
	
	function saveToFile_Chrome(fileName, content) {
	    var blob = new Blob([content], { type: 'text/plain' });
	    objURL = window.URL.createObjectURL(blob);
	            
	    // 이전에 생성된 메모리 해제
	    if (window.__Xr_objURL_forCreatingFile__) {
	        window.URL.revokeObjectURL(window.__Xr_objURL_forCreatingFile__);
	    }
	    window.__Xr_objURL_forCreatingFile__ = objURL;
	    var a = document.createElement('a');
	    a.download = fileName;
	    a.href = objURL;
	    a.click();
	}
});

</script>
<h1>
	Hello world!  
</h1>
<div class="response">
	
</div>
<P>  The time on the server is ${serverTime}. </P>
<button class="btnDown" id="btnDown">다운로드</button>
</body>
</html>
