import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  DateTime currentBirthDate = DateTime.fromMillisecondsSinceEpoch(1631365440 *
      1000); //// TODO: Here paste timestamp of birthday date whom you want to congratulate
  DateTime deadlineDate = DateTime.fromMillisecondsSinceEpoch(1631365500 *
      1000); //// TODO: Here paste timestamp of duration date of display of animations
  DateTime nextBirthDate = DateTime.fromMillisecondsSinceEpoch(1662901500 *
      1000); //// TODO: Here paste timestamp of next birthday date whom you want to celebrate for continuing date after deadline timestamp

  bool toogle = false;
  bool showBirthday = false;

  @override
  void initState() {
    super.initState();
    if (currentBirthDate.compareTo(DateTime.now()) < 0) {
      if (deadlineDate.compareTo(DateTime.now()) < 0) {
        letsToggle();
      } else {
        letsBirthdayToggle();
      }
    }
  }

  void letsBirthdayToggle() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        showBirthday = !showBirthday;
      });
    });
  }

  void letsToggle() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        toogle = !toogle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Duration currentDiff = currentBirthDate.difference(DateTime.now());
    Duration deadlineDiff = deadlineDate.difference(DateTime.now());
    Duration nextDiff = nextBirthDate.difference(DateTime.now());
    print('Current birthDate: $currentBirthDate');
    print('Current date in hours: ${currentDiff.inHours}');
    print('Deadline birthDate: $deadlineDate');
    print('Deadline in hours: ${deadlineDiff.inHours}');
    print('Next birthDate: $nextBirthDate');
    print('Next date in hours: ${nextDiff.inHours}');
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.red.withOpacity(0.3),
              ],
            ),
          ),
          child: showBirthday
              ? Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height / 6),
                        Image.asset(
                          'assets/7.gif',
                          width: width / 3,
                          height: height / 6,
                          gaplessPlayback: false,
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          'assets/2.gif',
                          width: width,
                          height: height / 4,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Agne',
                              color: Color(0xfffce4ec),
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              displayFullTextOnTap: false,
                              pause: const Duration(seconds: 3),
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  '''As Willian Barclay said \"There are two great days in a person\'s life - the day we are born and the day we discover why.\". This day is one of them and I wish You to find the second one...''',
                                  speed: Duration(milliseconds: 60),
                                ),
                                TypewriterAnimatedText(
                                  'Happy Birthday My Dear!!!',
                                  speed: Duration(milliseconds: 60),
                                ),
                              ],
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      left: width / 2.5,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SlideCountdownClock(
                          duration: deadlineDiff,
                          slideDirection: SlideDirection.Down,
                          separator: " ",
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          shouldShowDays: true,
                          onDone: () {
                            letsToggle();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(width: width / 8),
                        Text(
                          'Day',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: width / 8),
                        Text(
                          'Hours',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: width / 8),
                        Text(
                          'Mins',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: width / 7),
                        Text(
                          'Secs',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // current ClockTimer
                    Visibility(
                      visible: !toogle,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SlideCountdownClock(
                          duration: currentDiff,
                          slideDirection: SlideDirection.Down,
                          separator: " ",
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          shouldShowDays: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black87.withOpacity(0.5),
                                blurRadius: 2.0,
                              )
                            ],
                          ),
                          onDone: () {
                            letsBirthdayToggle();
                          },
                        ),
                      ),
                    ),
                    // next ClockTimer
                    Visibility(
                      visible: toogle,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SlideCountdownClock(
                          duration: nextDiff,
                          slideDirection: SlideDirection.Down,
                          separator: " ",
                          textStyle: TextStyle(
                            fontSize: toogle ? 29 : 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          shouldShowDays: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black87.withOpacity(0.5),
                                blurRadius: 2.0,
                              )
                            ],
                          ),
                          onDone: () {},
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
