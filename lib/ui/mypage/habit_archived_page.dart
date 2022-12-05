import 'package:flutter/material.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_service.dart';

/// 보관된 습관 목록 (=휴지통)
class HabitArchivedPage extends StatefulWidget {
  HabitArchivedPage({super.key});

  final _habitService = HabitService();

  @override
  State<StatefulWidget> createState() => _HabitArchivedPageState();
}

class _HabitArchivedPageState extends State<HabitArchivedPage> {
  late bool editable;
  late bool needsOnboarding;
  List<Habit> archivedGoals = [];

  @override
  void initState() {
    editable = false;
    needsOnboarding = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  _asyncMethod() async {
    final fetchedGoals = await widget._habitService.getArchivedHabits();
    setState(() {
      archivedGoals.addAll(fetchedGoals);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(73),
          child: AppBar(
            title: Text('습관 보관함'),
            centerTitle: false,
            actions: [
              _resolveActionButton(editable),
            ],
            backgroundColor: Color(0xFFCECECE),
          ),
        ),
        body: Container(
          color: Color(0xFFCECECE),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: _resolveBodyWidget(editable),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resolveActionButton(bool editable) {
    return editable
        ? TextButton(
            onPressed: () {
              setState(() {
                this.editable = !editable;
              });
            },
            child: const Text('나가기'),
          )
        : TextButton(
            onPressed: () {
              setState(() {
                this.editable = !editable;
              });
            },
            child: const Text('편집'),
          );
  }

  Widget _resolveBodyWidget(bool editable) {
    return editable ? _getEditableWidget() : _getReadOnlyWidget();
  }

  Widget _getReadOnlyWidget() {
    return Wrap(
      runSpacing: 16.0,
      children: [
        if (needsOnboarding) _getOnboardWidget(),
        _getReadOnlyArchivedHabit('습관1'),
        _getReadOnlyArchivedHabit('습관2'),
        _getReadOnlyArchivedHabit('습관3'),
        _getReadOnlyArchivedHabit('습관4'),
        _getReadOnlyArchivedHabit('습관5'),
      ],
    );
  }

  Widget _getEditableWidget() {
    return Wrap(
      runSpacing: 16.0,
      children: [
        _getEditableArchivedHabit('습관1'),
        _getEditableArchivedHabit('습관2'),
        _getEditableArchivedHabit('습관3'),
        _getEditableArchivedHabit('습관4'),
        _getEditableArchivedHabit('습관5'),
      ],
    );
  }

  Widget _getOnboardWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF353C49),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 23),
        child: Row(
          children: [
            Text(
              '실행 기록이 있거나 짝꿍과 연결된 습관은\n홈에서 삭제시 보관함으로 이동돼요.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    needsOnboarding = false;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Widget _getReadOnlyArchivedHabit(String title) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_alarm),
                SizedBox(width: 6),
                Text(title),
              ],
            ),
            SizedBox(height: 12),
            Text('2022.10.10 ~2022.10.10'),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('5개'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('42일 실천'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getEditableArchivedHabit(String title) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded,
                color: Colors.white,
                size: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_alarm),
                    SizedBox(width: 6),
                    Text(title),
                  ],
                ),
                SizedBox(height: 12),
                Text('2022.10.10 ~2022.10.10'),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('5개'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('42일 실천'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
