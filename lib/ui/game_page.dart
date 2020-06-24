import 'package:flutter/material.dart';
import 'package:bidding_tic_tac_toe/ai/ai.dart';
import 'package:bidding_tic_tac_toe/ui/field.dart';
import 'package:bidding_tic_tac_toe/ui/game_presenter.dart';
import 'package:flutter/semantics.dart';

class GamePage extends StatefulWidget {
  final String title;

  GamePage(this.title);

  @override
  GamePageState createState() => GamePageState():
}

class GamePageState extends State<GamePage> {
  List<int> board;
  int _currentPlayer;

  GamePresenter _presenter;

  GamePageState() {
    this._presenter = GamePresenter(_movePlayed, _onGameEnd);
  }

  void _onGameEnd(int winner) {
    var title = "Game over!";
    var content = "You lose :(";
    switch(winner) {
      case Ai.HUMAN: // will never happend :))
        title = "Congratulation!";
        content = "You managed to beat an unbeatable AI";
        break;

      case Ai.AI_PLAYER:
        title = "Game over!";
        content = "You lose :(";
        break;

      default:
        title = "Draw";
        content = "No winners here.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget> [
            new FlatButton(
              onPressed: () {
                setState(() {
                  reinitialize();
                  Navigator.of(context).pop();
                });
              },
              child: Text("Restart")
            ),
          ],
        );
      }
    );
  }

  void _movePlayer(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      if (_currentPlayer == Ai.HUMAN) {
        _currentPlayer = Ai.AI_PLAYER;
        _presenter.onHumanPlayed(board);

      } else {
        _currentPlayer = Ai.HUMAN;
      }
    });
  }

  String getSymbolForIdx(int idx) {
    return Ai.SYMBOL[board[idx]];
  }

  @override
  void initState() {
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    _currentPlayer = Ai.HUMAN;
    // generate initial board
    board = List.generate(9, (idx) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(60),
            child: Text("You are playing as X", style: TextStyle(fontSize:25),),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(9, (idx) {
                return Field(idx: idx, onTap: _movePlayed, playSymbol: getSymbolForIdx(idx));
              }),
            ),
          ),
        ],
      ),
    );
  }
}