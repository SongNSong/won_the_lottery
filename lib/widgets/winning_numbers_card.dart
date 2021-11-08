import 'package:flutter/material.dart';

class WinningNumbersCard extends StatefulWidget {
  String selectedGameRound;

  WinningNumbersCard({required this.selectedGameRound});

  @override
  _WinningNumbersCardState createState() => _WinningNumbersCardState();
}

class _WinningNumbersCardState extends State<WinningNumbersCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [],
      )
    );
  }
}
