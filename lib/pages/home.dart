import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _todayPints = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今天'),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Text(
            "加油，小小冒险家",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 16),
          _buildPointsCard(),
          SizedBox(height: 8),
          _buildTasKTitle(),
          SizedBox(height: 8),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("今日得分",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Text(
            "$_todayPints 分",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTasKTitle() {
    return Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "今日任务",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ));
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('任务 $index'),
          trailing: Icon(Icons.arrow_forward),
        );
      },
    );
  }
  // Widget _buildBottomBar() {
  //   return BottomNavigationBar(
  //     items: const <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: '首页',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.store),
  //         label: '积分',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.person),
  //         label: '我的',
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     selectedItemColor: Colors.lightBlue,
  //     unselectedItemColor: Colors.grey,
  //     type: BottomNavigationBarType.fixed,
  //     iconSize: 24,
  //     onTap: _onBottomBarTapped,
  //   );
  // }
}
