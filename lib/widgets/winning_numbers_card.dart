import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/models/game_round.dart';

class WinningNumbersCard extends StatefulWidget {

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
                Text('회차: ${gameRound.gameRound}'),
                FutureBuilder(
                  future: gameRound.getWinningNumbers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if(snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('${snapshot.data}');
                    }
                  },),
              ]
          ),
        );
      },
    );
  }
}
