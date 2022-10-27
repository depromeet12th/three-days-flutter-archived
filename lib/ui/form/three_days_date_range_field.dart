import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO: 시작, 종료 사이 선 긋기
/// 시작날짜, 종료날짜 선택하는 위젯
class ThreeDaysDateRangeField extends StatelessWidget {
  const ThreeDaysDateRangeField({
    super.key,
    required this.visible,
    this.startDate,
    this.endDate,
  });

  final bool visible;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              color: Color.fromRGBO(0xF9, 0xFA, 0xFB, 1.0),
            ),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    '시작',
                    style: TextStyle(
                      color: Color.fromRGBO(0x36, 0x36, 0x36, 1.0),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _getFormattedDate(startDate),
                    style: const TextStyle(
                      color: Color.fromRGBO(0x75, 0x75, 0x75, 1.0),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10.0),
              ),
              color: Color.fromRGBO(0xF9, 0xFa, 0xFB, 1.0),
            ),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    '종료',
                    style: TextStyle(
                      color: Color.fromRGBO(0x36, 0x36, 0x36, 1.0),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _getFormattedDate(endDate),
                    style: const TextStyle(
                      color: Color.fromRGBO(0x75, 0x75, 0x75, 1.0),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  String _getFormattedDate(DateTime? dateTime) {
    return DateFormat('yyyy. MM. dd.').format(dateTime ?? DateTime.now());
  }
}
