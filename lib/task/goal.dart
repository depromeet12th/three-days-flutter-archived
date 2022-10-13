import 'package:flutter/material.dart';

class Goal extends StatelessWidget {
  const Goal({
    super.key,
    required this.title,
    required this.days,
  });

  final String title;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromRGBO(0xF9, 0xFA, 0xFB, 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color.fromRGBO(0x1A, 0x1F, 0x27, 1.0),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '짝심 연속 $days일째',
                      style: const TextStyle(
                        color: Color.fromRGBO(0x8D, 0x95, 0xA0, 1.0),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showModalBottomSheet(context);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color.fromRGBO(0xA6, 0xA6, 0xA6, 1.0),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('images/clap.png'),
                Opacity(
                  opacity: days < 2 ? 0.3 : 1.0,
                  child: Image.asset('images/clap.png'),
                ),
                Opacity(
                  opacity: days < 3 ? 0.3 : 1.0,
                  child: Image.asset('images/clap.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTapUp: (_) {
                    Navigator.of(context).pop();
                  },
                  child: const Text('삭제하기'),
                ),
                GestureDetector(
                  onTapUp: (_) {
                    Navigator.of(context).pop();
                  },
                  child: const Text('수정하기'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
