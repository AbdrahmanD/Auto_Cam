import 'dart:ui';

import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class three_D_Painter extends CustomPainter {

late  Box_model box_model;
  late List<LineWithType> lines_with_type;
  late Size screen_size;
  late double scale;


  three_D_Painter(this.box_model,this.lines_with_type, this.screen_size, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    size = screen_size;


    for(int i=0;i<box_model.box_pieces.length;i++){
      Piece_model p =box_model.box_pieces[i];
      draw_piece(canvas, screen_size,p);

    }

    draw_web(canvas, screen_size);


    ///

  }




  draw_web  (Canvas canvas , Size screen_size){

    double w = screen_size.width / 2;
    double h = screen_size.height / 2;

    for(int i=0;i<lines_with_type.length;i++){

      List<Line> lines=lines_with_type[i].lines;

      Paint paint=Paint();
      paint.style=PaintingStyle.stroke;
      paint.strokeWidth=1;
      paint.color=lines_with_type[i].color;

      for(int l=0;l<lines.length;l++){

        if(lines_with_type[i].type=="X"||lines_with_type[i].type=="Y"||lines_with_type[i].type=="Z"){

          continue;
        }else{ canvas.drawLine(
            Offset(lines[l].start_point.x_coordinate*scale+w,
                h-lines[l].start_point.y_coordinate*scale
            ),
            Offset(lines[l].end_point.x_coordinate*scale+w,
                h-lines[l].end_point.y_coordinate*scale
            ),
            paint);
        }

      }
    }



    for(int i=0;i<lines_with_type.length;i++){

      List<Line> lines=lines_with_type[i].lines;

      Paint paint=Paint();
      paint.style=PaintingStyle.stroke;
      paint.strokeWidth=1;
      paint.color=lines_with_type[i].color;

      for(int l=0;l<lines.length;l++){

        if(lines_with_type[i].type=="X"||lines_with_type[i].type=="Y"||lines_with_type[i].type=="Z"){

          draw_text(canvas, lines_with_type[i].type,
              Offset(lines_with_type[i].lines.first.end_point.x_coordinate*scale+w,
                  h-lines_with_type[i].lines.first.end_point.y_coordinate*scale)
              , 14, 14,lines_with_type[i].color);


          paint.strokeWidth=4;
          canvas.drawLine(
              Offset(lines[l].start_point.x_coordinate*scale+w,
                  h-lines[l].start_point.y_coordinate*scale
              ),
              Offset(lines[l].end_point.x_coordinate*scale+w,
                  h-lines[l].end_point .y_coordinate*scale
              ),
              paint);



        }else{ continue;

        }

      }



    }
  }

  draw_piece(Canvas canvas , Size screen_size , Piece_model piece_model ){

    double w = screen_size.width / 2;
    double h = screen_size.height / 2;


    ///
    Point_model p1 = piece_model.piece_faces.front_face.corners[0];
    Point_model p2 = piece_model.piece_faces.front_face.corners[1];
    Point_model p3 = piece_model.piece_faces.front_face.corners[2];
    Point_model p4 = piece_model.piece_faces.front_face.corners[3];
    Point_model p5 = piece_model.piece_faces.back_face.corners[0];
    Point_model p6 = piece_model.piece_faces.back_face.corners[1];
    Point_model p7 = piece_model.piece_faces.back_face.corners[2];
    Point_model p8 = piece_model.piece_faces.back_face.corners[3];

    Path front_path = Path();
    Path back_path  = Path();
    Path right_path = Path();
    Path left_path  = Path();
    Path top_path   = Path();
    Path base_path  = Path();

    front_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    front_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    front_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    front_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    front_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    back_path.moveTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    back_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    back_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    back_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    back_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);

    base_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    base_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    base_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    base_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    base_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    top_path.moveTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    top_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    top_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    top_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    top_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);

    left_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    left_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    left_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    left_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    left_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    right_path.moveTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    right_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    right_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    right_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    right_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);



    Paint front_path_paint = Paint();
    Paint back_path__paint  = Paint();
    Paint right_path_paint = Paint();
    Paint left_path__paint  = Paint();
    Paint top_path___paint   = Paint();
    Paint base_path__paint  = Paint();


    front_path_paint.style = PaintingStyle.stroke;
    back_path__paint.style = PaintingStyle.stroke;
    right_path_paint.style = PaintingStyle.stroke;
    left_path__paint.style = PaintingStyle.stroke;
    top_path___paint.style = PaintingStyle.stroke;
    base_path__paint.style = PaintingStyle.stroke;


    front_path_paint.strokeWidth=2;
    back_path__paint.strokeWidth=2;
    right_path_paint.strokeWidth=2;
    left_path__paint.strokeWidth=2;
    top_path___paint.strokeWidth=2;
    base_path__paint.strokeWidth=2;


    if(piece_model.piece_name=='inner'){}
    else{
      canvas.drawPath(front_path, front_path_paint);
      canvas.drawPath(back_path , back_path__paint);
      canvas.drawPath(right_path, right_path_paint);
      canvas.drawPath(left_path , left_path__paint);
      canvas.drawPath(top_path  , top_path___paint);
      canvas.drawPath(base_path , base_path__paint);


      Paint all_paint = Paint();

      all_paint.style = PaintingStyle.fill;
      all_paint.color=Colors.grey[400]!;
      all_paint.blendMode=BlendMode.darken;

      canvas.drawPath(front_path,all_paint);
      canvas.drawPath(back_path ,all_paint);
      canvas.drawPath(right_path,all_paint);
      canvas.drawPath(left_path ,all_paint);
      canvas.drawPath(top_path  ,all_paint);
      canvas.drawPath(base_path ,all_paint);
    }





  }

draw_text(Canvas c, String text, Offset offset, double t_size , int my_text_size , Color color) {
  TextSpan ts = TextSpan(
      text: text, style: TextStyle(fontSize: t_size/10*my_text_size, color: color,fontWeight: FontWeight.bold));
  TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
  tp.layout();

  tp.paint(c, offset);
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
