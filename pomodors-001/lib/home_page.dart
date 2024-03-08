import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.workTimer});
  final int workTimer;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 변수의 late 초기화
  /// flutter(dart)에서는 변수를 반드시 초기화 해야하는 원칙이 있다
  /// 즉 변수를 선언만 해서는 문법상 오류가 발생한다.
  /// 이 코드에서 _timer 는 이후 if() 명령문에서
  /// 조건에 따라 초기화를 늦게 시킬예정이다.
  /// 처음에 변수를 선언할때 초기값을 지정하지 않는다.
  /// 이 코드는 lutter(dart)의 변수 초기화 원칙에 위배된다.
  /// 이럴때 lete 라는 키워드를 부착하여 조금 있다가 아래 코드에서
  /// 변수를 꼭!! 초기화 할 테니 일단 보류해달라 라는 의미
  ///
  late Timer _timer;

  /// main 으로부터 전달받은 workTimer
  /// workTimer 는 setting_page 에서 일할 시간을 변경하면 그 값을 전달해주는
  /// 전달자 state 이다.
  /// 즉 setting_page 에서 일할시간을 변경하면 timer 의 전체시간이
  /// 변경되어야 한다.
  ///
  /// 일반적인 코드 형식이라면
  /// int_count = workTimer 이라고 사용한다
  ///
  /// 하지만 Flutter 에 State<> 에서는
  /// int _count = widget.workTimer 라고 사용을 해야 한다.
  ///
  /// 문제는 State<> 클래스 영역에서는 Widget 을 사용할 수 없다.
  /// 따라서 _count 변수에서 workTimer 값을 할당하기 위해서는
  /// 별도의 방법을 사용해야 한다
  ///
  /// Flutter 의 State<> 클래스에는 initState() 라는 함수를 사용할수 있다.
  /// 이 함수는 _count 변수에 widget.workTimer 값을 할당하는
  /// 코드를 사용해야 한다.
  int _count = 5;
  bool _timerRun = false;

  /// State<> class 가 mount 될때 자동으로 실행되는 함수
  @override
  void initState() {
    super.initState();
    _count = widget.workTimer;
  }

  void _onPressed() {
    setState(() {
      _timerRun = !_timerRun;
    });
    if (_timerRun) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() => _count--);
          if (_count < 1) {
            _count = widget.workTimer;
            _timerRun = false;
            timer.cancel();
          }
        },
      );
    } else {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TextButton(
        onPressed: _onPressed,
        child: Center(
          child: Text(
            "$_count",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
