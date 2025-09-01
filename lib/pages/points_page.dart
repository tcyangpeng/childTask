import 'package:flutter/material.dart';

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
            Text('当前积分：1000'),
          ],
        ),
      ),
    );
  }
}

class CirclePonintWidget extends StatelessWidget {
  final int points;
  const CirclePonintWidget({super.key, required this.points});

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
              "我的积分",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              points.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
