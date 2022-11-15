<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"></script>

<style type="text/css">
.myModalBtn{
	float: right;
	margin-bottom: 20px;
	margin-right: 20px;
}
</style>

</head>
<script type="text/javascript">
$(document).ready( function () {
    $('#myTable').DataTable();
    
    
    $(".btn_detail").on("click",function(){
    	
     var board_id =	$(this).closest("tr").find("#board_id").val(); 
     
     alert(board_id);
    	
     $.ajax({
    		url:"${pageContext.request.contextPath}/boardDetailInfo",
    		type : 'POST',
    		dataType : 'json',
    		data : {
    			board_id : board_id
    		},
    		success: function(data) {
    			
    			console.log(data);
    			
//     			$("input[name=detail_board_id]").val(data.BOARD_ID);
//     			$("input[name=detail_board_subject]").val(data.BOARD_SUBJECT);
//     			$("input[name=detail_board_depart_id]").val(data.BOARD_DEPART_ID);
//     			$("textarea[name=detail_board_content]").val(data.BOARD_CONTENT);
				
				$(".divImg").append('<img src=resources/img/'+data.ORG_FILE_NAME+'></img>');
				
    			
    	    },
    	    error: function(request,status,error) {
    	    	alert(error);
    	    } 
    	});
    });
    
} );

</script>
<body>

<div class="divImg">  
	
</div>

<h2 style="text-align: center;">두번쨰 한댜</h2>
<button style="width: 100px; height: 40px;" type="button" class="btn btn-primary myModalBtn" data-toggle="modal" data-target="#myModal">등록하기</button>
<table id="myTable" class="display">
    <thead>
        <tr>
            <th>순번</th>
            <th>아이디</th>
            <th>부서</th>
            <th>내용</th>
            <th>상세보기</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${boardInfoList }" var="items" varStatus="status">
    	<tr>
    		<input type="hidden" id="board_id" name="board_id" value="${items.BOARD_ID }"/>
            <td>${status.count }</td>
            <td>${items.BOARD_ID }</td>
            <td>${items.BOARD_DEPART_NAME }</td>
            <td>${items.BOARD_CONTENT }</td>
            <td><button class="btn btn-warning btn_detail" name="btn_detail" data-toggle="modal" data-target="#modifyModal">상세보기</button></td>
        </tr>
    	</c:forEach>
    </tbody>
</table>
<!-- 등록 Modal 시작 -->

<form id="form1" action="${pageContext.request.contextPath}/boardInsert" method="post" enctype="multipart/form-data" target="repacatFrame">
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" >
                <h5 class="modal-title" id="exampleModalLabel" style="font-weight:bold;">게시판 등록하기</h5>
            <div style="display: flex; justify-content: flex-end;">
                <button type="button" class="btn btn-success btn_reset_modal" style="width: 90px; height: 40px;">초기화</button>
                <input type="submit" class="btn btn-primary btn_save" style="width: 90px; height: 40px; margin-left: 15px;">저장
                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="width: 90px; height: 40px; margin-left: 15px;">닫기</button>
            </div>
            </div>
            <div class="modal-body">
                <div class="modal_view row">
                    <div class="col">
                        <table class="modal_table" border="1" style="margin-left: 10px;">
                            <tr class="input1_style">
                                <td class="search_style">아이디</td>
                                <td><input class="input1_style" type="text" placeholder="제목을 입력해주세요." id="board_id" name="board_id"></td>
                                <td class="search_style">제목</td>
                                <td><input class="input1_style" type="text" placeholder="제목을 입력해주세요." id="board_subject" name="board_subject"></td>
                            </tr>
                            <tr class="input1_style">
                                <td class="search_style">부서</td>
                                <td colspan="3">
                                    <select class="address_select" id="board_depart_id" name="board_depart_id" style="display: inline; width:150px !important; height: 40px;">
                                    	<option value='' selected="selected">선택</option>
                                     <c:forEach items="${departListInfo}" var="items">
                                     	<option value="${items.BOARD_DEPART_ID }">${items.BOARD_DEPART_NAME}</option>
                                     </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr class="input1_style">
                                <td class="search_style">파일<br/></td>
                                <td colspan="3">
                                <input type="file" id="board_file" name="board_file"></file>
                                </td>
                            </tr>
                            <tr class="input1_style">
                                <td class="search_style">내용<br/></td>
                                <td colspan="3">
                                <textarea id="board_content" name="board_content" rows="10" cols="50"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</form>
<!-- 등록 Modal 끝 -->

<!-- 수정 Modal 시작 -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" >
                <h5 class="modal-title" id="exampleModalLabel" style="font-weight:bold;">게시판 상세보기</h5>
            <div style="display: flex; justify-content: flex-end;">
                <button type="button" class="btn btn-success btn_save_modal_detail" style="width: 90px; height: 40px;">저장</button>
                <button type="button" class="btn btn-primary btn_remove_modal_detail" style="width: 90px; height: 40px; margin-left: 15px;">삭제</button>
                <button type="button" class="btn btn-primary btn_close_modal_detail" data-dismiss="modal" style="width: 90px; height: 40px; margin-left: 15px;">닫기</button>
            </div>
            </div>
            <div class="modal-body">
                <div class="modal_view row">
                    <div class="col">
                        <table class="modal_table" border="1" style="margin-left: 10px;">
                            <tr class="input1_style">
                                <td class="search_style">아이디</td>
                                <td><input class="input1_style" type="text" placeholder="제목을 입력해주세요." id="detail_board_id" name="detail_board_id"></td>
                                <td class="search_style">제목</td>
                                <td><input class="input1_style" type="text" placeholder="제목을 입력해주세요." id="detail_board_subject" name="detail_board_subject"></td>
                            </tr>
                            <tr class="input1_style">
                                <td class="search_style">부서</td>
                                <td colspan="3">
                                    <select class="address_select" id="detail_board_depart_id" name="detail_board_depart_id" style="display: inline; width:150px !important; height: 40px;">
                                    	<option value=''>선택</option>
                                     <c:forEach items="${departListInfo}" var="items">
                                     	<option value="${items.BOARD_DEPART_ID }">${items.BOARD_DEPART_NAME}</option>
                                     </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr class="input1_style">
                                <td class="search_style">파일<br/></td>
                                <td colspan="3">
                                <input type="file" id="detail_board_file" name="detail_board_file"></file>
                                </td>
                            </tr>
                            <tr class="input1_style">
                                <td class="search_style">내용<br/></td>
                                <td colspan="3">
                                <textarea id="detail_board_content" name="detail_board_content" rows="10" cols="50"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 수정 Modal 끝 -->
</body>
</html>