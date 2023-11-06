import 'package:auto_cam/Model/Main_Models/Filler_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Filler_View_Painter extends CustomPainter{

  late Filler_model  filler_model;
  late Piece_model piece_model;


  Filler_View_Painter(this.filler_model, this.piece_model);

  @override
  void paint(Canvas canvas, Size size) {

// size=Size(250, 350);
double scale=180/piece_model.piece_width;

if(filler_model.filler_inside){
  draw_front(canvas,scale);
  draw_side(canvas,scale);
}
else{
  draw_out_side(canvas,scale);

}


  }


  draw_front(Canvas canvas, double my_scale) {


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

     piece_w = piece_model .piece_width * my_scale;
     piece_h = piece_model .piece_height * my_scale;


      p.moveTo(front_origin.dx,  front_origin.dy);
      p.lineTo(front_origin.dx+piece_w,front_origin.dy);
      p.lineTo(front_origin.dx+piece_w,front_origin.dy-piece_h);
      p.lineTo(front_origin.dx , front_origin.dy-piece_h);
      p.lineTo(front_origin.dx,  front_origin.dy);


      canvas.drawPath(p, line_painter);



      /// filler paint


    late double filler_w;
    late double filler_h;

    Path filler_p=Path();


    late Offset filler_origin;

    if(filler_model.filler_vertical){
      filler_w=piece_w;
      filler_h=filler_model.width* my_scale;
    }else{
      filler_w=piece_w;
      filler_h=filler_model.thickness* my_scale;
    }

      if(filler_model.corner==1){
        filler_origin=Offset(
            front_origin.dx,
            front_origin.dy-filler_model.y_move* my_scale);
      }
      else if(filler_model.corner==2){
        filler_origin=Offset(
            front_origin.dx+piece_w-filler_w,
            front_origin.dy-filler_model.y_move* my_scale);
      }
      else if(filler_model.corner==3 ){
        filler_origin=Offset(
            front_origin.dx+piece_w-filler_w,
            front_origin.dy-piece_h+filler_h-filler_model.y_move* my_scale);
      }
      else if(filler_model.corner==4){
        filler_origin=Offset(front_origin.dx,
            front_origin.dy-piece_h+filler_h-filler_model.y_move* my_scale);
      }


    filler_p.moveTo(filler_origin.dx,         filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx ,        filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx,         filler_origin.dy);


canvas.drawPath(filler_p, filler_painter);
draw_text(canvas, 'front', Offset(front_origin.dx+piece_w/2-40, front_origin.dy-piece_h/2), 12, 2);


  }

  draw_side(Canvas canvas, double my_scale) {


    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint filler_painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Offset side_origin=Offset(250, 250);

    late double piece_w;
    late double piece_h;

    Path p=Path();

    piece_w = piece_model .piece_width * my_scale;
    piece_h = piece_model .piece_height * my_scale;


    p.moveTo(side_origin.dx,  side_origin.dy);
    p.lineTo(side_origin.dx+piece_w,side_origin.dy);
    p.lineTo(side_origin.dx+piece_w,side_origin.dy-piece_h);
    p.lineTo(side_origin.dx , side_origin.dy-piece_h);
    p.lineTo(side_origin.dx,  side_origin.dy);


    canvas.drawPath(p, line_painter);



    /// filler paint


    late double filler_w;
    late double filler_h;

    Path filler_p=Path();


    late Offset filler_origin;

    if(filler_model.filler_vertical){
      filler_w=filler_model.thickness* my_scale;
      filler_h=filler_model.width* my_scale;
    }else{
      filler_w=filler_model.width* my_scale;
      filler_h=filler_model.thickness* my_scale;
    }

    if(filler_model.corner==1){
      filler_origin=Offset(
          side_origin.dx+filler_model.x_move* my_scale,
          side_origin.dy-filler_model.y_move* my_scale);
    }
    else if(filler_model.corner==2){
      filler_origin=Offset(
          side_origin.dx+piece_w-filler_w+filler_model.x_move* my_scale,
          side_origin.dy-filler_model.y_move* my_scale);
    }
    else if(filler_model.corner==3 ){
      filler_origin=Offset(
          side_origin.dx+piece_w-filler_w+filler_model.x_move* my_scale,
          side_origin.dy-piece_h+filler_h-filler_model.y_move* my_scale);
    }
    else if(filler_model.corner==4){
      filler_origin=Offset(side_origin.dx+filler_model.x_move* my_scale,
          side_origin.dy-piece_h+filler_h-filler_model.y_move* my_scale);
    }


    filler_p.moveTo(filler_origin.dx,         filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx ,        filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx,         filler_origin.dy);


    canvas.drawPath(filler_p, filler_painter);
    draw_text(canvas, 'side', Offset(side_origin.dx+piece_w/2-40, side_origin.dy-piece_h/2), 12, 2);







  }

  draw_out_side(Canvas canvas, double my_scale) {

    my_scale=my_scale*0.85;
    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint filler_painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Offset out_side_origin=Offset(150, 220);

    late double piece_w;
    late double piece_h;

    Path p=Path();

    piece_w = piece_model .piece_width * my_scale;
    piece_h = piece_model .piece_height * my_scale;


    p.moveTo(out_side_origin.dx,  out_side_origin.dy);
    p.lineTo(out_side_origin.dx+piece_w,out_side_origin.dy);
    p.lineTo(out_side_origin.dx+piece_w,out_side_origin.dy-piece_h);
    p.lineTo(out_side_origin.dx , out_side_origin.dy-piece_h);
    p.lineTo(out_side_origin.dx,  out_side_origin.dy);


    canvas.drawPath(p, line_painter);



    /// filler paint


    late double filler_w;
    late double filler_h;

    Path filler_p=Path();


    late Offset filler_origin;

    if(filler_model.corner==1||filler_model.corner==2){
      filler_w=filler_model.width* my_scale;
      filler_h=filler_model.height* my_scale;
    }else{
      filler_w=filler_model.height* my_scale;
      filler_h=filler_model.width* my_scale;
    }

    if(filler_model.corner==1){

      filler_w=filler_model.width* my_scale;
      filler_h=piece_h;

      filler_origin=Offset(
          out_side_origin.dx-filler_w+filler_model.x_move* my_scale,
          out_side_origin.dy-filler_model.y_move* my_scale);
    }
    else if(filler_model.corner==2){

      filler_w=filler_model.width* my_scale;
      filler_h=piece_h;

      filler_origin=Offset(
          out_side_origin.dx+piece_w+filler_model.x_move* my_scale,
          out_side_origin.dy-filler_model.y_move* my_scale);
    }
    else if(filler_model.corner==3 ){

      filler_w=piece_w;
      filler_h=filler_model.width* my_scale;


      filler_origin=Offset(
          out_side_origin.dx+filler_model.x_move* my_scale,
          out_side_origin.dy-piece_h-filler_model.y_move* my_scale);
    }
    else if(filler_model.corner==4){

      filler_w=piece_w;
      filler_h=filler_model.width* my_scale;


      filler_origin=Offset(
          out_side_origin.dx+filler_model.x_move* my_scale,
          out_side_origin.dy+filler_h-filler_model.y_move* my_scale);
    }


    filler_p.moveTo(filler_origin.dx,         filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx ,        filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx,         filler_origin.dy);


    canvas.drawPath(filler_p, filler_painter);
    draw_text(canvas, 'Front', Offset(out_side_origin.dx+piece_w/2-40, out_side_origin.dy-piece_h/2), 12, 2);







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