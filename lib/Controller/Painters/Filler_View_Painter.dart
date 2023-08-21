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
draw_piece(canvas,scale);
    // TODO: implement paint
  }


  draw_piece(Canvas canvas, double my_scale) {


    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint filler_painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Offset origin=Offset(10, 250);

    late double piece_w;
    late double piece_h;

    Path p=Path();

     piece_w = piece_model .piece_width * my_scale;
     piece_h = piece_model .piece_height * my_scale;


      p.moveTo(origin.dx,  origin.dy);
      p.lineTo(origin.dx+piece_w,origin.dy);
      p.lineTo(origin.dx+piece_w,origin.dy-piece_h);
      p.lineTo(origin.dx , origin.dy-piece_h);
      p.lineTo(origin.dx,  origin.dy);


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
        filler_origin=Offset(origin.dx+filler_model.x_move* my_scale, origin.dy-filler_model.y_move* my_scale);
      }
      else if(filler_model.corner==2){
        filler_origin=Offset(origin.dx+piece_w-filler_w-filler_model.x_move* my_scale, origin.dy-filler_model.y_move* my_scale);
      }
      else if(filler_model.corner==3 ){
        filler_origin=Offset(origin.dx+piece_w-filler_w-filler_model.x_move* my_scale,origin.dy-piece_h+filler_h+filler_model.y_move* my_scale);
      }
      else if(filler_model.corner==4){
        filler_origin=Offset(origin.dx+filler_model.x_move* my_scale,origin.dy-piece_h+filler_h+filler_model.y_move* my_scale);
      }


    filler_p.moveTo(filler_origin.dx,         filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy);
    filler_p.lineTo(filler_origin.dx+filler_w,filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx ,        filler_origin.dy-filler_h);
    filler_p.lineTo(filler_origin.dx,         filler_origin.dy);


canvas.drawPath(filler_p, filler_painter);







  }






  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}