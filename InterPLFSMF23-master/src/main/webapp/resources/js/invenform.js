//lot form temp
var lottemplate = [
    {
    	name: 'lotno',
        bind: 'lotno',
        type: 'text',
        label: 'LOT 번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'prodno',
        bind: 'prodno',
        type: 'text',
        label: '상품번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
    {
    	name: 'materno',
        bind: 'materno',
        type: 'text',
        label: '재료번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
	{
    	name: 'qty',
        bind: 'qty',
        type: 'text',
        label: '수 량',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
	{
    	name: 'whseno',
        bind: 'whseno',
        type: 'text',
        label: '저장 위치',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'lotsubButton',
        type: 'button',
        text: '재고로트 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initLotForm(){
	var lotinsertform = $('#lotinsertform');
	lotinsertform.jqxForm({
        template: lottemplate,
        value: [],
        padding: { left: 10, top: 10, right: 0, bottom: 10 }
	});
    var subbtn = lotinsertform.jqxForm('getComponentByName', 'lotsubButton');
    subbtn.on('click', function () {
    	insertLot();
    });	
}

//lotupform
var lotuptemplate = [
    {
    	name: 'lotno',
        bind: 'lotno',
        type: 'label',
        label: 'LOT 번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'prodno',
        bind: 'prodno',
        type: 'text',
        label: '상품번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
    {
    	name: 'materno',
        bind: 'materno',
        type: 'text',
        label: '재료번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
	{
    	name: 'qty',
        bind: 'qty',
        type: 'text',
        label: '수 량',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
	{
    	name: 'whseno',
        bind: 'whseno',
        type: 'text',
        label: '저장 위치',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'lotupsubButton',
        type: 'button',
        text: '재고로트 수정',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initLotUpForm(){
	var lotupdateform = $('#lotupdateform');
	lotupdateform.jqxForm({
	    template: lotuptemplate,
	    value: [],
	    padding: { left: 10, top: 10, right: 0, bottom: 10 }
	});
	var subbtn = lotupdateform.jqxForm('getComponentByName', 'lotupsubButton');
	subbtn.on('click', function () {
		updateLot();
	});	
}

var whtemplate = [
    {
    	name: 'whseno',
        bind: 'whseno',
        type: 'text',
        label: '창고 번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'whseloc',
        bind: 'whseloc',
        type: 'text',
        label: '창고 위치',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
 	{
    	name: 'whsename',
        bind: 'whsename',
        type: 'text',
        label: '창고 이름',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'whsubButton',
        type: 'button',
        text: '신규창고 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initWhForm(){
	var warehsinsertform = $('#warehsinsertform');
	        		warehsinsertform.jqxForm({
		                template: whtemplate,
		                value: [],
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = warehsinsertform.jqxForm('getComponentByName', 'whsubButton');
		            subbtn.on('click', function () {
		            	insertWhse();
		            });	
}

var prodtemplate = [
    {
    	name: 'prodno',
        bind: 'prodno',
        type: 'text',
        label: '상품 코드',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'prodname',
        bind: 'prodname',
        type: 'text',
        label: '상품 이름',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
 	{
    	name: 'prodprice',
        bind: 'prodprice',
        type: 'text',
        label: '상품 가격',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'category',
        bind: 'category',
        type: 'text',
        label: '상품 분류',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'leadtime',
        bind: 'leadtime',
        type: 'text',
        label: 'Lead Time',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'prodsubButton',
        type: 'button',
        text: '상품 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initProdForm(){
	var prodinsertform = $('#prodinsertform');
	        		prodinsertform.jqxForm({
		                template: prodtemplate,
		                value: [],
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = prodinsertform.jqxForm('getComponentByName', 'prodsubButton');
		            subbtn.on('click', function () {
		            	insertProduct();
		            });	
}

var matertemplate = [
    {
    	name: 'materno',
        bind: 'materno',
        type: 'text',
        label: '자재 코드',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'matername',
        bind: 'matername',
        type: 'text',
        label: '자재 이름',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
 	{
    	name: 'materprice',
        bind: 'materprice',
        type: 'text',
        label: '자재 단가',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'unit',
        bind: 'unit',
        type: 'text',
        label: '단 위',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'matersubButton',
        type: 'button',
        text: '재고로트 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initMaterForm(){
	var materinsertform = $('#materinsertform');
	        		materinsertform.jqxForm({
		                template: matertemplate,
		                value: [],
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = materinsertform.jqxForm('getComponentByName', 'matersubButton');
		            subbtn.on('click', function () {
		            	insertMaterial();
		            });	
}

function lotfiller(lotno){
	$.ajax({
              type: 'POST',
              url: 'http://localhost:8584/SMFPlatform/inventory/lotdata.json',
              dataType: 'json',
              async: false,
              data:{lot:lotno},
              success: function(data) {
               	var value = data;
               	$("#lotupdateform").jqxForm("val", value);
              },
              error: function(xhr, status, error) {
                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
              }
            });
}

function insertLot(){
	var targetlot= $("#lotinsertform").jqxForm('getComponentByName' , "lotno");
	var targetprodno= $("#lotinsertform").jqxForm('getComponentByName' , "prodno");
	var targetmaterno= $("#lotinsertform").jqxForm('getComponentByName' , "materno");
	var targetqty= $("#lotinsertform").jqxForm('getComponentByName' , "qty");
	var targetwhseno= $("#lotinsertform").jqxForm('getComponentByName' , "whseno");
	
	var formdata = {lot:targetlot[0].value, 
		prodno:targetprodno[0].value, 
		materno:targetmaterno[0].value, 
		qty:targetqty[0].value, 
		whseno:targetwhseno[0].value};
	
	if(isempty(targetlot[0].value)||isempty(targetqty[0].value)||isempty(targetwhseno[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else if(isempty(targetprodno[0].value) && isempty(targetmaterno[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else{
		$.ajax({
	              type: 'POST',
	              url: 'http://localhost:8584/SMFPlatform/inventory/insertlot.do',
	              async: false,
	              data:formdata,
	              success: function(data) {
	              	alert("입력 완료!");
					inventorylist.ajax.reload();
					popinventorylist.ajax.reload();
					$("#lotinsertform").jqxForm("val",{lotno: null,prodno: null,materno: null,qty: null,whseno: null});
	              },
	              error: function(xhr, status, error) {
	                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
	                alert("입력 실패!");
	              }
	            });
	}
}

function updateLot(){
	var targetlot= $("#lotupdateform").jqxForm('getComponentByName' , "lotno");
	var targetprodno= $("#lotupdateform").jqxForm('getComponentByName' , "prodno");
	var targetmaterno= $("#lotupdateform").jqxForm('getComponentByName' , "materno");
	var targetqty= $("#lotupdateform").jqxForm('getComponentByName' , "qty");
	var targetwhseno= $("#lotupdateform").jqxForm('getComponentByName' , "whseno");
	
	var formdata = {lot:targetlot[0].innerHTML, 
		prodno:targetprodno[0].value, 
		materno:targetmaterno[0].value,
		qty:targetqty[0].value, 
		whseno:targetwhseno[0].value};
	if(isempty(targetqty[0].value)||isempty(targetwhseno[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else if(isempty(targetprodno[0].value) && isempty(targetmaterno[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else{
		$.ajax({
	              type: 'POST',
	              url: 'http://localhost:8584/SMFPlatform/inventory/updatelot.do',
	              async: false,
	              data:formdata,
	              success: function(data) {
	               	alert("입력 완료!");
					popinventorylist.ajax.reload();
					$("#lotupdateform").jqxForm("val",{lotno: null,prodno: null,materno: null,qty: null,whseno: null});
	              },
	              error: function(xhr, status, error) {
	                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
	              }
	            });
            }
}

function insertProduct(){
	var targetprodno= $("#prodinsertform").jqxForm('getComponentByName' , "prodno");
	var targetprodname= $("#prodinsertform").jqxForm('getComponentByName' , "prodname");
	var targetcategory= $("#prodinsertform").jqxForm('getComponentByName' , "category");
	var targetprodprice= $("#prodinsertform").jqxForm('getComponentByName' , "prodprice");
	var targetleadtime= $("#prodinsertform").jqxForm('getComponentByName' , "leadtime");
	
	var formdata = {prodno:targetprodno[0].value,
		prodname:targetprodname[0].value,
		category:targetcategory[0].value,
		prodprice:targetprodprice[0].value,
		leadtime:targetleadtime[0].value};
	
	if(isempty(targetprodno[0].value)||isempty(targetprodname[0].value)||isempty(targetcategory[0].value)||isempty(targetprodprice[0].value)||isempty(targetleadtime[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else{
		$.ajax({
	              type: 'POST',
	              url: 'http://localhost:8584/SMFPlatform/inventory/insertproduct.do',
	              async: false,
	              data:formdata,
	              success: function(data) {
	               	alert("입력 완료!");
					productlist.ajax.reload();
					$("#prodinsertform").jqxForm("val", {prodno: null,prodname: null,category: null,prodprice: null,leadtime: null});
	              },
	              error: function(xhr, status, error) {
	                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
	              }
	            });
            }
}

function insertMaterial(){
	var targetmaterno= $("#materinsertform").jqxForm('getComponentByName' , "materno");
	var targetmatername= $("#materinsertform").jqxForm('getComponentByName' , "matername");
	var targetmaterprice= $("#materinsertform").jqxForm('getComponentByName' , "materprice");
	var targetunit= $("#materinsertform").jqxForm('getComponentByName' , "unit");
	
	var formdata = {materno:targetmaterno[0].value,
		matername:targetmatername[0].value,
		materprice:targetmaterprice[0].value,
		unit:targetunit[0].value}
	
	if(isempty(targetmaterno[0].value)||isempty(targetmatername[0].value)||isempty(targetmaterprice[0].value)||isempty(targetunit[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else{
		$.ajax({
	              type: 'POST',
	              url: 'http://localhost:8584/SMFPlatform/inventory/insertmaterial.do',
	              async: false,
	              data:formdata,
	              success: function(data) {
	               	alert("입력 완료!");
					materiallist.ajax.reload();
					$("#materinsertform").jqxForm("val", {materno: null,matername: null,materprice: null,unit: null});
	              },
	              error: function(xhr, status, error) {
	                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
	              }
	            });
            }
}

function insertWhse(){
	var targetwhseno= $("#warehsinsertform").jqxForm('getComponentByName' , "whseno");
	var targetwhsename= $("#warehsinsertform").jqxForm('getComponentByName' , "whsename");
	var targetwhseloc= $("#warehsinsertform").jqxForm('getComponentByName' , "whseloc");
	
	var formdata = {whseno:targetwhseno[0].value,
		whsename:targetwhsename[0].value,
		whseloc:targetwhseloc[0].value}
	
	if(isempty(targetwhseno[0].value)||isempty(targetwhsename[0].value)||isempty(targetwhseloc[0].value)){
		alert("누락된 필드가 있습니다");
		return;
	}else{
		$.ajax({
	              type: 'POST',
	              url: 'http://localhost:8584/SMFPlatform/inventory/insertwh.do',
	              async: false,
	              data:{lot:lotno},
	              success: function(data) {
	               	alert("입력 완료!");
					warehouselist.ajax.reload();
					$("#warehsinsertform").jqxForm("val",{whseno: null,whsename: null,whseloc: null});
	              },
	              error: function(xhr, status, error) {
	                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
	              }
	            });
            }
}

function isempty(value){ //옵셔널체이닝에 의한 경고
	if(!!value?.trim()) {
	  return false;
	} else {
	  return true;
	}
}

