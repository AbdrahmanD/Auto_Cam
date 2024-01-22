import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Faces_Painter extends CustomPainter {
  late Piece_model piece_model;

  double scal=1;

  Faces_Painter(this.piece_model);

  @override
  void paint(Canvas canvas, Size size) {
    double pw = piece_model.piece_width;
    double ph = piece_model.piece_height;

     var value = math.sqrt(math.pow(pw, 2) + math.pow(ph, 2));
    if (value < 400) {
      scal = 0.6;
    } else {
      scal = 0.6 * (450 / value);
    }

    draw_piece(canvas, scal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_piece(Canvas canvas, double my_scale) {

    Paint bore_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;


    late double w;
    late double h;
    late double th;


    if (piece_model.piece_direction == "H")
    {

      h = piece_model .piece_width * my_scale;
      w = piece_model .piece_height * my_scale;
      th = piece_model.piece_thickness * my_scale;


      Offset view_1=Offset(100,650-2*h-4*th);
      Offset view_2=Offset(100-2*th, 650-h-3*th);
      Offset view_3=Offset(100, 650-h-3*th);
      Offset view_4=Offset(100+w+th, 650-h-3*th);
      Offset view_5=Offset(100, 650-h-th);
      Offset view_6=Offset(100, 650);




      /// view 1
      Point_model p_1_0 = piece_model.piece_faces.faces[5].corners[0];
      Point_model p_1_2 = piece_model.piece_faces.faces[5].corners[2];

      double p_1_w = (p_1_2.x_coordinate - p_1_0.x_coordinate)*my_scale;
      double p_1_h = (p_1_2.y_coordinate - p_1_0.y_coordinate)*my_scale;

      List<tow_D_Line> lines_1=[];
      for(int i=0;i<piece_model.piece_faces.faces[5].joines.length;i++){


        Point_model jsp=piece_model.piece_faces.faces[5].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[5].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_1_0.x_coordinate)*my_scale+view_1.dx,view_1.dy- (jsp.y_coordinate-p_1_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_1_0.x_coordinate)*my_scale+view_1.dx,view_1.dy- (jep.y_coordinate-p_1_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[5].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[5].joines[i].join_width;
        lines_1.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      /// draw the boring holes
      ///


      draw_face(canvas, p_1_w, p_1_h, view_1,lines_1);

      int f=5;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_1.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_1.dy;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_1.dy;

          canvas.drawCircle(Offset(x, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }



      /// view 2
      Point_model p_2_0 = piece_model.piece_faces.faces[3].corners[0];
      Point_model p_2_2 = piece_model.piece_faces.faces[3].corners[2];

      double p_2_w = (p_2_2.y_coordinate - p_2_0.y_coordinate)*my_scale;
      double p_2_h = (p_2_2.z_coordinate - p_2_0.z_coordinate)*my_scale;

      List<tow_D_Line> lines_2=[];
      for(int i=0;i<piece_model.piece_faces.faces[3].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[3].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[3].joines[i].end_point;

        Offset sof=Offset((jsp.y_coordinate-p_2_0.y_coordinate)*my_scale+view_2.dx,view_2.dy- (jsp.z_coordinate-p_2_0.z_coordinate)*my_scale);
        Offset eof=Offset((jep.y_coordinate-p_2_0.y_coordinate)*my_scale+view_2.dx,view_2.dy- (jep.z_coordinate-p_2_0.z_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[3].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[3].joines[i].join_width;

        lines_2.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_2_w, p_2_h, view_2,lines_2);

       f=3;
      if(piece_model.piece_faces.faces[f].bores.length>0){



        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){


          double x= (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_2.dy;
          double y= (piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_2.dx;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_2.dy;

          canvas.drawCircle(Offset(y, z), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

      /// view 3

      Point_model p_3_0 = piece_model.piece_faces.faces[0].corners[0];
      Point_model p_3_2 = piece_model.piece_faces.faces[0].corners[2];

      double p_3_w = (p_3_2.x_coordinate - p_3_0.x_coordinate)*my_scale;
      double p_3_h = (p_3_2.z_coordinate - p_3_0.z_coordinate)*my_scale;

      List<tow_D_Line> lines_3=[];

      for(int i=0;i<piece_model.piece_faces.faces[0].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[0].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[0].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_3_0.x_coordinate)*my_scale+view_3.dx,view_3.dy-( jsp.z_coordinate-p_3_0.z_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_3_0.x_coordinate)*my_scale+view_3.dx,view_3.dy-( jep.z_coordinate-p_3_0.z_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[0].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[0].joines[i].join_width;

        lines_3.add(tow_D_Line(sof,eof,line_type,line_width));
      }

      draw_face(canvas, p_3_w, p_3_h, view_3,lines_3);

       f=0;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_3.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_3.dy;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_3.dy;

          canvas.drawCircle(Offset(x, z), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 4
      Point_model p_4_0 = piece_model.piece_faces.faces[1].corners[0];
      Point_model p_4_2 = piece_model.piece_faces.faces[1].corners[2];
      double p_4_w = (p_4_2.y_coordinate - p_4_0.y_coordinate)*my_scale;
      double p_4_h = (p_4_2.z_coordinate - p_4_0.z_coordinate)*my_scale;
      List<tow_D_Line> lines_4=[];
      for(int i=0;i<piece_model.piece_faces.faces[1].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[1].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[1].joines[i].end_point;

        Offset sof=Offset((jsp.y_coordinate-p_4_0.y_coordinate)*my_scale+view_4.dx,view_4.dy- (jsp.z_coordinate-p_4_0.z_coordinate)*my_scale);
        Offset eof=Offset((jep.y_coordinate-p_4_0.y_coordinate)*my_scale+view_4.dx,view_4.dy- (jep.z_coordinate-p_4_0.z_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[1].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[1].joines[i].join_width;

        lines_4.add(tow_D_Line(sof,eof,line_type,line_width));

      }
      draw_face(canvas, p_4_w, p_4_h, view_4,lines_4);
      f=1;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          //  print('face : $f'
          //     ' x : ${piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate} ,'
          //     ' y : ${piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate} ,'
          //     ' z : ${piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate} ,'
          // );
          // print('==========');


          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_4.dx;
          double y=  (piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_4.dx;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_4.dy;

          canvas.drawCircle(Offset(y, z), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 5
      Point_model p_5_0 = piece_model.piece_faces.faces[4].corners[0];
      Point_model p_5_2 = piece_model.piece_faces.faces[4].corners[2];
      double p_5_w = (p_5_2.x_coordinate - p_5_0.x_coordinate)*my_scale;
      double p_5_h = (p_5_2.y_coordinate - p_5_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_5=[];
      for(int i=0;i<piece_model.piece_faces.faces[4].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[4].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[4].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_5_0.x_coordinate)*my_scale+view_5.dx,view_5.dy- (jsp.y_coordinate-p_5_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_5_0.x_coordinate)*my_scale+view_5.dx,view_5.dy- (jep.y_coordinate-p_5_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[4].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[4].joines[i].join_width;

        lines_5.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_5_w, p_5_h, view_5,lines_5);

      f=4;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_5.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_5.dy;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_5.dy;

          canvas.drawCircle(Offset(x, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

      /// view 6
      Point_model p_6_0 = piece_model.piece_faces.faces[2].corners[0];
      Point_model p_6_2 = piece_model.piece_faces.faces[2].corners[2];
      double p_6_w = (p_6_2.x_coordinate - p_6_0.x_coordinate)*my_scale;
      double p_6_h = (p_6_2.z_coordinate - p_6_0.z_coordinate)*my_scale;
      List<tow_D_Line> lines_6=[];
      for(int i=0;i<piece_model.piece_faces.faces[2].joines.length;i++)
      {

        Point_model jsp=piece_model.piece_faces.faces[2].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[2].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_6_0.x_coordinate)*my_scale+view_6.dx,view_6.dy- (jsp.z_coordinate-p_6_0.z_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_6_0.x_coordinate)*my_scale+view_6.dx,view_6.dy- (jep.z_coordinate-p_6_0.z_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[2].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[2].joines[i].join_width;

        lines_6.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_6_w, p_6_h, view_6,lines_6);

      f=2;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_6.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_6.dy;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_6.dy;

          canvas.drawCircle(Offset(x, z), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

    }

    else if (piece_model.piece_direction == "V")

    {

      w = piece_model .piece_width * my_scale;
      h = piece_model .piece_height * my_scale;
      th = piece_model.piece_thickness * my_scale;


      Offset view_1 =Offset(100,650-2*h-4*th);
      Offset view_2 =Offset(100-2*th, 650-h-3*th);
      Offset view_6 =Offset(100, 650-h-3*th);
      Offset view_4  =Offset(100+w+th, 650-h-3*th);
      Offset view_5 =Offset(100, 650-h-th);
      Offset view_3 =Offset(100, 650);


      /// view 1
      Point_model p_1_0 = piece_model.piece_faces.faces[0].corners[0];
      Point_model p_1_2 = piece_model.piece_faces.faces[0].corners[2];
      double p_1_w = (p_1_2.z_coordinate - p_1_0.z_coordinate)*my_scale;
      double p_1_h = (p_1_2.x_coordinate - p_1_0.x_coordinate)*my_scale;
      List<tow_D_Line> lines_1=[];
      for(int i=0;i<piece_model.piece_faces.faces[0].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[0].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[0].joines[i].end_point;

        Offset sof=Offset((jsp.z_coordinate-p_1_0.z_coordinate)*my_scale+view_1.dx,view_1.dy-( jsp.x_coordinate-p_1_0.x_coordinate)*my_scale);
        Offset eof=Offset((jep.z_coordinate-p_1_0.z_coordinate)*my_scale+view_1.dx,view_1.dy-( jep.x_coordinate-p_1_0.x_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[0].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[0].joines[i].join_width;

        lines_1.add(tow_D_Line(sof,eof,line_type,line_width));
      }

      draw_face(canvas, p_1_w, p_1_h, view_1,lines_1);

      int f=0;
      if(piece_model.piece_faces.faces[f].bores.length>0){

        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  -(piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_1.dy;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_1.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_1.dx;

          canvas.drawCircle(Offset(z, x), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 2
      Point_model p_2_0 = piece_model.piece_faces.faces[4].corners[0];
      Point_model p_2_2 = piece_model.piece_faces.faces[4].corners[2];
      double p_2_w = (p_2_2.x_coordinate - p_2_0.x_coordinate)*my_scale;
      double p_2_h = (p_2_2.y_coordinate - p_2_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_2=[];
      for(int i=0;i<piece_model.piece_faces.faces[4].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[4].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[4].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_2_0.x_coordinate)*my_scale+view_2.dx,view_2.dy-( jsp.y_coordinate-p_2_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_2_0.x_coordinate)*my_scale+view_2.dx,view_2.dy-( jep.y_coordinate-p_2_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[4].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[4].joines[i].join_width;

        lines_2.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_2_w, p_2_h, view_2,lines_2);

       f=4;

      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_2.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_2.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_2.dx;

          canvas.drawCircle(Offset(x, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 3

      Point_model p_3_0 = piece_model.piece_faces.faces[3].corners[0];
      Point_model p_3_2 = piece_model.piece_faces.faces[3].corners[2];
      double p_3_w = (p_3_2.z_coordinate - p_3_0.z_coordinate)*my_scale;
      double p_3_h = (p_3_2.y_coordinate - p_3_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_3=[];
      for(int i=0;i<piece_model.piece_faces.faces[3].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[3].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[3].joines[i].end_point;

        Offset sof=Offset((jsp.z_coordinate-p_3_0.z_coordinate)*my_scale+view_3.dx,view_3.dy-( jsp.y_coordinate-p_3_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.z_coordinate-p_3_0.z_coordinate)*my_scale+view_3.dx,view_3.dy-( jep.y_coordinate-p_3_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[3].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[3].joines[i].join_width;

        lines_3.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_3_w, p_3_h, view_3,lines_3);

      f=3;

      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_3.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_3.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_3.dx;

          canvas.drawCircle(Offset(z, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 4
      Point_model p_4_0 = piece_model.piece_faces.faces[5].corners[0];
      Point_model p_4_2 = piece_model.piece_faces.faces[5].corners[2];
      double p_4_w = (p_4_2.x_coordinate - p_4_0.x_coordinate)*my_scale;
      double p_4_h = (p_4_2.y_coordinate - p_4_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_4=[];
      for(int i=0;i<piece_model.piece_faces.faces[5].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[5].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[5].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_4_0.x_coordinate)*my_scale+view_4.dx,view_4.dy-( jsp.y_coordinate-p_4_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_4_0.x_coordinate)*my_scale+view_4.dx,view_4.dy-( jep.y_coordinate-p_4_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[5].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[5].joines[i].join_width;

        lines_4.add(tow_D_Line(sof,eof,line_type,line_width));

      }
      draw_face(canvas, p_4_w, p_4_h, view_4,lines_4);

      f=5;

      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_4.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_4.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_4.dx;

          canvas.drawCircle(Offset(x, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }
      /// view 5
      Point_model p_5_0 = piece_model.piece_faces.faces[2].corners[0];
      Point_model p_5_2 = piece_model.piece_faces.faces[2].corners[2];
      double p_5_w = (p_5_2.z_coordinate - p_5_0.z_coordinate)*my_scale;
      double p_5_h = (p_5_2.x_coordinate - p_5_0.x_coordinate)*my_scale;
      List<tow_D_Line> lines_5=[];
      for(int i=0;i<piece_model.piece_faces.faces[2].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[2].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[2].joines[i].end_point;

        Offset sof=Offset((jsp.z_coordinate-p_5_0.z_coordinate)*my_scale+view_5.dx,view_5.dy-( jsp.x_coordinate-p_5_0.x_coordinate)*my_scale);
        Offset eof=Offset((jep.z_coordinate-p_5_0.z_coordinate)*my_scale+view_5.dx,view_5.dy-( jep.x_coordinate-p_5_0.x_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[2].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[2].joines[i].join_width;

        lines_5.add(tow_D_Line(sof,eof,line_type,line_width));

      }
      draw_face(canvas, p_5_w, p_5_h, view_5,lines_5);

      f=2;
      if(piece_model.piece_faces.faces[f].bores.length>0) {

        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  -(piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_5.dy;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_5.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_5.dx;

          canvas.drawCircle(Offset(z, x), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 6
      Point_model p_6_0 = piece_model.piece_faces.faces[1].corners[0];
      Point_model p_6_2 = piece_model.piece_faces.faces[1].corners[2];
      double p_6_w = (p_6_2.z_coordinate - p_6_0.z_coordinate)*my_scale;
      double p_6_h = (p_6_2.y_coordinate - p_6_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_6=[];
      for(int i=0;i<piece_model.piece_faces.faces[1].joines.length;i++){
        Point_model jsp=piece_model.piece_faces.faces[1].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[1].joines[i].end_point;

        Offset sof=Offset((jsp.z_coordinate-p_6_0.z_coordinate)*my_scale+view_6.dx,view_6.dy- (jsp.y_coordinate-p_6_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.z_coordinate-p_6_0.z_coordinate)*my_scale+view_6.dx,view_6.dy- (jep.y_coordinate-p_6_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[1].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[1].joines[i].join_width;

        lines_6.add(tow_D_Line(sof,eof,line_type,line_width));      }
      draw_face(canvas, p_6_w, p_6_h, view_6,lines_6);

      f=1;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_6.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_6.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_6.dx;

          canvas.drawCircle(Offset(z, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


    }

    else if (piece_model.piece_direction == "F")

    {

      w = piece_model. piece_width * my_scale;
      h = piece_model. piece_height * my_scale;
      th = piece_model.piece_thickness * my_scale;

      Offset view_1 = Offset(100+2*th, 650-2*h-4*th);
      Offset view_2 = Offset(100 , 650-h-3*th);
      Offset view_3 = Offset(100+2*th ,650-h-3*th);
      Offset view_4 = Offset(100+3*th+w , 650-h-3*th);
      Offset view_5 = Offset(100 +2*th    , 650-h-th);
      Offset view_6 = Offset(100 +2*th    , 650);


      /// view 1
      Point_model p_1_0 = piece_model.piece_faces.faces[0].corners[0];
      Point_model p_1_2 = piece_model.piece_faces.faces[0].corners[2];
      double p_1_w = (p_1_2.x_coordinate - p_1_0.x_coordinate)*my_scale;
      double p_1_h = (p_1_2.z_coordinate - p_1_0.z_coordinate)*my_scale;
      List<tow_D_Line> lines_1=[];
      for(int i=0;i<piece_model.piece_faces.faces[0].joines.length;i++){
        Point_model jsp=piece_model.piece_faces.faces[0].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[0].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_1_0.x_coordinate)*my_scale+view_1.dx,view_1.dy-( jsp.z_coordinate-p_1_0.z_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_1_0.x_coordinate)*my_scale+view_1.dx,view_1.dy-( jep.z_coordinate-p_1_0.z_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[0].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[0].joines[i].join_width;

        lines_1.add(tow_D_Line(sof,eof,line_type,line_width));      }
      draw_face(canvas, p_1_w, p_1_h, view_1,lines_1);


      int f=0;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_1.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_1.dy;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_1.dy;

          canvas.drawCircle(Offset(x, z), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

      /// view 2
      Point_model p_2_0 = piece_model.piece_faces.faces[3].corners[0];
      Point_model p_2_2 = piece_model.piece_faces.faces[3].corners[2];
      double p_2_w = (p_2_2.z_coordinate - p_2_0.z_coordinate)*my_scale;
      double p_2_h = (p_2_2.y_coordinate - p_2_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_2=[];
      for(int i=0;i<piece_model.piece_faces.faces[3].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[3].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[3].joines[i].end_point;

        Offset sof=Offset((jsp.z_coordinate-p_2_0.z_coordinate)*my_scale+view_2.dx,view_2.dy-( jsp.y_coordinate-p_2_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.z_coordinate-p_2_0.z_coordinate)*my_scale+view_2.dx,view_2.dy-( jep.y_coordinate-p_2_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[3].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[3].joines[i].join_width;

        lines_2.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_2_w, p_2_h, view_2,lines_2);


      f=3;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_2.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_2.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_2.dx;

          canvas.drawCircle(Offset(z, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

      /// view 3

      Point_model p_3_0 = piece_model.piece_faces.faces[4].corners[0];
      Point_model p_3_2 = piece_model.piece_faces.faces[4].corners[2];
      double p_3_w = (p_3_2.x_coordinate - p_3_0.x_coordinate)*my_scale;
      double p_3_h = (p_3_2.y_coordinate - p_3_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_3=[];
      for(int i=0;i<piece_model.piece_faces.faces[4].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[4].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[4].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_3_0.x_coordinate)*my_scale+view_3.dx,view_3.dy-( jsp.y_coordinate-p_3_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_3_0.x_coordinate)*my_scale+view_3.dx,view_3.dy-( jep.y_coordinate-p_3_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[4].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[4].joines[i].join_width;

        lines_3.add(tow_D_Line(sof,eof,line_type,line_width));
      }
      draw_face(canvas, p_3_w, p_3_h, view_3,lines_3);

      f=4;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_3.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_3.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_3.dx;

          canvas.drawCircle(Offset(x, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }


      /// view 4
      Point_model p_4_0 = piece_model.piece_faces.faces[1].corners[0];
      Point_model p_4_2 = piece_model.piece_faces.faces[1].corners[2];
      double p_4_w = (p_4_2.z_coordinate - p_4_0.z_coordinate)*my_scale;
      double p_4_h = (p_4_2.y_coordinate - p_4_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_4=[];
      for(int i=0;i<piece_model.piece_faces.faces[1].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[1].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[1].joines[i].end_point;

        Offset sof=Offset((jsp.z_coordinate-p_4_0.z_coordinate)*my_scale+view_4.dx,view_4.dy-( jsp.y_coordinate-p_4_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.z_coordinate-p_4_0.z_coordinate)*my_scale+view_4.dx,view_4.dy-( jep.y_coordinate-p_4_0.y_coordinate)*my_scale);


        String line_type=piece_model.piece_faces.faces[1].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[1].joines[i].join_width;

        lines_4.add(tow_D_Line(sof,eof,line_type,line_width));


      }
      draw_face(canvas, p_4_w, p_4_h, view_4,lines_4);

      f=1;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_4.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_4.dy;
          double z= (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_4.dx;

          canvas.drawCircle(Offset(z, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

      /// view 5
      Point_model p_5_0 = piece_model.piece_faces.faces[2].corners[0];
      Point_model p_5_2 = piece_model.piece_faces.faces[2].corners[2];
      double p_5_w = (p_5_2.x_coordinate - p_5_0.x_coordinate)*my_scale;
      double p_5_h = (p_5_2.z_coordinate - p_5_0.z_coordinate)*my_scale;
      List<tow_D_Line> lines_5=[];
      for(int i=0;i<piece_model.piece_faces.faces[2].joines.length;i++){
        Point_model jsp=piece_model.piece_faces.faces[2].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[2].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_5_0.x_coordinate)*my_scale+view_5.dx,view_5.dy-( jsp.z_coordinate-p_5_0.z_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_5_0.x_coordinate)*my_scale+view_5.dx,view_5.dy-( jep.z_coordinate-p_5_0.z_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[2].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[2].joines[i].join_width;

        lines_5.add(tow_D_Line(sof,eof,line_type,line_width));      }
      draw_face(canvas, p_5_w, p_5_h, view_5,lines_5);

      f=2;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_5.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_5.dy;
          double z= -(piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_5.dy;

          canvas.drawCircle(Offset(x, z), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }

      /// view 6
      Point_model p_6_0 = piece_model.piece_faces.faces[5].corners[0];
      Point_model p_6_2 = piece_model.piece_faces.faces[5].corners[2];
      double p_6_w = (p_6_2.x_coordinate - p_6_0.x_coordinate)*my_scale;
      double p_6_h = (p_6_2.y_coordinate - p_6_0.y_coordinate)*my_scale;
      List<tow_D_Line> lines_6=[];
      for(int i=0;i<piece_model.piece_faces.faces[5].joines.length;i++){

        Point_model jsp=piece_model.piece_faces.faces[5].joines[i].start_point;
        Point_model jep=piece_model.piece_faces.faces[5].joines[i].end_point;

        Offset sof=Offset((jsp.x_coordinate-p_6_0.x_coordinate)*my_scale+view_6.dx,view_6.dy-( jsp.y_coordinate-p_6_0.y_coordinate)*my_scale);
        Offset eof=Offset((jep.x_coordinate-p_6_0.x_coordinate)*my_scale+view_6.dx,view_6.dy-( jep.y_coordinate-p_6_0.y_coordinate)*my_scale);

        String line_type=piece_model.piece_faces.faces[5].joines[i].join_type;
        double line_width=piece_model.piece_faces.faces[5].joines[i].join_width;

        lines_6.add(tow_D_Line(sof,eof,line_type,line_width));

      }
      draw_face(canvas, p_6_w, p_6_h, view_6,lines_6);

      f=5;
      if(piece_model.piece_faces.faces[f].bores.length>0){


        for(int i=0;i<piece_model.piece_faces.faces[f].bores.length;i++){

          double x=  (piece_model.piece_faces.faces[f].bores[i].origin.x_coordinate-piece_model.piece_origin.x_coordinate)*my_scale+view_6.dx;
          double y= -(piece_model.piece_faces.faces[f].bores[i].origin.y_coordinate-piece_model.piece_origin.y_coordinate)*my_scale+view_6.dy;
          double z=  (piece_model.piece_faces.faces[f].bores[i].origin.z_coordinate-piece_model.piece_origin.z_coordinate)*my_scale+view_6.dx;

          canvas.drawCircle(Offset(x, y), piece_model.piece_faces.faces[f].bores[i].diameter*my_scale/2, bore_painter);

        }
      }



    }





    /// piece details
    draw_text(canvas, 'id:${piece_model.piece_id}', Offset(300, 10), 6.5, 2);
    draw_text(
        canvas, 'name :${piece_model.piece_name}', Offset(300, 30), 6.5, 2);
    draw_text(
        canvas, 'width :${piece_model.piece_width}', Offset(300, 50), 6.5, 2);
    draw_text(
        canvas, 'height :${piece_model.piece_height}', Offset(300, 70), 6.5, 2);
    draw_text(canvas, 'thickness :${piece_model.piece_thickness}',
        Offset(300, 90), 6.5, 2);
    draw_text(canvas, 'material name :    ${piece_model.material_name}',
        Offset(300, 130), 6.5, 2);
    draw_text(canvas, 'Piece Direction :    ${piece_model.piece_direction}',
        Offset(300, 160), 6.5, 2);
    // draw_text(canvas, 'Piece X :    ${piece_model.piece_origin.x_coordinate}',
    //     Offset(300, 200), 6.5, 2);
  }

  draw_face(Canvas canvas , double w , double h , Offset origin ,List<tow_D_Line> lines){

    Paint piece_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.teal[200]!;




    Path p = Path();

    p.moveTo(origin.dx        ,origin.dy        );
    p.lineTo(origin.dx + w,    origin.dy        );
    p.lineTo(origin.dx + w,    origin.dy - h    );
    p.lineTo(origin.dx        ,origin.dy - h    );
    p.lineTo(origin.dx        ,origin.dy        );

    canvas.drawPath(p, piece_painter);

    for(int i=0;i<lines.length;i++){
      if((lines[i].line_type=="Groove")){

        Paint groove_painter = Paint()
          ..strokeWidth = lines[i].line_width*scal
          ..style = PaintingStyle.stroke
          ..color = Colors.red[500]!;


        canvas.drawLine(
            Offset(lines[i].start_point.dx, lines[i].start_point.dy),
            Offset(lines[i].end_point.dx,   lines[i].end_point.dy),
            groove_painter);
      }else{
      canvas.drawLine(
          Offset(lines[i].start_point.dx, lines[i].start_point.dy),
          Offset(lines[i].end_point.dx,   lines[i].end_point.dy),
          line_painter);
    }

    // canvas.drawCircle(Offset(lines[i].start_point.dx, lines[i].start_point.dy), 2, groove_painter);

    }




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
}
