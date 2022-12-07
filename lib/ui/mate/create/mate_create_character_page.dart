import 'package:flutter/material.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/ui/mate/create/mate_create_character_page_arguments.dart';
import 'package:three_days/ui/mate/create/mate_create_nickname_page.dart';

class MateCreateCharacterPage extends StatefulWidget {
  static const routeName = '/mate/create/character';

  static void route(BuildContext context, int habitId) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: MateCreateCharacterPageArguments(habitId: habitId),
    );
  }

  @override
  State<StatefulWidget> createState() => _MateCreateCharacterPageState();
}

class _MateCreateCharacterPageState extends State<MateCreateCharacterPage> {
  final habitRepository = HabitRepository();

  final gray100 = Color(0xFFF4F6F8);
  final gray500 = Color(0xFF8E95A3);
  final gray800 = Color(0xFF1A1E27);



  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as MateCreateCharacterPageArguments;
    final habitId = arguments.habitId;
    print('habitId: $habitId');
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
              Text(
                '어떤 성격의 짝꿍을 원하세요?',
                style: TextStyle(
                  color: gray800,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  _getMateSelector(
                    title: '채찍 짝꿍',
                    description: '엄격한 잔소리가 필요해요!',
                  ),
                  SizedBox(height: 16),
                  _getMateSelector(
                    title: '당근 짝꿍',
                    description: '따뜻한 응원이 필요해요!',
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    MateCreateNicknamePage.route(context, habitId);
                  },
                  child: Text('다음 (2/3)'),
                ),
              ),
              SizedBox(height: 20),
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

  Widget _getMateSelector({
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: gray100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 25,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: gray800,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: gray500,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 110,
              width: 110,
              color: Color(0xFFCCD2DC),
            ),
          ],
        ),
      ),
    );
  }
}
