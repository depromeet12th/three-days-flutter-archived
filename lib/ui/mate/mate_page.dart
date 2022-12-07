import 'package:flutter/material.dart';
import 'package:three_days/domain/mate/mate.dart';
import 'package:three_days/domain/mate/mate_repository.dart';
import 'package:three_days/ui/mate/create/mate_create_page.dart';
import 'package:three_days/ui/mate/onboarding/mate_onboarding_page.dart';

class MatePage extends StatelessWidget {
  MatePage({super.key});

  static const routeName = '/mate';

  static void route(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  // TODO: DI
  final mateRepository = MateRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(73),
          child: AppBar(
            title: Text('짝궁'),
          ),
        ),
        body: FutureBuilder<Mate?>(
          future: mateRepository.findOne(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Text('loading');
            }
            if (snapshot.hasError) {
              return Text('error');
            }
            if (snapshot.data == null) {
              mateRepository.needsToDisplayOnboarding().then((value) {
                if (value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showMateOnboardingSheet(context);
                  });
                }
              });
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('일러스트 영역'),
                  Text('혼자서는 힘드셨죠?\n짝꿍이 도와드릴게요.'),
                  ElevatedButton(
                    onPressed: () {
                      MateCreatePage.route(context);
                    },
                    child: Text('짝꿍과 함께하기'),
                  ),
                ],
              );
            }
            return Text('mate 있음');
          },
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
                break;
              case 3:
                Navigator.of(context).pushReplacementNamed('/mypage');
                break;
            }
          },
          currentIndex: 2,
        ),
      ),
    );
  }

  void _showMateOnboardingSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return MateOnboardingPage();
      },
    );
  }
}
