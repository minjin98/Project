
function planhalfchart(jval) {
	  var prodName = new Array();
	  var prodQty = new Array();
	
	  for (i = 0; i < jval.length; i++) {
	    prodName.push(jval[i][0]);
	    prodQty.push(jval[i][1]);
	  }
	  console.log("prodName = "+prodName);
	  console.log("prodQty = "+prodQty);
	  drawplanhalfchart(prodName, prodQty);	
}
//-----------------------------------------------------
function drawplanhalfchart(prodName, prodQty){
    var dom = document.getElementById('PlanHalfChart');
    var myChart = echarts.init(dom, null, {
      width: 740,
      height: 390,
      renderer: 'canvas',
      useDirtyRect: false
    });

    var option;
    var totalQty = 0; // prodQty 총합

	for (let i = 0; i < prodName.length; i++) {
	   totalQty += prodQty[i];
	}
	console.log("totalQty = "+totalQty);
	
    option = {
      tooltip: {
        trigger: 'item'
      },
      legend: {
        top: '5%',
        left: 'center',
        // doesn't perfectly work with our tricks, disable it
        selectedMode: false
      },
      series: [
        {
          name: 'Access From',
          type: 'pie',
          radius: ['40%', '80%'],
          center: ['50%', '70%'],
          // adjust the start angle
          startAngle: 180,
          label: {
            show: true,
            formatter: function(param) {
              // correct the percentage
              return param.name + ' (' + param.percent * 2 + '%)';
            }
          },
          data: (function() {
			  var chartArray = [];
			  for (let i = 0; i < prodName.length; i++) {
			    chartArray.push({ value: prodQty[i], name: prodName[i] });
			  }
			  chartArray.push({
			    // half-circle (non-display)
			    value: totalQty, 
			    itemStyle: {
			      color: 'none',
			      decal: {
			        symbol: 'none'
			      }
			    },
			    label: {
			      show: false
			    }
			  });
			  return chartArray;
			})()

        }
      ]
    };
    
    //option && myChart.setOption(option);
    if (option && typeof option === 'object') {
      myChart.setOption(option);
    }

    window.addEventListener('resize', myChart.resize);
}

//------------------------------------------------
function fn_planhalfchart() {
	
	$.ajax({
		type:"post",
		async:false,  
		url:"http://localhost:8584/SMFPlatform/statistics/planhalfchart.do",
		success:function (data,textStatus) {
			var jsonVals = JSON.parse(data);
			// alert(jsonVals);
			planhalfchart(jsonVals);
		},
		error:function(data,textStatus){
  			alert("에러발생: " + data);
		},
		complete:function(data,textStatus){
  			// alert("수신완료");
		}
	});	 
}