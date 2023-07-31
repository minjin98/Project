function barChart4(jval){
	var title3 = jval[7];
	var value3 = jval[15];
	console.log("title3 : " +title3);
	console.log("value3 : " +value3);
	drawChart4(title3,value3);	
}
//-------------------------------------------------------------------
function drawChart4(title3, value3){
    var dom = document.getElementById('myBarChart4');
    var myChart = echarts.init(dom, null, {
    width : 100,
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
	  data: [title3],
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
      data: [value3]
    }
  ]
};

    if (option && typeof option === 'object') {
      myChart.setOption(option);
    }

    window.addEventListener('resize', myChart.resize);
}
    
//-------------------------------------------------------------------

function fn_chart5(_procid) {
	
	$.ajax({
		type:"post",
		async:false,  
		url:"http://localhost:8584/SMFPlatform/process5",
		data : { procid : _procid },
		success:function (data,textStatus) {
			var jsonVals = JSON.parse(data);
			// alert(jsonVals); 알림창 뜨기(넘어오는 값 확인할 때 좋을듯)
			barChart4(jsonVals);
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
