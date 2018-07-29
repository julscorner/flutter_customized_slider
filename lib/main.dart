import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  double _value = 0.0;
  double sliderDistance = 100.0;
  int minRed = 255; // colors of the left side of the slider
  int minGreen = 136;
  int minBlue = 34;

  int maxRed = 76; // colors of the right side of the slider
  int maxGreen = 52;
  int maxBlue = 211;

  int calculateColorDelta(int min, int max) {
    int delta;
    delta = max - min;
    return delta;
  }

  void _onChanged(double value) {
    setState(() {
      _value = value;
    });
  }

  int calculateSliderColorChange(
      double _value, double sliderDistance, int delta, int min) {
    double r;
    double doubleDelta;
    double doubleMin;
    int ret;

    doubleDelta = delta.toDouble();
    doubleMin = min.toDouble();
    r = (_value / sliderDistance) * doubleDelta + doubleMin;
    //print(r); // see the slider values in the terminal
    ret = r.toInt();
    return ret;
  }

  Color sliderColorChange(double value, double sliderDistance) {
    int red;
    int green;
    int blue;

    int deltaRed = calculateColorDelta(maxRed, minRed);
    int deltaGreen = calculateColorDelta(maxGreen, minGreen);
    int deltaBlue = calculateColorDelta(maxBlue, minBlue);

    red = calculateSliderColorChange(_value, sliderDistance, deltaRed, maxRed);
    green = calculateSliderColorChange(
        _value, sliderDistance, deltaGreen, maxGreen);
    blue =
        calculateSliderColorChange(_value, sliderDistance, deltaBlue, maxBlue);

    setState(() {});

    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 129, 114, 209),
        title: Text('A slider with a custom theme'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: SliderTheme(
            data: theme.sliderTheme.copyWith(
              activeTrackColor:
                  Color.fromARGB(255, minRed, minGreen, minBlue),
              inactiveTrackColor:
                  Color.fromARGB(255, maxRed, maxGreen, maxBlue),
              activeTickMarkColor: Colors.deepPurpleAccent,
              inactiveTickMarkColor: Colors.black,
              overlayColor: Colors.black12,
              thumbColor: sliderColorChange(_value, sliderDistance),
            ),
            child: Slider(
              min: 0.0,
              max: sliderDistance,
              value: _value,
              label: 'Value',
              onChanged: (double value) {
                _onChanged(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
// Column is also layout widget. It takes a list of children and
// arranges them vertically. By default, it sizes itself to fit its
// children horizontally, and tries to be as tall as its parent.
//
// Invoke "debug paint" (press "p" in the console where you ran
// "flutter run", or select "Toggle Debug Paint" from the Flutter tool
// window in IntelliJ) to see the wireframe for each widget.
//
// Column has various properties to control how it sizes itself and
// how it positions its children. Here we use mainAxisAlignment to
// center the children vertically; the main axis here is the vertical
// axis because Columns are vertical (the cross axis would be
// horizontal).
