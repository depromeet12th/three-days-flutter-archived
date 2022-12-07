import 'package:flutter/material.dart';
import 'package:three_days/ui/mate/create/mate_create_nickname_page_arguments.dart';

class MateCreateNicknamePage extends StatelessWidget {
  static const routeName = '/mate/create/nickname';

  static void route(BuildContext context, int habitId) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: MateCreateNicknamePageArguments(habitId: habitId),
    );
  }

  final gray800 = Color(0xFF1A1E27);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(73),
          child: AppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getIllustrationWidget(),
              SizedBox(height: 40),
              Text('짝꿍의 별명을 지어주세요.',
                style: TextStyle(
                  color: gray800,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              // TODO: validation
              TextFormField(
                decoration: InputDecoration(
                  hintText: '별명을 입력해주세요.',
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: validation
                    // TODO: go to mate home
                  },
                  child: Text('짝궁 시작하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIllustrationWidget() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE8EBF0),
          borderRadius: BorderRadius.circular(15),
        ),
        width: 140,
        height: 140,
        child: Center(
          child: Text('일러스트'),
        ),
      ),
    );
  }
}
