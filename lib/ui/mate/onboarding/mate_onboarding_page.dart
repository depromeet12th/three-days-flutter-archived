import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:three_days/ui/mate/onboarding/mate_onboarding_status.dart';

class MateOnboardingPage extends StatefulWidget {
  const MateOnboardingPage({super.key});

  @override
  State<StatefulWidget> createState() => _MateOnboardingPageState();
}

class _MateOnboardingPageState extends State<MateOnboardingPage> {
  late MateOnboardingStatus mateOnboardingStatus;

  @override
  void initState() {
    super.initState();
    mateOnboardingStatus = MateOnboardingStatus.first;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          IconButton(
            onPressed: () {
              setMateOnboardingAsRead();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
            ),
          ),
          _resolveWidget(),
        ],
      ),
    );
  }

  Widget _resolveWidget() {
    switch (mateOnboardingStatus) {
      case MateOnboardingStatus.first:
        return _getContent(
          status: mateOnboardingStatus,
          title: '짝꿍과 함께하는 66일 챌린지',
          description: '습관이 형성되는 최소의 시간 66일',
          illustration: '일러스트 영역',
          onActionButtonPressed: () {
            setState(() {
              mateOnboardingStatus = MateOnboardingStatus.second;
            });
          },
        );
      case MateOnboardingStatus.second:
        return _getContent(
          status: mateOnboardingStatus,
          title: '하나의 습관에만 집중',
          description: '가장 실천하고싶은 습관에 짝꿍을 연결해보세요!',
          illustration: '일러스트 영역',
          onActionButtonPressed: () {
            setState(() {
              mateOnboardingStatus = MateOnboardingStatus.third;
            });
          }
        );
      case MateOnboardingStatus.third:
        return _getContent(
            status: mateOnboardingStatus,
            title: '박수를 먹고자라는 짝꿍',
            description: '습관 실천을 통해 얻은 박수로 짝꿍이 레벨업해요!',
            illustration: '일러스트 영역',
            onActionButtonPressed: () {
              setState(() {
                setMateOnboardingAsRead();
              });
            },
          actionButtonTitle: '짝궁과 함께하기',
        );
    }
  }

  Widget _getContent({
    required MateOnboardingStatus status,
    required String title,
    required String description,
    required String illustration,
    required VoidCallback onActionButtonPressed,
    String actionButtonTitle = '다음',
  }) {
    return Column(
      children: [
        Text(title),
        Text(description),
        Container(
          child: Center(
            child: Text(illustration),
          ),
        ),
        DotsIndicator(
          dotsCount: 3,
          position: status.index.toDouble(),
          axis: Axis.horizontal,
        ),
        ElevatedButton(
          onPressed: onActionButtonPressed,
          child: Text(actionButtonTitle),
        ),
      ],
    );
  }

  void setMateOnboardingAsRead() {
    // TODO: implementation
  }
}
