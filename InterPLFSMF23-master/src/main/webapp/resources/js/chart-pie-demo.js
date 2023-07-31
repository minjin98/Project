// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Pie Chart Example
/*
// vals 값은 test.jsp에 밑에서 값을 받아옴
 */
function drawPieChart(vals) {
	var ctx = document.getElementById("myPieChart");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
	    labels: ["양품", "불량품"],
	    datasets: [{
	      data: vals,
	      backgroundColor: ['#007bff', '#dc3545'],
	    }],
	  },
	});
}