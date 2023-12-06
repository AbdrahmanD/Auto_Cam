import 'package:auto_cam/Controller/Painters/Nesting_Painter.dart';
import 'package:auto_cam/Controller/nesting/Nesting_Pieces.dart';
import 'package:flutter/material.dart';

class Nesting_View extends StatefulWidget {
 late Nesting_Pieces nesting_pieces;


 Nesting_View(this.nesting_pieces);

  @override
  State<Nesting_View> createState() => _Nesting_ViewState(nesting_pieces);
}

class _Nesting_ViewState extends State<Nesting_View> {
  late Nesting_Pieces nesting_pieces;

  _Nesting_ViewState(this.nesting_pieces);

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
                painter: Nesting_Painter(w,h,nesting_pieces),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
