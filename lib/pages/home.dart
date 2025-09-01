import 'package:flutter/material.dart';
import 'package:flutter_application/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _todayPints = 0;
  List<Task> _tasks = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = [
        Task(
          title: '完成完成数学作业',
          description: '这是一个任务',
          points: 10,
          taskStatus: TaskStatus.pending,
        ),
        Task(
          title: '阅读30分钟',
          description: '这是一个任务',
          points: 20,
          taskStatus: TaskStatus.pending,
        ),
        Task(
          title: '整理房间',
          description: '这是一个任务',
          points: 30,
          taskStatus: TaskStatus.pending,
        ),
        Task(
          title: '洗脸刷牙',
          description: '这是一个任务',
          points: 40,
          taskStatus: TaskStatus.pending,
        ),
        Task(
          title: '帮忙打扫卫生',
          description: '这是一个任务',
          points: 50,
          taskStatus: TaskStatus.pending,
        ),
      ];
    });
  }

//完成任务
  void _onCompleteTask(int index) {
    setState(() {
      if (_tasks[index].taskStatus == TaskStatus.completed) {
        _tasks[index] =
            _tasks[index].copyWith(taskStatus: TaskStatus.completed);
        _todayPints += _tasks[index].points;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今天'),
        elevation: 1,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
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
          Expanded(child: _buildTaskList(_tasks)),
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

  Widget _buildTaskList(List<Task> tasks) {
    return ListView.builder(
      itemCount: _tasks.length,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return CustomItem(
          item: _tasks[index],
          onComplete: () => _onCompleteTask(index),
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

class CustomItem extends StatelessWidget {
  final Task item;
  final VoidCallback onComplete;
  const CustomItem({super.key, required this.item, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final isPending = item.taskStatus == TaskStatus.pending;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.task,
            color: Colors.lightBlue,
            size: 24,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "$item.points",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 32,
            child: ElevatedButton(
                onPressed: isPending ? onComplete : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPending ? Colors.lightBlue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(item.taskStatusString,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}
