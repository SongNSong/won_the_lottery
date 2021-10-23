import 'package:flutter/material.dart';

class LotteryRoundWidget extends StatelessWidget {
  const LotteryRoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text('로또 6/45 제 986회'),
        ]),
        Text('2021-10-23 20:45 추첨')
      ],
    ));
  }
}
