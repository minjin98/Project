<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title id='Description'>JavaScript PivotGrid - Events Handling Example</title>
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.light.css" type="text/css" />
    <c:set var="path" value="${pageContext.request.contextPath}"/>
    
    <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxdata.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpivot.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpivotgrid.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/demos.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
        	var data = [];
        	var products = [];
        	var selectedValue = $("select[name='prodName']").val();
        	products.push(selectedValue);
        	
        	$("input[name='bomList']").click(function() {
        	    selectedValue = $("select[name='prodName']").val();
        	    products.push(selectedValue);
        	  });

        	var materials = ["KC001", "KC002", "PBT001", "ABS001", "DYE001", "PCB001", "HSE001", "SWC001", "SWN001", "SWL001", "SLC001", "SLN001", "SLL001", "SPR001"];
        	var productNames = ["KBD_click"];
        	var priceValues = [100000, 50000, 50000, 20000, 10000, 5000, 50, 20, 10];

        	for (var i = 0; i < productNames.length; i++) {
        	  for (var j = 0; j < materials.length; j++) {
        	    var productIndex = i;
        	    var price = priceValues[productIndex];
        	    var quantity = 1 + Math.round(Math.random() * 10);

        	    var row = {
        	      "product": products[1],
        	      "material": materials[j],
        	      "productname": productNames[1],
        	      "price": price,
        	      "quantity": quantity,
        	      "total": price * quantity
        	    };

        	    data.push(row);
        	  }
        	}

           
            var source =
            {
                localdata: data,
                datatype: "array",
                datafields:
                [
                    { name: 'product', type: 'string' },
                    { name: 'material', type: 'string' },
                    { name: 'productname', type: 'string' },
                    { name: 'quantity', type: 'number' },
                    { name: 'price', type: 'number' },
                    { name: 'total', type: 'number' }
                ]
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            dataAdapter.dataBind();
            
            // create a pivot data source from the dataAdapter
            var pivotDataSource = new $.jqx.pivot(
                dataAdapter,
                {
                    pivotValuesOnRows: false,
                    rows: [{ dataField: 'product' }, { dataField: 'material'}],
                    columns: [{ dataField: 'productname'}],
                    filters: [
                        {
                            dataField: 'productname',
                            filterFunction: function (value) {
                                if (value == "KBD_click" || value == "")
                                    return true;
                                return false;
                            }
                        }
                    ],
                    values: [
                        { dataField: 'quantity','function': 'sum', text: '소요량' },
                        { dataField: 'price', 'function': 'sum', text: '단가', formatSettings: { prefix: '$', decimalPlaces: 2} },
                        { dataField: 'total', 'function': 'sum', text: '가격', formatSettings: { prefix: '$', decimalPlaces: 2} },
                        { dataField: 'material', 'function': 'count', text: '재고' }
                    ]
                });
            // create a pivot grid
            $('#divPivotGrid').jqxPivotGrid(
                {
                    source: pivotDataSource,
                    treeStyleRows: false, 
                    multipleSelectionEnabled: false
                });
        });
    </script>
</head>
<body class="default"">
    <div id="divPivotGrid" style="height: 800px; width: 1501px; background-color: white;">
    </div>
</body>
</html>
