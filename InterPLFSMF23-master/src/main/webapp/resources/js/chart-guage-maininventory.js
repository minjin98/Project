var chartDom = document.getElementById('planprogress');
var myChart = echarts.init(chartDom);
var option;
var planidlist = [];
var planid;
var idindex = 0;
var idcount;

(function planidinit(){
	$.ajax({
		type:"post",
		async:false,  
		url:"http://localhost:8584/SMFPlatform/statistics/planidarray.json",
		success:function (data,textStatus) {
			planidlist = JSON.parse(data);
			idcount = planidlist.length;
		},
		error:function(data,textStatus){
  			alert("에러발생: " + data);
		},
		complete:function(data,textStatus){
  			// alert("수신완료");
		}
	});	 
})();

function idrotation(){
	if(planid == planidlist[idcount-1]){
		planid = planidlist[0];
		idindex = 1;
	}else{
		planid = planidlist[idindex];
		idindex++;
	}
}

const gaugeData = [
  {
    value: 0,
    name: 'Total',
    title: {
      offsetCenter: ['0%', '-30%']
    },
    detail: {
      valueAnimation: true,
      offsetCenter: ['0%', '-20%']
    }
  },
  {
    value: 0,
    name: 'QC Passed',
    title: {
      offsetCenter: ['0%', '0%']
    },
    detail: {
      valueAnimation: true,
      offsetCenter: ['0%', '10%']
    }
  },
  {
    value: 0,
    name: 'QC Fail',
    title: {
      offsetCenter: ['0%', '30%']
    },
    detail: {
      valueAnimation: true,
      offsetCenter: ['0%', '40%']
    }
  }
];

option = {
  series: [
    {
      type: 'gauge',
      startAngle: 90,
      endAngle: -270,
      pointer: {
        show: false
      },
      progress: {
        show: true,
        overlap: false,
        roundCap: true,
        clip: false,
        itemStyle: {
          borderWidth: 1,
          borderColor: '#464646'
        }
      },
      axisLine: {
        lineStyle: {
          width: 40
        }
      },
      splitLine: {
        show: false,
        distance: 0,
        length: 10
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        show: false,
        distance: 50
      },
      data: gaugeData,
      title: {
        fontSize: 14
      },
      detail: {
        width: 50,
        height: 14,
        fontSize: 12,
        color: 'inherit',
        borderColor: 'inherit',
        borderRadius: 20,
        borderWidth: 0.5,
        formatter: '{value}%'
      }
    }
  ]
};

var percentage = [];
function planprogresspercent(){
	$.ajax({
		type:"post",
		async:false,
		data: {planno : planid},  
		url:"http://localhost:8584/SMFPlatform/statistics/planpercentage.json",
		success:function (data,textStatus) {
			percentage = JSON.parse(data);
		},
		error:function(data,textStatus){
  			alert("에러발생: " + data);
		},
		complete:function(data,textStatus){
  			// alert("수신완료");
		}
	});	 
}


setInterval(function () {
   	$("#pertitle").text(planid);
	idrotation();
	planprogresspercent();
  gaugeData[0].value = percentage[0];
  gaugeData[1].value = percentage[1];
  gaugeData[2].value = percentage[2];
  myChart.setOption({
    series: [
      {
        data: gaugeData,
        pointer: {
          show: false
        }
      }
    ]
  });
}, 3000);

option && myChart.setOption(option);