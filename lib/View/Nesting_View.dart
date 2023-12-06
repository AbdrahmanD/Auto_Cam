import 'package:auto_cam/Controller/Painters/Nesting_Painter.dart';
import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:flutter/material.dart';

class Nesting_View extends StatefulWidget {
  late My_Sheet container;


 Nesting_View(this.container);

  @override
  State<Nesting_View> createState() => _Nesting_ViewState(container);
}

class _Nesting_ViewState extends State<Nesting_View> {
  late My_Sheet container;

  _Nesting_ViewState(this.container);

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('nesting view page'),
      ),
      body: Container(
        child: Row(
          children: [
            Container(width: 300,color: Colors.grey[300],),
            Container(width: w-300,color: Colors.grey[100],
              child: CustomPaint(
                painter: Nesting_Painter(w,h,container),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
