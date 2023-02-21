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
  String player = 'X';

  List<String> grid = ['', '', '', '', '', '', '', '', ''];

  String changeTurn(String currentPlayer) {
    if (currentPlayer == 'X') {
      return currentPlayer = 'O';
    } else {
      return currentPlayer = 'X';
    }
  }

// void checkWinner(int index){

//   if(grid[index]==grid[0])

// }

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
                splashColor: Color.fromARGB(255, 29, 25, 25),
                onTap: () {
                  if (grid[index] == '') {
                    setState(() {
                      grid[index] = player;
                      player = changeTurn(player);
                    });
                  }
                },
                child: Ink(
                  color: Color.fromARGB(255, 158, 164, 168),
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
      ]),
    );
  }
}
