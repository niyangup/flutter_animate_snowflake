import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;

  List<Snowflake> list = List.generate(100, (index) => Snowflake());

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('appbarTitle')),
      body: AnimatedBuilder(
        builder: (BuildContext context, Widget child) {
          list.forEach((element) => element.fall());
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
            child: CustomPaint(painter: MyPainter(list)),
          );
        },
        animation: controller,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  List<Snowflake> list;

  MyPainter(this.list);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3;
    print(size);

    list.forEach((snowflake) {
      canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, paint);
    });

    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(Offset(0, 130), 60, paint);
    canvas.drawOval(Rect.fromCenter(center: Offset(0, 300), width: 200, height: 250), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Snowflake {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = 5;
  double speed = Random().nextDouble() * 4 + 2;

  fall() {
    y += speed;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
      radius = 5;
      speed = Random().nextDouble() * 4 + 2;
    }
  }
}
