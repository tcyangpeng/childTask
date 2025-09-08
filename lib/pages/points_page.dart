import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_application/models/BarData.dart';

class PointsPages extends StatefulWidget {
  const PointsPages({super.key});

  @override
  State<PointsPages> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPages> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('积分'),
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // 阴影方向
            ),
          ],
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            CirclePonintWidget(points: 150),
            SizedBox(height: 10),
            TodayDataWidget(todaypoints: 100, todayCompleteNum: 10),
            SizedBox(
              height: 10,
            ),
            PointTrendWidget()
          ],
        ),
      ),
    );
  }
}

class CirclePonintWidget extends StatefulWidget {
  final int points;
  const CirclePonintWidget({super.key, required this.points});

  @override
  State<CirclePonintWidget> createState() => _CirclePonintWidgetState();
}

class _CirclePonintWidgetState extends State<CirclePonintWidget> {
  var _points = 0;

  @override
  void initState() {
    super.initState();
    _points = widget.points;
  }

  void updatePoints(int points) {
    setState(() {
      _points = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.orange[200],
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.deepOrange,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              _points.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            Text(
              "我的积分",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//今日数据Widget
class TodayDataWidget extends StatefulWidget {
  final int todaypoints;
  final int todayCompleteNum;
  const TodayDataWidget(
      {required this.todaypoints, required this.todayCompleteNum});

  @override
  State<TodayDataWidget> createState() => _TodayDataWidgetState();
}

class _TodayDataWidgetState extends State<TodayDataWidget> {
  var _todaypoints = 0;
  var _todayCompleteNum = 0;

  @override
  void initState() {
    super.initState();
    _todaypoints = widget.todaypoints;
    _todayCompleteNum = widget.todayCompleteNum;
  }

  void updateTodayData(int points, int completeNum) {
    setState(() {
      _todaypoints = points;
      _todayCompleteNum = completeNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // 阴影方向
              ),
            ],
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                Text(
                  _todaypoints.toString(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "今日积分",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )),
        SizedBox(width: 10),
        Expanded(
            child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // 阴影方向
              ),
            ],
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                Text(
                  _todayCompleteNum.toString(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "今日已完成",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class PointTrendWidget extends StatefulWidget {
  final List<charts.Series<BarData, String>> seriesList = [
    charts.Series<BarData, String>(
      id: 'Sales',
      domainFn: (BarData sales, _) => sales.day,
      measureFn: (BarData sales, _) => sales.value,
      colorFn: (BarData sales, _) => charts.ColorUtil.fromDartColor(
        Color.lerp(Colors.lightBlue, Colors.blue, sales.value / 1.0) ??
            Colors.lightBlue,
      ),
      data: [
        BarData('周一', 0.2),
        BarData('周二', 0.4),
        BarData('周三', 0.6),
        BarData('周四', 0.3),
        BarData('周五', 0.8),
      ],
    ),
  ];
  PointTrendWidget({super.key});

  @override
  State<PointTrendWidget> createState() => _PointTrendWidgetState();
}

class _PointTrendWidgetState extends State<PointTrendWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // 阴影方向
          ),
        ],
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: charts.BarChart(
        widget.seriesList,
        animate: true,
        animationDuration: Duration(seconds: 1),
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.auto,
          labelAnchor: charts.BarLabelAnchor.middle,
        ),
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 12,
              color: charts.MaterialPalette.black,
            ),
          ),
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 10,
              color: charts.MaterialPalette.black,
            ),
          ),
        ),
      ),
    );
  }
}
