import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/utilities/game_round.dart';

class WinningNumbersCard extends StatefulWidget {
  const WinningNumbersCard({Key? key}) : super(key: key);


  @override
  _WinningNumbersCardState createState() => _WinningNumbersCardState();
}

class _WinningNumbersCardState extends State<WinningNumbersCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameRound>(
      builder: (_, gameRound, child) {
        return Card(
          child: Column(
              children: [
                const Text('당첨번호'),
                FutureBuilder(
                  future: gameRound.getWinningNumbers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else if(snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if(snapshot.data != []){
                      return Text('${snapshot.data}');
                    } else {
                      return const Text('미추첨 회차입니다.');
                    }
                  },),
              ]
          ),
        );
      },
    );
  }
}
