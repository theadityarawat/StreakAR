import 'package:flutter/material.dart';
import 'package:trail_run/constants.dart';
import 'models/Box.dart';
import 'dart:async';
import 'dart:core';

void main() {
  runApp(const RunApp());
}

class RunApp extends StatelessWidget {
  const RunApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streak Maintainer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int streak = 0;
  String lastDate = '0';
  late Timer _timer;
  late Duration _remainingTime;
  Duration remainingTime = Duration(hours: 24);


  void openPopup(Function(int) onStreakUpdated) async {
    int newStreak = streak;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Update Streak', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Streak Level: $newStreak \%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  Slider(
                    value: newStreak.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (double value) {
                      setState(() {
                        newStreak = value.toInt();
                      });
                    },
                    activeColor: kMainColor,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
                  ),
                  onPressed: () {
                    if (newStreak == 100) {
                      setState(() {
                        streak++;
                      });
                      onStreakUpdated(streak);
                    }
                    Navigator.of(context).pop();
                    startTimer();
                    updateDate();
                  },
                  child: Text('Update', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void updateStreak(int newStreak) {
    setState(() {
      streak = newStreak;
    });
  }
  void updateDate() {
    String _twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    DateTime now = DateTime.now();
    String formattedDate = "${_twoDigits(now.day)}";
    setState(() {
      lastDate = formattedDate;
    });
  }

  void openPopupNow() {
    openPopup(updateStreak);
  }

  void Reset() {
    setState(() {
      streak = 0;
    });
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      setState(() {
        remainingTime -= oneSecond;
      });

      if (remainingTime <= Duration.zero) {
        timer.cancel();
        Reset();
      }
    });
  }

  void myCallback() {
    Reset();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final remainingHours = remainingTime.inHours;
    final remainingMinutes = remainingTime.inMinutes % 60;
    final remainingSeconds = remainingTime.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Streak Maintainer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      backgroundColor: kMainDarkColor,
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            SizedBox(height: 40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RoundedRectangularBox(
                        number: streak,
                        size: 150,
                        additionalText: 'Current Streak',
                        onpress: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: newRoundedRectangularBox(
                      data: '$remainingHours : $remainingMinutes : $remainingSeconds',
                      additionalText: 'Remaining Time',
                      onpress: () {},
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: openPopupNow,
                            child: iconRoundedRectangularBox(
                              symbol: '+',
                              size: 150,
                              additionalText: 'Add Today\'s streak',
                              onpress: () {},
                            ))),
                    SizedBox(width: 30),
                    Expanded(
                      child: RoundedRectangularBox(
                        number: num.parse(lastDate),
                        size: 150,
                        additionalText: 'Last Streak Date',
                        onpress: () { },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ])),
    );
  }
}
