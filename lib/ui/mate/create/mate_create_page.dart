import 'package:flutter/material.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/ui/mate/create/mate_create_character_page.dart';

class MateCreatePage extends StatefulWidget {
  static const routeName = '/mate/create';

  static void route(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State createState() => _MateCreatePageState();
}

class _MateCreatePageState extends State<MateCreatePage> {
  final habitRepository = HabitRepository();
  final gray800 = Color(0xFF1A1E27);

  int? selectedHabitId = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(73),
          child: AppBar(),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getIllustrationWidget(),
                  SizedBox(height: 40),
                  Text(
                    '어떤 습관을 연결하시겠어요?',
                    style: TextStyle(
                      color: gray800,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: FutureBuilder(
                            future: habitRepository.findAll(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              final habits = snapshot.data!;
                              return Wrap(
                                runSpacing: 8,
                                children: habits
                                    .map((e) => _getHabitItem(context, e))
                                    .toList(),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white.withOpacity(0.0), Colors.white],
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedHabitId != null) {
                      MateCreateCharacterPage.route(context, selectedHabitId!);
                    }
                  },
                  child: Text('다음'),
                ),
              ),
            ),
          ],
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

  Widget _getHabitItem(BuildContext context, Habit habit) {
    bool selected = selectedHabitId == habit.habitId;

    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          if (selected && selectedHabitId == habit.habitId) {
            selectedHabitId = null;
          } else {
            selectedHabitId = habit.habitId;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Color(0xFFC4CAD4) : Color(0xFFF4F6F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('🍊'),
              Text(
                habit.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
