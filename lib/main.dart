import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String player = 'X', winner = '';
  bool buttonDisabled = false, gameEnd = false, isdraw = false, win = false;
  int checkBoard = 0;
  List<String> grid = ['', '', '', '', '', '', '', '', ''];

  String changeTurn(String currentPlayer) {
    if (currentPlayer == 'X') {
      return currentPlayer = 'O';
    } else {
      return currentPlayer = 'X';
    }
  }

  bool checkMove(int index1, index2, index3, String currentPlayer) {
    if (currentPlayer == grid[index1] &&
        currentPlayer == grid[index2] &&
        currentPlayer == grid[index3]) {
      return true;
    }
    return false;
  }

  String checkWinner(String currentPlayer) {
    if (checkMove(0, 1, 2, currentPlayer) ||
        checkMove(3, 4, 5, currentPlayer) ||
        checkMove(6, 7, 8, currentPlayer) ||
        checkMove(0, 3, 6, currentPlayer) ||
        checkMove(1, 4, 7, currentPlayer) ||
        checkMove(2, 5, 8, currentPlayer) ||
        checkMove(0, 4, 8, currentPlayer) ||
        checkMove(2, 4, 6, currentPlayer)) {
      winner = currentPlayer;
      buttonDisabled = true;
      win = true;
      gameEnd = true;
    }
    return winner;
  }

  bool draw() {
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == '') {
        return false;
      }
    }
    player = "";
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Center(
          child: Text(
            'Player Turn: $player',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        buttonDisabled == true && winner.isNotEmpty
            ? Text(
                '$winner wins!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              )
            : const Text(''),
        isdraw && win == false
            ? const Text('Game draw!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ))
            : const Text(''),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.height / 2,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: grid.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: const Color.fromARGB(255, 29, 25, 25),
                onTap: () {
                  if (gameEnd == true) {
                    return;
                  }
                  if (grid[index] == '' && buttonDisabled == false) {
                    setState(() {
                      grid[index] = player;
                      checkBoard = index;
                      player = changeTurn(player);
                      winner = checkWinner(player);
                      isdraw = draw();
                    });
                  }
                },
                child: Ink(
                  color: const Color.fromARGB(255, 158, 164, 168),
                  child: Center(
                    child: Text(
                      grid[index].toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                grid = ['', '', '', '', '', '', '', '', ''];
                player = "";
                winner = "";
                buttonDisabled = false;
                gameEnd = false;
                win = false;
                isdraw = false;
              });
            },
            child: const Text('Reset'))
      ]),
    );
  }
}
