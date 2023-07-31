<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOM TEST</title>
<script>
        
    // 'request'라는 id를 가진 버튼 클릭 시 실행.
    $("#request").click(function(){
 
            // json 형식으로 데이터 set
            var params = {
                      prodNo    : $("#prodNo").val()
                    , materNo1  : $("#materNo1").val()
                    , materNo2  : $("#materNo2").val()	
            }
                
            // ajax 통신
            $.ajax({
                type : "POST",            // HTTP method type
                url : "/bom/show",        // 컨트롤러에서 대기중인 URL 주소
                data : params,            // Json 형식의 데이터
                success : function updateBOM(selectElement) {
        		    var selectedOption = selectElement.options[selectElement.selectedIndex];
        		    var prodNoInput = document.getElementById('prodNo');
        		    prodNoInput.value = selectedOption.value;
        		},
                error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("통신 실패.")
                }
            });
        });
            
</script>
</head>
<body>
	<div>        
        <section>
                <div>
                    <article>
                        <div>
                            <h2>BOM TEST</h2>
                            <dl>
                                <dt>prodNo</dt>
                                <dd>
                                    <input type="text"  id="prodNo" value="prodNo_1"/>
                                </dd>
                            </dl>
                            <dl>
                                <dd>
                                    <input type="button" id="request" value="제출"/>
                                </dd>
                            </dl>
                            <dl>
                                <dt>materNo1</dt>
                                <dd>
                                    <input type="text"  id="materNo1" value="material_1"/>
                                </dd>
                            </dl>
                            <dl>
                                <dt>materNo2</dt>
                                <dd>
                                    <input type="text"  id="materNo2" value="material_2"/>
                                </dd>
                            </dl>
                            <br>                            
                        </div>
                    </article>
                </div>
        </section>
    </div>
</body>
</html>