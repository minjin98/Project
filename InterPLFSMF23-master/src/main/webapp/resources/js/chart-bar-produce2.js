function barChart3(jval){
	var title2 = new Array();
	var value2 = new Array();
	for(i = 3; i<7; i++){
		title2[i-3] = jval[i];
		value2[i-3] = jval[i+8];
		console.log("title2 : "+ title2);
		console.log("value2 : "+ value2);
	}
	console.log("title2 : " +title2);
	console.log("value2 : " +value2);
	drawChart3(title2,value2);	
}
//-------------------------------------------------------------------
function drawChart3(title2, value2){
    var dom = document.getElementById('myBarChart3');
    var myChart = echarts.init(dom, null, {
    width : 330,
    height : 300,
      renderer: 'canvas',
      useDirtyRect: false
    });
    var app = {};
    
    var option;

    option = {
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'shadow'
    }
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  xAxis: [
    {
      type: 'category',
	  data: title2,
      axisTick: {
        alignWithLabel: true
      }
    }
  ],
  yAxis: [
    {
      type: 'value'
    }
  ],
  series: [
    {
      name: 'Direct',
      type: 'bar',
      barWidth: '60%',
      data: value2
    }
  ]
};

    if (option && typeof option === 'object') {
      myChart.setOption(option);
    }

    window.addEventListener('resize', myChart.resize);
}
    
//-------------------------------------------------------------------

function fn_chart4(_procid) {
	
	$.ajax({
		type:"post",
		async:false,  
		url:"http://localhost:8584/SMFPlatform/process4",
		data : { procid : _procid },
		success:function (data,textStatus) {
			var jsonVals = JSON.parse(data);
			// alert(jsonVals); 알림창 뜨기(넘어오는 값 확인할 때 좋을듯)
			barChart3(jsonVals);
		},
		error:function(data,textStatus){
  			alert("에러발생: " + data);
		},
		complete:function(data,textStatus){
  			// alert("수신완료");
		}
	});	 
}
//-------------------------------------------------------------------
