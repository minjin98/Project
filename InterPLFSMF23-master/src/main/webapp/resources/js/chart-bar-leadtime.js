Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// 1번째 데이터 부터 호출 (0번째 데이터는 leadtime으로 고정값)
 function barChart(vals) {
	taskChart(vals, 1);
 }
 //-------------------------------------------------------------------
 function taskChart(vals, cnt) {
 // cnt가 vals의 길이를 넘어가면 종료
 	if(cnt >= vals.length) {
 		return;
 	}
 	// v0에 vals[0] (leadtime) 값을 삽입
 	var v0 = vals[0];
 	
 	// v1은 vals[cnt] 값(100개의 데이터를 순서대로 삽입)
	var v1 = vals[cnt];
	
	// drawChart 호출
	drawChart(v0, v1);
	
 	//console.log("taskChart: cnt=", cnt, v0, ', ', v1);
	// 1초에 한번씩 taskChart를 재귀호출 후 cnt 값 +1  	
	setTimeout(taskChart, 1000, vals, ++cnt);
 }
 //-------------------------------------------------------------------
 function drawChart(v0, v1) {
	var dom = document.getElementById('myBarChart');
	var myChart = echarts.init(dom, null, {
	  width : 700,
	  height : 200,
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
	legend: {
	data: ['leadtime', 'cycletime']
	},
	grid: {
	left: '3%',
	right: '4%',
	bottom: '3%',
	containLabel: true
	},
	xAxis: [
	{
	  type: 'value'
	}
	],
	yAxis: [
	{
	  type: 'category',
	  axisTick: {
	    show: false
	  },
	  data: ['Time']
	}
	],
	series: [
	{
	  name: 'leadtime',
	  type: 'bar',
	  label: {
	    show: true,
	    position: 'inside'
	  },
	  emphasis: {
	    focus: 'series'
	  },
	  data: [v0]
	},
	{
	  name: 'cycletime',
	  type: 'bar',
	  stack: 'Total',
	  label: {
	    show: true
	  },
	  emphasis: {
	    focus: 'series'
	  },
	  data: [v1]
	},
	
	]
	};
	
	if (option && typeof option === 'object') {
	  myChart.setOption(option);
	}
	
	window.addEventListener('resize', myChart.resize);
}

//-------------------------------------------------------------------
function fn_chart2(_procid) {
	
	$.ajax({
		type:"post",
		async:false,  
		url:"http://localhost:8584/SMFPlatform/process2",
		data : { procid : _procid },
		success:function (data,textStatus) {
			var jsonVals = JSON.parse(data);
			// alert(jsonVals); //알림창 뜨기(넘어오는 값 확인할 때 좋을듯)
			barChart(jsonVals);
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
var autoChart = null;
function fn_start(procid) {
	//alert("fn_start: " + procid);
	
	// 처음 1호출
	fn_chart2(procid);
	// 100초에 한번씩 fn_chart2 호출
	// fn_chart2는 100개의 데이터를 가지고 있기 때문에
	// 1초에 1개의 데이터를 출력하기 위해 100초가 필요
	autoChart = setInterval(fn_chart2, 100000, procid);
}