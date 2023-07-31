function invenbarChart(jval){
	var title = new Array();
	var value = new Array();

	for(i = 0, j = 0; j<jval.length-1; i++,j+=2){
		title[i] = jval[j];
		value[i] = jval[j+1];
	}

	drawinvenChart(title, value);	
}
//-------------------------------------------------------------------
function drawinvenChart(title, value){
    var dom = document.getElementById('inventoryBarChart');
    var myChart = echarts.init(dom, null, {
		  width : 740,
		  height : 390,
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
		  data: title,
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
	      data: value
	    }
  	]};
    if (option && typeof option === 'object') {
      myChart.setOption(option);
    }
    window.addEventListener('resize', myChart.resize);
}
    
//-------------------------------------------------------------------

function fn_invenchart() {
	
	$.ajax({
		type:"post",
		async:false,  
		url:"http://localhost:8584/SMFPlatform/statistics/inventorychart.do",
		success:function (data,textStatus) {
			var jsonVals = JSON.parse(data);
			// alert(jsonVals);
			invenbarChart(jsonVals);
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
