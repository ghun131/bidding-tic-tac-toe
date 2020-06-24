import 'package:flutter/material.dart';
import 'ui/home_page.dart';

String title = 'Bidding Tic Tac Toe';
void main() {
  runApp(BiddingTicTacToe());
}

class BiddingTicTacToe extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(title: title),
    );
  }
}
