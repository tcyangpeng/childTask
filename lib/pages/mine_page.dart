import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class MinePage extends StatefulWidget {
  final String name;
  const MinePage({super.key, required this.name});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var _name = "";
  String _authStatus = '设备不支持身份认证';
  bool _isAuthenticating = false;
  @override
  void initState() {
    super.initState();
    _name = widget.name;
  }

  void updateName(String name) {
    setState(() {
      _name = name;
    });
  }

  //检查设备是否支持生物识别并进行指纹识别
  Future<void> checkBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticate = await auth.canCheckBiometrics;
    if (!canAuthenticate) {
      setState(() {
        _authStatus = '设备不支持生物识别';
      });
      return;
    }
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      setState(() {
        _authStatus = '未检测到可用生物识别模块';
      });
      return;
    }
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      // 设备支持指纹识别
      final bool authenticated = await auth.authenticate(
        localizedReason: '请使用指纹解锁',
        options: const AuthenticationOptions(
            useErrorDialogs: true, biometricOnly: true, stickyAuth: true),
      );
      if (authenticated) {
        // 指纹识别成功
        setState(() {
          _authStatus = '指纹识别成功';
        });
        _onAuthenticationSuccess();
      } else {
        // 指纹识别失败
        setState(() {
          _authStatus = '指纹识别失败';
        });
      }
    }
  }

  /// 指纹识别成功跳转
  void _onAuthenticationSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('指纹识别成功'),
            content: Text('你已成功解锁，即将跳转至管理页面'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/task_manage');
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // 需要导入 material 库才能使用 Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // 阴影方向：向下
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "管理任务",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
