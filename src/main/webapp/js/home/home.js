$(function(){
    $.ajax({
        url: path + "/statistics/diary/startDate",
        success: function(data){
            $("#startDate").text("开写日期：" + data);
        }
    });
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    $.ajax({
        url: path + "/statistics/diary/amount",
        success: function(data){
            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '日记数量统计',
                    subtext: '数量'
                },
                tooltip: {},
                legend: {
                    data:['数量']
                },
                xAxis: {
                    data: ["应写","已写","漏写"]
                },
                yAxis: {},
                series: [{
                    name: '销量',
                    type: 'bar',
                    data: [data['total'], data['real_total'], data['miss']]
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        },
        error: function(){
            alert('出错了')
        }
    });
});