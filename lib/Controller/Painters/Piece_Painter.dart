
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Piece_Painter extends CustomPainter {
  late Piece_model piece_model;

  Piece_Painter(this.piece_model);

  @override
  void paint(Canvas canvas, Size size) {

    double pw=piece_model.Piece_width;
    double ph=piece_model.Piece_height;

    var scal;
var value =math.sqrt(math.pow(pw, 2)+math.pow(ph, 2));
if(value<400){
  scal=0.7;
}else{
  scal=0.6*(450/value);
}
print(scal);

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

      w = piece_model.Piece_width * my_scale;
      h = piece_model.Piece_height * my_scale;
      th = piece_model.Piece_thickness * my_scale;


      Offset top_origin=Offset(100,650-2*h-4*th);
      Offset back_origin=Offset(100-2*th, 650-h-3*th);
      Offset left_origin=Offset(100, 650-h-3*th);
      Offset front_origin=Offset(100+w+th, 650-h-3*th);
      Offset down_origin=Offset(100, 650-h-th);
      Offset right_origin=Offset(100, 650);


      if (piece_model.piece_faces.left_face.groove_list.length>0) {

        for(int i=0;i<piece_model.piece_faces.left_face.groove_list.length;i++){

          var x_1=left_origin.dx+piece_model.piece_faces.left_face.groove_list[i].start_point.x_coordinate*my_scale;
          var y_1=left_origin.dy-piece_model.piece_faces.left_face.groove_list[i].start_point.y_coordinate*my_scale;

          var x_2=left_origin.dx+piece_model.piece_faces.left_face.groove_list[i].end_point.x_coordinate*my_scale;
          var y_2=left_origin.dy-piece_model.piece_faces.left_face.groove_list[i].end_point.y_coordinate*my_scale;


          canvas.drawLine(
              Offset(x_1,y_1),
              Offset(x_2,y_2),
              grove_painter..strokeWidth=piece_model.piece_faces.left_face.groove_list[i].groove_width*my_scale);
        }

      }

      if (piece_model.piece_faces.right_face.groove_list.length>0) {

        for(int i=0;i<piece_model.piece_faces.right_face.groove_list.length;i++){

          var x_1=right_origin.dx+piece_model.piece_faces.right_face.groove_list[i].start_point.x_coordinate*my_scale;
          var y_1=right_origin.dy-piece_model.piece_faces.right_face.groove_list[i].start_point.y_coordinate*my_scale;
          var x_2=right_origin.dx+piece_model.piece_faces.right_face.groove_list[i].end_point.x_coordinate*my_scale;
          var y_2=right_origin.dy-piece_model.piece_faces.right_face.groove_list[i].end_point.y_coordinate*my_scale;


          canvas.drawLine(
              Offset(x_1,y_1),
              Offset(x_2,y_2),
              grove_painter..strokeWidth=piece_model.piece_faces.right_face.groove_list[i].groove_width*my_scale);
        }

      }



      if(piece_model.piece_faces.left_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.left_face.join_list.length;i++){
          Offset join_point=Offset(
              left_origin.dx+piece_model.piece_faces.left_face.join_list[i].hole_point.x_coordinate*my_scale,
              left_origin.dy-piece_model.piece_faces.left_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.left_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.right_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.right_face.join_list.length;i++){
          Offset join_point=Offset(
             right_origin.dx+ piece_model.piece_faces.right_face.join_list[i].hole_point.x_coordinate*my_scale,
              right_origin.dy- piece_model.piece_faces.right_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.right_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.top_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.top_face.join_list.length;i++){
          Offset join_point=Offset(
              top_origin.dx+ piece_model.piece_faces.top_face.join_list[i].hole_point.x_coordinate*my_scale,
              top_origin.dy- piece_model.piece_faces.top_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.top_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.base_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.base_face.join_list.length;i++){
          Offset join_point=Offset(
              down_origin.dx+ piece_model.piece_faces.base_face.join_list[i].hole_point.x_coordinate*my_scale,
              down_origin.dy- piece_model.piece_faces.base_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.base_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.front_face.join_list.length>0){
        for(int i=0;i<piece_model.piece_faces.front_face.join_list.length;i++){
          Offset join_point=Offset(
              front_origin.dx +piece_model.piece_faces.front_face.join_list[i].hole_point.x_coordinate*my_scale,
              front_origin.dy-piece_model.piece_faces.front_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.front_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter,boring_painter);
        }

      }


      p_top.moveTo(top_origin.dx,top_origin.dy);
      p_top.lineTo(top_origin.dx+w,top_origin.dy);
      p_top.lineTo(top_origin.dx+w,top_origin.dy-th);
      p_top.lineTo(top_origin.dx,top_origin.dy-th);
      p_top.lineTo(top_origin.dx,top_origin.dy);


      p_inside.moveTo(left_origin.dx,  left_origin.dy);
      p_inside.lineTo(left_origin.dx+w,left_origin.dy);
      p_inside.lineTo(left_origin.dx+w,left_origin.dy-h);
      p_inside.lineTo(left_origin.dx , left_origin.dy-h);
      p_inside.lineTo(left_origin.dx,  left_origin.dy);


      p_down.moveTo(down_origin.dx,down_origin.dy);
      p_down.lineTo(down_origin.dx+w,down_origin.dy);
      p_down.lineTo(down_origin.dx+w,down_origin.dy-th);
      p_down.lineTo(down_origin.dx,down_origin.dy-th);
      p_down.lineTo(down_origin.dx,down_origin.dy);


      p_outside.moveTo(right_origin.dx,  right_origin.dy);
      p_outside.lineTo(right_origin.dx+w,right_origin.dy);
      p_outside.lineTo(right_origin.dx+w,right_origin.dy-h);
      p_outside.lineTo(right_origin.dx , right_origin.dy-h);
      p_outside.lineTo(right_origin.dx,  right_origin.dy);

      p_front.moveTo(front_origin.dx,front_origin.dy);
      p_front.lineTo(front_origin.dx+th,front_origin.dy);
      p_front.lineTo(front_origin.dx+th,front_origin.dy-h);
      p_front.lineTo(front_origin.dx,front_origin.dy-h);
      p_front.lineTo(front_origin.dx,front_origin.dy);


      p_back.moveTo(back_origin.dx,back_origin.dy);
      p_back.lineTo(back_origin.dx+th,back_origin.dy);
      p_back.lineTo(back_origin.dx+th,back_origin.dy-h);
      p_back.lineTo(back_origin.dx,back_origin.dy-h);
      p_back.lineTo(back_origin.dx,back_origin.dy);



    }

    ///horisontal pieces
    else if (piece_model.piece_direction == 'H') {

      h = piece_model.Piece_width * my_scale;
      w = piece_model.Piece_height * my_scale;
      th = piece_model.Piece_thickness * my_scale;


      Offset front_origin=Offset(100,650-2*h-4*th);
      Offset left_origin =Offset(100-2*th, 650-h-3*th);
      Offset down_origin =Offset(100, 650-h-3*th);
      Offset right_origin=Offset(100+w+th, 650-h-3*th);
      Offset back_origin =Offset(100, 650-h-th);
      Offset top_origin  =Offset(100, 650);



      if (piece_model.piece_faces.top_face.groove_list.length>0) {

        for(int i=0;i<piece_model.piece_faces.top_face.groove_list.length;i++){

          var x_1=top_origin.dx+(piece_model.piece_faces.top_face.groove_list[i].start_point.x_coordinate)*my_scale;
          var y_1=top_origin.dy-(piece_model.piece_faces.top_face.groove_list[i].start_point.y_coordinate)*my_scale;
          var x_2=top_origin.dx+(piece_model.piece_faces.top_face.groove_list[i].end_point.x_coordinate  )*my_scale;
          var y_2=top_origin.dy-(piece_model.piece_faces.top_face.groove_list[i].end_point.y_coordinate)*my_scale;


          canvas.drawLine(
              Offset(x_1,y_1),
              Offset(x_2,y_2),
              grove_painter..strokeWidth=piece_model.piece_faces.top_face.groove_list[i].groove_width*my_scale);
        }

      }
      if (piece_model.piece_faces.base_face.groove_list.length>0) {

        for(int i=0;i<piece_model.piece_faces.base_face.groove_list.length;i++){

          var x_1=down_origin.dx+(piece_model.piece_faces.base_face.groove_list[i].start_point.x_coordinate)*my_scale;
          var y_1=down_origin.dy-(piece_model.piece_faces.base_face.groove_list[i].start_point.y_coordinate)*my_scale;
          var x_2=down_origin.dx+(piece_model.piece_faces.base_face.groove_list[i].end_point.x_coordinate  )*my_scale;
          var y_2=down_origin.dy-(piece_model.piece_faces.base_face.groove_list[i].end_point.y_coordinate)*my_scale;


          canvas.drawLine(
              Offset(x_1,y_1),
              Offset(x_2,y_2),
              grove_painter..strokeWidth=piece_model.piece_faces.base_face.groove_list[i].groove_width*my_scale);
        }

      }

      if(piece_model.piece_faces.right_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.right_face.join_list.length;i++){
          Offset join_point=Offset(
             right_origin.dx+ piece_model.piece_faces.right_face.join_list[i].hole_point.x_coordinate*my_scale,
              right_origin.dy -piece_model.piece_faces.right_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.right_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }
      if(piece_model.piece_faces.left_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.left_face.join_list.length;i++){
          Offset join_point=Offset(
             left_origin.dx+piece_model.piece_faces.left_face.join_list[i].hole_point.x_coordinate*my_scale,
              left_origin.dy-piece_model.piece_faces.left_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.left_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.base_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.base_face.join_list.length;i++){
          Offset join_point=Offset(
              down_origin.dx+piece_model.piece_faces.base_face.join_list[i].hole_point.x_coordinate*my_scale,
              down_origin.dy-piece_model.piece_faces.base_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.base_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter,boring_painter);
        }

      }
      if(piece_model.piece_faces.top_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.top_face.join_list.length;i++){
          Offset join_point=Offset(
              top_origin.dx +piece_model.piece_faces.top_face.join_list[i].hole_point.x_coordinate*my_scale,
              top_origin.dy-piece_model.piece_faces.top_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.top_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter,boring_painter);
        }

      }


      p_top.moveTo(front_origin.dx,   front_origin.dy);
      p_top.lineTo(front_origin.dx+w, front_origin.dy);
      p_top.lineTo(front_origin.dx+w, front_origin.dy-th);
      p_top.lineTo(front_origin.dx,   front_origin.dy-th);
      p_top.lineTo(front_origin.dx,   front_origin.dy);


      p_inside.moveTo(top_origin.dx,  top_origin.dy);
      p_inside.lineTo(top_origin.dx+w,top_origin.dy);
      p_inside.lineTo(top_origin.dx+w,top_origin.dy-h);
      p_inside.lineTo(top_origin.dx , top_origin.dy-h);
      p_inside.lineTo(top_origin.dx,  top_origin.dy);


      p_down.moveTo(back_origin.dx,  back_origin.dy);
      p_down.lineTo(back_origin.dx+w,back_origin.dy);
      p_down.lineTo(back_origin.dx+w,back_origin.dy-th);
      p_down.lineTo(back_origin.dx,  back_origin.dy-th);
      p_down.lineTo(back_origin.dx,  back_origin.dy);


      p_outside.moveTo(down_origin.dx,  down_origin.dy);
      p_outside.lineTo(down_origin.dx+w,down_origin.dy);
      p_outside.lineTo(down_origin.dx+w,down_origin.dy-h);
      p_outside.lineTo(down_origin.dx , down_origin.dy-h);
      p_outside.lineTo(down_origin.dx,  down_origin.dy);

      p_front.moveTo(right_origin.dx,   right_origin.dy);
      p_front.lineTo(right_origin.dx+th,right_origin.dy);
      p_front.lineTo(right_origin.dx+th,right_origin.dy-h);
      p_front.lineTo(right_origin.dx,   right_origin.dy-h);
      p_front.lineTo(right_origin.dx,   right_origin.dy);


      p_back.moveTo(left_origin.dx,   left_origin.dy);
      p_back.lineTo(left_origin.dx+th,left_origin.dy);
      p_back.lineTo(left_origin.dx+th,left_origin.dy-h);
      p_back.lineTo(left_origin.dx,   left_origin.dy-h);
      p_back.lineTo(left_origin.dx,   left_origin.dy);





    }

    ///Faces pieces
    else if (piece_model.piece_direction == 'F') {

      w = piece_model.Piece_width * my_scale;
      h = piece_model.Piece_height * my_scale;
      th = piece_model.Piece_thickness * my_scale;

      Offset top_origin=  Offset(100+2*th, 650-2*h-4*th);
      Offset front_origin=Offset(100+2*th , 650-h-3*th);
      Offset down_origin= Offset(100+2*th , 650-h-th);
      Offset back_origin= Offset(100+2*th , 650);
      Offset left_origin= Offset(100     , 650-h-3*th);
      Offset right_origin=Offset(100 +w+3*th    , 650-h-3*th);

      if (piece_model.piece_faces.front_face.groove_list.length>0) {

        for(int i=0;i<piece_model.piece_faces.front_face.groove_list.length;i++){

          var x_1=front_origin.dx+(piece_model.piece_faces.front_face.groove_list[i].start_point.x_coordinate)*my_scale;
          var y_1=front_origin.dy-(piece_model.piece_faces.front_face.groove_list[i].start_point.y_coordinate)*my_scale;
          var x_2=front_origin.dx+(piece_model.piece_faces.front_face.groove_list[i].end_point.x_coordinate  )*my_scale;
          var y_2=front_origin.dy-(piece_model.piece_faces.front_face.groove_list[i].end_point.y_coordinate)*my_scale;


          canvas.drawLine(
              Offset(x_1,y_1),
              Offset(x_2,y_2),
              grove_painter..strokeWidth=piece_model.piece_faces.front_face.groove_list[i].groove_width*my_scale);
        }

      }
      if (piece_model.piece_faces.back_face.groove_list.length>0) {

        for(int i=0;i<piece_model.piece_faces.back_face.groove_list.length;i++){

          var x_1=back_origin.dx+(piece_model.piece_faces.back_face.groove_list[i].start_point.x_coordinate)*my_scale;
          var y_1=back_origin.dy-(piece_model.piece_faces.back_face.groove_list[i].start_point.y_coordinate)*my_scale;
          var x_2=back_origin.dx+(piece_model.piece_faces.back_face.groove_list[i].end_point.x_coordinate  )*my_scale;
          var y_2=back_origin.dy-(piece_model.piece_faces.back_face.groove_list[i].end_point.y_coordinate)*my_scale;


          canvas.drawLine(
              Offset(x_1,y_1),
              Offset(x_2,y_2),
              grove_painter..strokeWidth=piece_model.piece_faces.back_face.groove_list[i].groove_width*my_scale);
        }

      }



      if(piece_model.piece_faces.left_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.left_face.join_list.length;i++){
          Offset join_point=Offset(
              left_origin.dx+piece_model.piece_faces.left_face.join_list[i].hole_point.x_coordinate*my_scale,
              left_origin.dy-piece_model.piece_faces.left_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.left_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.right_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.right_face.join_list.length;i++){
          Offset join_point=Offset(
              right_origin.dx+ piece_model.piece_faces.right_face.join_list[i].hole_point.x_coordinate*my_scale,
              right_origin.dy- piece_model.piece_faces.right_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.right_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.top_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.top_face.join_list.length;i++){
          Offset join_point=Offset(
              top_origin.dx+ piece_model.piece_faces.top_face.join_list[i].hole_point.x_coordinate*my_scale,
              top_origin.dy- piece_model.piece_faces.top_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.top_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.base_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.base_face.join_list.length;i++){
          Offset join_point=Offset(
              down_origin.dx+ piece_model.piece_faces.base_face.join_list[i].hole_point.x_coordinate*my_scale,
              down_origin.dy- piece_model.piece_faces.base_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.base_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter, boring_painter);
        }

      }

      if(piece_model.piece_faces.front_face.join_list.length>0){
        for(int i=0;i<piece_model.piece_faces.front_face.join_list.length;i++){
          Offset join_point=Offset(
              front_origin.dx +piece_model.piece_faces.front_face.join_list[i].hole_point.x_coordinate*my_scale,
              front_origin.dy-piece_model.piece_faces.front_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.front_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter,boring_painter);
        }

      }

      if(piece_model.piece_faces.back_face.join_list.length>0){

        for(int i=0;i<piece_model.piece_faces.back_face.join_list.length;i++){
          Offset join_point=Offset(
              back_origin.dx +piece_model.piece_faces.back_face.join_list[i].hole_point.x_coordinate*my_scale,
              back_origin.dy-piece_model.piece_faces.back_face.join_list[i].hole_point.y_coordinate*my_scale
          );

          double join_diameter=piece_model.piece_faces.back_face.join_list[i].hole_diameter*my_scale/2;

          canvas.drawCircle(join_point, join_diameter,boring_painter);
        }

      }


      /// top
      p_top.moveTo( top_origin.dx   ,  top_origin.dy   );
      p_top.lineTo( top_origin.dx +w  ,  top_origin.dy   );
      p_top.lineTo( top_origin.dx +w  ,  top_origin.dy-th   );
      p_top.lineTo( top_origin.dx   ,  top_origin.dy -th );
      p_top.lineTo( top_origin.dx   ,  top_origin.dy   );


      /// front
      p_front.moveTo( front_origin.dx   ,  front_origin.dy    );
      p_front.lineTo( front_origin.dx  +w ,  front_origin.dy   );
      p_front.lineTo( front_origin.dx  +w  ,  front_origin.dy   -h  );
      p_front.lineTo( front_origin.dx   ,  front_origin.dy  -h  );
      p_front.lineTo( front_origin.dx   ,  front_origin.dy    );

      /// down
      p_down.moveTo( down_origin.dx   , down_origin.dy   );
      p_down.lineTo( down_origin.dx +w  , down_origin.dy   );
      p_down.lineTo( down_origin.dx  +w , down_origin.dy -th );
      p_down.lineTo( down_origin.dx   , down_origin.dy  -th );
      p_down.lineTo( down_origin.dx   , down_origin.dy   );


      /// back
      p_back.moveTo(back_origin.dx   , back_origin.dy   );
      p_back.lineTo(back_origin.dx  +w , back_origin.dy   );
      p_back.lineTo(back_origin.dx  +w , back_origin.dy-h  );
      p_back.lineTo(back_origin.dx   , back_origin.dy  -h);
      p_back.lineTo(back_origin.dx   , back_origin.dy   );


      /// left
      p_inside.moveTo( left_origin.dx   ,  left_origin.dy   );
      p_inside.lineTo( left_origin.dx +th  ,  left_origin.dy   );
      p_inside.lineTo( left_origin.dx  +th ,  left_origin.dy  -h );
      p_inside.lineTo( left_origin.dx   ,  left_origin.dy -h  );
      p_inside.lineTo( left_origin.dx   ,  left_origin.dy   );


      /// right
     p_outside.moveTo( right_origin.dx   ,  right_origin.dy   );
     p_outside.lineTo( right_origin.dx +th ,  right_origin.dy   );
     p_outside.lineTo( right_origin.dx +th ,  right_origin.dy-h  );
     p_outside.lineTo( right_origin.dx   ,  right_origin.dy  -h);
     p_outside.lineTo( right_origin.dx   ,  right_origin.dy   );



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



    draw_text(canvas, 'id:${piece_model.piece_id}',                  Offset(300, 10),  6.5, 2);
    draw_text(canvas, 'name :${piece_model.piece_name}',             Offset(300, 30),  6.5, 2);
    draw_text(canvas, 'width :${piece_model.Piece_width}',           Offset(300, 50),  6.5, 2);
    draw_text(canvas, 'height :${piece_model.Piece_height}',         Offset(300, 70),  6.5, 2);
    draw_text(canvas, 'thickness :${piece_model.Piece_thickness}',   Offset(300, 90),  6.5, 2);
    draw_text(canvas, 'quantity :${piece_model.piece_quantity}',   Offset(300, 110),  6.5, 2);
    draw_text(canvas, 'material name :    ${piece_model.material_name}', Offset(300, 130), 6.5, 2);


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
