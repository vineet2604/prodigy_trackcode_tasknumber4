import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  // Game board state
  List<String> board = List.filled(9, '');

  // Current player
  String currentPlayer = 'X';

  // Function to handle tile taps
  void _handleTap(int index) {
    setState(() {
      if (board[index] == '' && _checkWinner() == '') {
        board[index] = currentPlayer;
        if (_checkWinner() == '') {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      }
    });
  }

  // Function to check for a winner
  String _checkWinner() {
    const List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]] &&
          board[pattern[0]] != '') {
        return board[pattern[0]];
      }
    }

    if (board.contains('')) {
      return '';
    } else {
      return 'Draw';
    }
  }

  @override
  Widget build(BuildContext context) {
    String winner = _checkWinner();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (winner != '') Text('Winner: $winner', style: TextStyle(fontSize: 30)),
          if (winner != '')
            ElevatedButton(
              onPressed: () {
                setState(() {
                  board = List.filled(9, '');
                  currentPlayer = 'X';
                });
              },
              child: Text('Restart Game'),
            ),
          for (int row = 0; row < 3; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < 3; col++)
                  GestureDetector(
                    onTap: () => _handleTap(row * 3 + col),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          board[row * 3 + col],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
