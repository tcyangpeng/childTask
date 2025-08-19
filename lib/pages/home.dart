import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //当前tab
  int _currentIndex = 0;
  //当前积分
  int _points = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4F46E5),
              Color(0xFFA855F7),
              Color(0xFFEC4899),
            ],
          ),
        ),
        child: _currentIndex == 0 ? _buildHomePage() : _buildOtherPage(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      //不自动显示返回按钮
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4F46E5),
              Color(0xFFA855F7),
              Color(0xFFEC4899),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          SizedBox(
            width: 8,
          ),
          Text("小任务，大奖励",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 16,
              ))
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                Icons.diamond,
                color: Colors.yellow,
                size: 16,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "$_points",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Color(0xFF4F46E5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHomePage() {
    return Container();
  }

  Widget _buildOtherPage() {
    return Container();
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt),
          label: '任务',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: '积分',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '我的',
        ),
      ],
      selectedItemColor: Color(0xFF4F46E5),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 8,
    );
  }
}
