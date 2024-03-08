import 'package:flutter/material.dart';
import 'package:timer/dash_page.dart';
import 'package:timer/home_page.dart';
import 'package:timer/setting_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 1;
  int workTimer = 20;

  void onChangeSetting(String value) {
    if (value.length > 3) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }

    /// setting_page 의 일할시간 TextField 의 onChange event 핸들러로부터
    /// 전달된 문자열을 정수형으로 변환하여 workTimer state 에 할당하기

    // state 변수에 값을 할당하는 일반적인 방법
    setState(() => workTimer = int.parse(value));

    // state 변수에 값을 할당하기 전에 여러 연산을 수행하야 하는 경우
    // 연산 절차 코드를 실행하여 state 변수에 값을 할당하고
    // setState() 함수는 Blank 함수를 실행하는 방법으로 구현한다
    workTimer = int.parse(value);
    setState(() => {});
  }

  /// flutter dart에서 변수를 선언할때 final, const 키워드가 있으면
  /// 변수의 type 을 명시하지 않아도 된다
  /// 단, 이때 반드시 값이 초기화 되어야 한다
  ///
  /// PageController type 의 변수 선언
  /// HTML tag 에 id 를 적용하는 것처럼 flutter 에서 화면에 표시되는
  /// component 에 id 를 부착하기 위해 선언하는 변수

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/tomato.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) => setState(() => _pageIndex = value),
          children: [
            HomePage(
              workTimer: workTimer,
            ),
            const DashPage(),
            SettingPage(
              onChange: onChangeSetting,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (value) {
            _pageIndex = value;
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            setState(() => {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_sharp),
              label: "Dashbord",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "setting",
            ),
          ],
        ),
      ),
    );
  }
}
