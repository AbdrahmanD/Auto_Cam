
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Nesting_Piece_Painter extends CustomPainter {
  late Piece_model piece_model;

  Nesting_Piece_Painter(this.piece_model);

  @override
  void paint(Canvas canvas, Size size) {

    double pw=piece_model.piece_width;
    double ph=piece_model.piece_height;

    var scal;
var value =math.sqrt(math.pow(pw, 2)+math.pow(ph, 2));
if(value<400){
  scal=0.2;
}else{
  scal=0.2*(450/value);
}

    draw_piece(canvas,scal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_piece(Canvas canvas, double my_scale) {

    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint grove_painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    Paint boring_painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red;


    late double w;
    late double h;
    late double th;


    Path p_top=Path();
    Path p_inside=Path();
    Path p_down=Path();
    Path p_outside=Path();
    Path p_front=Path();
    Path p_back=Path();



    /// vertical pieces
    if (piece_model.piece_direction == 'V') {

      w = piece_model .piece_width * my_scale;
      h = piece_model .piece_height * my_scale;
      th = piece_model.piece_thickness * my_scale;


       Offset left_origin=Offset(20, h+20);
       Offset right_origin=Offset(20, 2*h+40);


      p_inside.moveTo(left_origin.dx,  left_origin.dy);
      p_inside.lineTo(left_origin.dx+w,left_origin.dy);
      p_inside.lineTo(left_origin.dx+w,left_origin.dy-h);
      p_inside.lineTo(left_origin.dx , left_origin.dy-h);
      p_inside.lineTo(left_origin.dx,  left_origin.dy);

      p_outside.moveTo(right_origin.dx,  right_origin.dy);
      p_outside.lineTo(right_origin.dx+w,right_origin.dy);
      p_outside.lineTo(right_origin.dx+w,right_origin.dy-h);
      p_outside.lineTo(right_origin.dx , right_origin.dy-h);
      p_outside.lineTo(right_origin.dx,  right_origin.dy);


for(int i=0;i<5;i++){
  for(int j=0;j<piece_model.piece_faces.faces[i].joines.length;j++){
    Point_model sp=piece_model.piece_faces.faces[i].joines[j].start_point;
    Point_model ep=piece_model.piece_faces.faces[i].joines[j].end_point;

    canvas.drawCircle(Offset(sp.x_coordinate*my_scale, 300+sp.y_coordinate*my_scale), 6, Paint());
  }
}


    }

    ///horisontal pieces
    else if (piece_model.piece_direction == 'H') {

      h = piece_model .piece_width * my_scale;
      w = piece_model .piece_height * my_scale;
      th = piece_model.piece_thickness * my_scale;


       Offset down_origin =Offset(20, h+20);
       Offset top_origin  =Offset(20,  2*h+40);


      p_inside.moveTo(top_origin.dx,  top_origin.dy);
      p_inside.lineTo(top_origin.dx+w,top_origin.dy);
      p_inside.lineTo(top_origin.dx+w,top_origin.dy-h);
      p_inside.lineTo(top_origin.dx , top_origin.dy-h);
      p_inside.lineTo(top_origin.dx,  top_origin.dy);



      p_outside.moveTo(down_origin.dx,  down_origin.dy);
      p_outside.lineTo(down_origin.dx+w,down_origin.dy);
      p_outside.lineTo(down_origin.dx+w,down_origin.dy-h);
      p_outside.lineTo(down_origin.dx , down_origin.dy-h);
      p_outside.lineTo(down_origin.dx,  down_origin.dy);




    }

    ///Faces pieces
    else if (piece_model.piece_direction == 'F') {

      w = piece_model. piece_width * my_scale;
      h = piece_model. piece_height * my_scale;
      th = piece_model.piece_thickness * my_scale;

       Offset front_origin=Offset(20, h+20);
       Offset back_origin =Offset(20,  2*h+40);




      /// front
      p_front.moveTo( front_origin.dx   ,  front_origin.dy    );
      p_front.lineTo( front_origin.dx  +w ,  front_origin.dy   );
      p_front.lineTo( front_origin.dx  +w  ,  front_origin.dy   -h  );
      p_front.lineTo( front_origin.dx   ,  front_origin.dy  -h  );
      p_front.lineTo( front_origin.dx   ,  front_origin.dy    );


      /// back
      p_back.moveTo(back_origin.dx   , back_origin.dy   );
      p_back.lineTo(back_origin.dx  +w , back_origin.dy   );
      p_back.lineTo(back_origin.dx  +w , back_origin.dy-h  );
      p_back.lineTo(back_origin.dx   , back_origin.dy  -h);
      p_back.lineTo(back_origin.dx   , back_origin.dy   );



    }






    if(piece_model.piece_name.contains("back_panel")){
      canvas.drawPath(p_back, line_painter);
      canvas.drawPath(p_front, line_painter);
    }
    else if(piece_model.piece_name.contains("base_panel")){
      canvas.drawPath(p_outside, line_painter);
      canvas.drawPath(p_inside, line_painter);
    }
    else{

      canvas.drawPath(p_top, line_painter);
      canvas.drawPath(p_down, line_painter);
      canvas.drawPath(p_outside, line_painter);
      canvas.drawPath(p_inside, line_painter);
      canvas.drawPath(p_back, line_painter);
      canvas.drawPath(p_front, line_painter);

    }



    draw_text(canvas, 'id:${piece_model.piece_id}',                      Offset(100, 20 ), 5.5, 2);
    draw_text(canvas, 'name :${piece_model.piece_name}',                 Offset(100, 40 ), 5.5, 2);
    draw_text(canvas, 'width :${piece_model.    piece_width}',           Offset(100, 60 ), 5.5, 2);
    draw_text(canvas, 'height :${piece_model.   piece_height}',          Offset(100, 80 ), 5.5, 2);
    draw_text(canvas, 'thickness :${piece_model.piece_thickness}',       Offset(100, 100), 5.5, 2);
    draw_text(canvas, 'material:    ${piece_model.material_name}',       Offset(100, 120), 5.5, 2);


  }

  draw_join_lines(Canvas canvas , Offset origin,double my_scal){

    /// draw join lines
    for(int i=0;i<piece_model.piece_faces.faces.length;i++){

      Single_Face single_face = piece_model.piece_faces.faces[i];

      for(int j=0;j<single_face.joines.length;j++){

        Point_model sp=piece_model.piece_faces.faces[i].joines[j].start_point;
        Point_model ep=piece_model.piece_faces.faces[i].joines[j].end_point;

        double sx=sp.x_coordinate*my_scal;
        double sy=sp.y_coordinate*my_scal;
        double sz=sp.z_coordinate*my_scal;

        double ex=ep.x_coordinate*my_scal;
        double ey=ep.y_coordinate*my_scal;
        double ez=ep.z_coordinate*my_scal;

        if(single_face.name==1){
        }
        else if(single_face.name==2){}
        else if(single_face.name==3){}
        else if(single_face.name==4){

          Offset start_offset=Offset(origin.dx+sx,origin.dy+ sy);
          Offset end_offset  =Offset(origin.dx+ex,origin.dy+ ey);

          canvas.drawLine(
              start_offset,
              end_offset  ,
              Paint());



        }
        else if(single_face.name==5){}
        else if(single_face.name==6){}




      }
    }


  }

  draw_text(Canvas c, String text, Offset offset, double t_size, int my_text_size) {
    TextSpan ts = TextSpan(
        text: text,
        style: TextStyle(fontSize: t_size * my_text_size, color: Colors.black));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(c, offset);
  }


}
