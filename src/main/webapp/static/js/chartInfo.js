$(function () {
    // $.jqplot('chart', [[1, 2, 3, 4, 5, 6, 7, 8, 9]]);
    init_jqplot();
    init_event();

    function init_event() {
        $("#chartInfoButton").addClass("color-info");
    }
    function init_jqplot() {
        // Some simple loops to build up data arrays.
        var cosPoints = [];
        // 获取cos(i)的值，i的间隔为0.4
        for (var i=0; i<2*Math.PI; i+=0.4){
            cosPoints.push([i, Math.cos(i)]);
        }

        var sinPoints = [];
        // 获取sin(i)的值，i的间隔为0.4
        for (var i=0; i<2*Math.PI; i+=0.4){
            sinPoints.push([i, 2*Math.sin(i-.8)]);
        }

        var powPoints1 = [];
        // 获取2.5+(i/4)^2的值，i的间隔为0.4
        for (var i=0; i<2*Math.PI; i+=0.4) {
            powPoints1.push([i, 2.5 + Math.pow(i/4, 2)]);
        }

        var powPoints2 = [];
        // 获取-2.5-(i/4)^2的值，i的间隔为0.4
        for (var i=0; i<2*Math.PI; i+=0.4) {
            powPoints2.push([i, -2.5 - Math.pow(i/4, 2)]);
        }

        var plot3 = $.jqplot('chart', [cosPoints, sinPoints, powPoints1, powPoints2],
            {
                title:'Line Style Options',
                // Series options are specified as an array of objects, one object
                // for each series.
                // 配置要绘制的线的参数
                series:[
                    {
                        // Change our line width and use a diamond shaped marker.
                        // 设置线宽为2px
                        lineWidth:2,
                        // 设置点的标记为空心菱形
                        markerOptions: { style:'dimaond' }
                    },
                    {
                        // Don't show a line, just show markers.
                        // Make the markers 7 pixels with an 'x' style
                        // 设置不显示线
                        showLine:false,
                        // 设置点用符号x表示，大小为7px
                        markerOptions: { size: 7, style:"x" }
                    },
                    {
                        // Use (open) circlular markers.
                        // 设置点的标记为空心圆
                        markerOptions: { style:"circle" }
                    },
                    {
                        // Use a thicker, 5 pixel line and 10 pixel
                        // filled square markers.
                        // 设置线宽为5px
                        lineWidth:5,
                        // 设置点的标记为实心正方形
                        markerOptions: { style:"filledSquare", size:10 }
                    }
                ]
            }
        );
    }
})