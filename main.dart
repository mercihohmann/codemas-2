import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class ColorNameHex {
  String colorName;
  Color colorHex;

  ColorNameHex(this.colorName, this.colorHex);
}

void main() {
  runApp(GiftSorter());
}

class GiftSorter extends StatefulWidget {
  @override
  _GiftSorterState createState() => _GiftSorterState();
}

class _GiftSorterState extends State<GiftSorter> {
  int points = 0;
  String randomName;
  Color randomColor;
  var colorNames = ['blue', 'green', 'orange', 'pink', 'red', 'yellow'];
  var colorHex = [
    Color(0xFF00ACEF),
    Color(0xFF266751),
    Color(0xFFFF914D),
    Color(0xFFFF66C4),
    Color(0xFFDC2F22),
    Color(0xFFFBC512)
  ];

  @override
  void initState() {
    super.initState();
    getRandomColor();
    getRandomName();
    timer();
  }

  void timer() {
    Timer.periodic(Duration(milliseconds: 1250), (timer) {
      getRandomColor();
      getRandomName();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Your points: $points',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 150.0),
                  child: GestureDetector(
                    onTap: () {
                      onGiftTap(randomName, randomColor);
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/${hexToStringConverter(randomColor)}.png',
                          width: 200,
                        ),
                        Text(
                          randomName,
                          style: TextStyle(
                              color: randomColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getRandomColor() {
    Random random = new Random();
    int randomNumber = random.nextInt(5);
    randomColor = colorHex[randomNumber];
  }

  void getRandomName() {
    Random random = new Random();
    int randomNumber = random.nextInt(5);
    randomName = colorNames[randomNumber];
  }

  String hexToStringConverter(Color hexColor) {
    if (hexColor == Color(0xFF00ACEF)) {
      return 'blue';
    } else if (hexColor == Color(0xFF266751)) {
      return 'green';
    } else if (hexColor == Color(0xFFFF914D)) {
      return 'orange';
    } else if (hexColor == Color(0xFFFF66C4)) {
      return 'pink';
    } else if (hexColor == Color(0xFFDC2F22)) {
      return 'red';
    } else {
      return 'yellow';
    }
  }

  void onGiftTap(String name, Color color) {
    var colorToString = hexToStringConverter(color);
    if (name == colorToString) {
      points++;
    } else {
      points--;
    }
    setState(() {});
  }
}
