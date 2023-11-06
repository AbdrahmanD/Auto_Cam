


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fix_Panel_Painter extends CustomPainter{

late double fix_thickness;
late int corner ;
late double w;
late double h;


Fix_Panel_Painter(this.fix_thickness, this.corner, this.w, this.h);

  @override
  void paint(Canvas canvas, Size size) {

// size=Size(250, 350);
    double scale=150/w;


      draw_fix(canvas,scale);




  }


  draw_fix(Canvas canvas, double my_scale) {


    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint filler_painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Offset front_origin=Offset(20, 250);


    late double piece_w;
    late double piece_h;

    Path p=Path();

    piece_w = w* my_scale;
    piece_h = h * my_scale;


    p.moveTo(front_origin.dx,  front_origin.dy);
    p.lineTo(front_origin.dx+piece_w,front_origin.dy);
    p.lineTo(front_origin.dx+piece_w,front_origin.dy-piece_h);
    p.lineTo(front_origin.dx , front_origin.dy-piece_h);
    p.lineTo(front_origin.dx,  front_origin.dy);


    canvas.drawPath(p, line_painter);



    /// filler paint


    late double fix_w;
    late double fix_h;

    Path fix_p=Path();


    late Offset fix_origin;

    if( corner==1){
      fix_w=w*my_scale;
      fix_h=fix_thickness*my_scale;

      fix_origin=Offset(
          front_origin.dx,
          front_origin.dy-h* my_scale);
    }
    else if( corner==2){
      fix_w=fix_thickness*my_scale;
      fix_h=h*my_scale;

      fix_origin=Offset(
          front_origin.dx+ w* my_scale,
          front_origin.dy);
    }
    else if( corner==3 ){
      fix_w=w*my_scale;
      fix_h=fix_thickness*my_scale;

      fix_origin=Offset(
          front_origin.dx ,
          front_origin.dy+fix_thickness* my_scale);
    }
    else if( corner==4){
      fix_w=fix_thickness*my_scale;
      fix_h=h*my_scale;
      fix_origin=Offset(front_origin.dx-fix_thickness* my_scale,
          front_origin.dy );
    }


    fix_p.moveTo(fix_origin.dx,         fix_origin.dy);
    fix_p.lineTo(fix_origin.dx+fix_w,   fix_origin.dy);
    fix_p.lineTo(fix_origin.dx+fix_w,   fix_origin.dy-fix_h);
    fix_p.lineTo(fix_origin.dx ,        fix_origin.dy-fix_h);
    fix_p.lineTo(fix_origin.dx,         fix_origin.dy);


    canvas.drawPath(fix_p, filler_painter);
    // draw_text(canvas, 'front', Offset(front_origin.dx+piece_w/2-40, front_origin.dy-piece_h/2), 12, 2);


  }



  draw_text(
      Canvas c, String text, Offset offset, double t_size, int my_text_size) {
    TextSpan ts = TextSpan(
        text: text,
        style: TextStyle(fontSize: t_size * my_text_size, color: Colors.black));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(c, offset);
  }




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}