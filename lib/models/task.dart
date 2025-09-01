class Task {
  final String title;
  final String description;
  final int points;
  final TaskStatus taskStatus;
  final TaskDifficulty? taskDifficulty;

  Task({
    required this.title,
    required this.description,
    required this.points,
    required this.taskStatus,
    this.taskDifficulty,
  });

  // 工厂构造函数，从 JSON 数据创建 Task 对象
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      points: json['points'],
      taskStatus:
          TaskStatus.values.firstWhere((e) => e.name == json['taskStatus']),
      taskDifficulty: TaskDifficulty.values
          .firstWhere((e) => e.name == json['taskDifficulty']),
    );
  }

  // 将 Task 对象转换为 JSON 数据
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'points': points,
      'taskStatus': taskStatus.name,
      'taskDifficulty': taskDifficulty?.name,
    };
  }

  // 任务状态的字符串表示
  String get taskStatusString {
    switch (taskStatus) {
      case TaskStatus.pending:
        return '即将开始';
      case TaskStatus.inProgress:
        return '进行中';
      case TaskStatus.completed:
        return '已完成';
      case TaskStatus.failed:
        return '已失败';
      default:
        return '';
    }
  }

  // 任务难易程度的字符串表示
  String get taskDifficultyString {
    switch (taskDifficulty) {
      case TaskDifficulty.easy:
        return '简单';
      case TaskDifficulty.medium:
        return '中等';
      case TaskDifficulty.hard:
        return '困难';
      default:
        return '';
    }
  }

  Task copyWith({
    String? title,
    String? description,
    int? points,
    TaskStatus? taskStatus,
    TaskDifficulty? taskDifficulty,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      points: points ?? this.points,
      taskStatus: taskStatus ?? this.taskStatus,
      taskDifficulty: taskDifficulty ?? this.taskDifficulty,
    );
  }
}

//任务状态
enum TaskStatus {
  pending, //即将开始
  inProgress,
  completed,
  failed,
}

//任务难易程度
enum TaskDifficulty {
  easy,
  medium,
  hard,
}
