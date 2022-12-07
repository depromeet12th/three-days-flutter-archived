import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:three_days/ui/mate/mate_page.dart';

class MypagePage extends StatefulWidget {
  const MypagePage({super.key});

  @override
  State<StatefulWidget> createState() => _MypagePageState();
}

class _MypagePageState extends State<MypagePage> {
  final TextEditingController _controller = TextEditingController();
  late String nickname;
  late bool switchValue;

  @override
  void initState() {
    nickname = '닉네임';
    // TODO: 알림 설정 값 읽어오기
    switchValue = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(73.0),
          child: AppBar(
            backgroundColor: Color(0xFFF4F6F8),
          ),
        ),
        body: Container(
          color: Color(0xFFF4F6F8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: Column(
              children: [
                /// 닉네임
                _getNicknameWidget(),
                const SizedBox(
                  height: 32,
                ),
                /// 습관 보관함
                _getArchivedHabitWidget(),
                const SizedBox(
                  height: 8,
                ),
                /// 알림 설정
                _getAlarmSwitchWidget(),
                const SizedBox(
                  height: 8,
                ),
                /// 버전 정보, 서비스 이용 약관, 개인정보처리방침
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTapUp: (_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                child: Text('버전 정보'),
                              ),
                              // TODO: 앱 버전
                              content: const Text('1.0.0'),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('확인'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('버전 정보'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapUp: (_) {
                          Navigator.of(context)
                              .pushNamed('/policy/service');
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('이용 약관'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapUp: (_) {
                          Navigator.of(context)
                              .pushNamed('/policy/privacy');
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('개인정보처리방침'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTapUp: (_) {
                      Navigator.of(context).pushNamed('/development');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 20,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text('테스트 편의 기능'),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Text('로그아웃'),
                    ),
                    const SizedBox(width: 39),
                    const Text('|'),
                    const SizedBox(width: 39),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Text('회원탈퇴'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/icon_home.png'),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/icon_statistics.png'),
              ),
              label: '통계',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_outlined),
              label: '짝궁',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/icon_mypage.png'),
              ),
              label: '마이페이지',
            ),
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                Navigator.of(context).pushReplacementNamed('/habit/list');
                break;
              case 1:
                Navigator.of(context).pushReplacementNamed('/statistics');
                break;
              case 2:
                Navigator.of(context).pushReplacementNamed(MatePage.routeName);
                break;
              case 3:
                break;
            }
          },
          currentIndex: 3,
        ),
      ),
    );
  }

  Widget _getNicknameWidget() {
    return Row(
      children: [
        // TODO: 닉네임 읽어와야함
        Text(nickname),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('닉네임 수정'),
                content: TextFormField(
                  controller: _controller,
                  maxLength: 10,
                ),
                actions: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('취소'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nickname = _controller.text;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('저장'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }

  Widget _getArchivedHabitWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        child: Row(
          children: [
            const Text(
              '습관 보관함',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/habit-archived');
              },
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAlarmSwitchWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          child: Row(
            children: [
              const Text('알림 설정'),
              const Spacer(),
              CupertinoSwitch(
                value: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
