import 'package:flutter/material.dart';
import 'package:flutter_application/pages/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '小任务大奖励',
      theme: ThemeData(
        fontFamily: 'Comic Sans MS',
        primarySwatch: Colors.indigo,
        primaryColor: Color(0xFF4F46E5),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // 登录类型，父母登录还是孩子登录
  bool _isParentLogin = false;
  //登录加载状态
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.elasticOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFDFCFB),
              Color(0xFFE2D1C3),
            ],
          ),
        ),
        child: Stack(
          children: [
            //装饰性云朵和背景元素
            _buildDecorations(),
            SafeArea(
                child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF4F46E5),
                              Color(0xFFA855F7),
                              Color(0xFFEC4899),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: _bounceAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _bounceAnimation.value),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.pink[300],
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.card_giftcard,
                                        color: Color(0xFFF59E0B),
                                        size: 30,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              '小任务大奖励',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '完成任务，赢取奖励',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //登录表单
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //登录身份选择
                            Text(
                              "登录身份",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!)),
                              //家长和小朋友的身份选择
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        _isParentLogin = true;
                                      }),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                          color: _isParentLogin
                                              ? Color(0xFF4F46E5)
                                              : Colors.grey[100],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          "家长登录",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: _isParentLogin
                                                ? Colors.white
                                                : Colors.grey[700],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () => setState(() {
                                      _isParentLogin = false;
                                    }),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: !_isParentLogin
                                            ? Color(0xFF4F46E5)
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        '小朋友',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: !_isParentLogin
                                              ? Colors.white
                                              : Colors.grey[700],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            //用户名输入
                            Text(
                              '用户名',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF4F46E5),
                                ),
                                hintText: '请输入用户名',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color(0xFF4F46E5), width: 2),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            //密码输入
                            Text(
                              '密码',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF4F46E5),
                                ),
                                hintText: '请输入密码',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color(0xFF4F46E5), width: 2),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            //登录按钮
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // 登录逻辑
                                  _login();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF59E0B),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  '登录',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text.rich(
                                    TextSpan(
                                      text: '还没有账号？',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '去注册',
                                          style: TextStyle(
                                            color: Color(0xFF4F46E5),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(16),
        child: Text(
          '专为6-12岁小朋友设计，家长监督使用',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildDecorations() {
    return Stack(
      children: [
        Positioned(
          top: -40,
          left: -40,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFF4F46E5).withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: -80,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              color: Color(0xFFEC4899).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: 60,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: Color(0xFFF59E0B).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  void _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('请输入用户名'),
      ));
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('请输入密码'),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    //登录，暂模拟
    try {
      final response = await http.post(
        Uri.parse('https://api.example.com/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'userType': _isParentLogin ? 'parent' : 'child',
        }),
      );

      if (response.statusCode == 200) {
        // 登录成功
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('登录成功'),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(userName: _usernameController.text.trim()),
          ),
        );
      } else {
        // 登录失败
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('登录失败: ${response.body}'),
        ));
      }
    } catch (error) {
      // 登录失败
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('登录失败: $error'),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
