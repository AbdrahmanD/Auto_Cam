import 'package:auto_cam/Controller/Painters/three_D_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
 import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_Painter extends CustomPainter {

  late Box_model box_model;
  late double drawing_scale;
  late Size screen_Size;
  late int hover_id;
  late RxList selected_pieces;
  late RxList selected_faces;

  late String view_port;

  late Offset start_select_window;
  late Offset end_select_window  ;
  late Point_model drawing_origin;

  List<Point_model> corners=[];

  Box_Painter(
      this.box_model,
      this.drawing_scale,
      this.screen_Size,
      this.hover_id,
      this.selected_pieces,
      this.selected_faces,
      this.view_port,
      this.start_select_window,
      this.end_select_window,
      this.drawing_origin,

      this.corners
      ){

    this.box_model = box_model;

    this.hover_id = hover_id;



    box_model.box_origin.x_coordinate = drawing_origin.x_coordinate;
    box_model.box_origin.y_coordinate = drawing_origin.y_coordinate;
    box_model.box_origin.z_coordinate = drawing_origin.z_coordinate;

    // Selected_Face selected_face = selected_faces.value.first;
    // print("selected face from box painter : ${selected_face.piece_id} / ${selected_face.face_name}");


     // box_model.box_pieces.sort((a, b) => a.piece_origin.z_coordinate.compareTo(b.piece_origin.z_coordinate));

     // for(Piece_model p in box_model.box_pieces){
     //   print("piece name = ${p.piece_name} , Z=${p.piece_origin.z_coordinate}");
     // }




  }

  @override
  void paint(Canvas canvas, Size size) {
    draw_box(canvas);
    draw_select_rect(canvas);


    // for(Point_model poi in corners){
    //
    //   canvas.drawCircle(
    //       Offset(
    //           poi.x_coordinate* drawing_scale + box_model.box_origin.x_coordinate,
    //           box_model.box_origin.y_coordinate-poi.y_coordinate* drawing_scale
    //       ), 3, Paint());
    //
    // }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_select_rect(Canvas canvas){

    Rect r =Rect.fromPoints(start_select_window, end_select_window);
    Paint p = Paint();


    p.style =PaintingStyle.fill;
    p.color=Colors.blueGrey[100]!;
    p.blendMode=BlendMode.darken;
    canvas.drawRect(r, p);


    p.style =PaintingStyle.stroke;
    p.strokeWidth=0.5;
    p.color=Colors.black;
    canvas.drawRect(r, p);

  }

  draw_box(Canvas canvas) {

    Paint thin_line_painter = Paint()
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke
      ..color = Colors.black;


    Paint line_painter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.black.withOpacity(0.7);

    Paint pieces_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue[200]!;

    Paint selected_pieces_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue[300]!;

    Paint selected_faces_filler = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth=3
      ..color = Colors.red[400]!;

    Paint inners_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.teal[200]!;
    Paint unselect_inner_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[100]!
    ..blendMode=BlendMode.darken;


    Paint doors_filler = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blueGrey[100]!
      ..blendMode=BlendMode.darken;



    for (int i =  box_model.box_pieces.length-1; i >=0; i--)
    {

      Piece_model piece_model = box_model.box_pieces[i];

      // if(piece_model.piece_name.contains("Helper")){
      //   continue;
      // }
      Selected_Face selected_face=Selected_Face("100", 5);
      if (selected_faces.value.length>0) {
         selected_face = selected_faces.value.first;
      }



      Point_model p1 = piece_model.piece_faces.faces[4].corners[0];
      Point_model p2 = piece_model.piece_faces.faces[4].corners[1];
      Point_model p3 = piece_model.piece_faces.faces[4].corners[2];
      Point_model p4 = piece_model.piece_faces.faces[4].corners[3];
      Point_model p5 = piece_model.piece_faces.faces[5].corners[0];
      Point_model p6 = piece_model.piece_faces.faces[5].corners[1];
      Point_model p7 = piece_model.piece_faces.faces[5].corners[2];
      Point_model p8 = piece_model.piece_faces.faces[5].corners[3];




      // canvas.drawCircle(
      //     Offset(
      //         piece_model.piece_origin.x_coordinate* drawing_scale + box_model.box_origin.x_coordinate,
      //         box_model.box_origin.y_coordinate-piece_model.piece_origin.y_coordinate* drawing_scale
      //     ), 3, Paint());


      // for(Point_model poi in [p1,p2,p3,p4,p5,p6,p7,p8]){
      //
      //   canvas.drawCircle(
      //       Offset(
      //           poi.x_coordinate* drawing_scale + box_model.box_origin.x_coordinate,
      //           box_model.box_origin.y_coordinate-poi.y_coordinate* drawing_scale
      //       ), 3, Paint());
      //
      // }

      Path path = Path();

      if(view_port=='F'){


        canvas.drawLine(
            Offset(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale),
            Offset(p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==3)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset(p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale),
            Offset(p3.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==2)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset(p3.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale),
            Offset(p4.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p4.y_coordinate * drawing_scale),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==1)?selected_faces_filler:  line_painter
        );

        canvas.drawLine(
            Offset(p4.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p4.y_coordinate * drawing_scale),
            Offset(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==4)?selected_faces_filler:  line_painter
        );

        path.moveTo(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale);
        path.lineTo(p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale);
        path.lineTo(p3.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale);
        path.lineTo(p4.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p4.y_coordinate * drawing_scale);
        path.lineTo(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale);


      }
      else if(view_port=='R'){

        canvas.drawLine(
            Offset( p2.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale ),
            Offset( p6.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p6.y_coordinate * drawing_scale ),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==3)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset( p6.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p6.y_coordinate * drawing_scale ),
            Offset( p7.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p7.y_coordinate * drawing_scale ),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==6)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset( p7.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p7.y_coordinate * drawing_scale ),
            Offset( p3.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale ),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==1)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset( p3.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale ),
            Offset( p1.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p1.y_coordinate * drawing_scale ),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==5)?selected_faces_filler: line_painter
        );



        path.moveTo( p2.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale);
        path.lineTo( p6.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p6.y_coordinate * drawing_scale);
        path.lineTo( p7.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p7.y_coordinate * drawing_scale);
        path.lineTo( p3.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p3.y_coordinate * drawing_scale);
        path.lineTo( p2.z_coordinate * drawing_scale + box_model.box_origin.z_coordinate, box_model.box_origin.y_coordinate - p2.y_coordinate * drawing_scale);


      }
      else if(view_port=='T'){


        canvas.drawLine(
            Offset( p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p1.z_coordinate * drawing_scale ),
            Offset( p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p2.z_coordinate * drawing_scale ),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==5)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset( p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p2.z_coordinate * drawing_scale),
            Offset( p6.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p6.z_coordinate * drawing_scale),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==2)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset( p6.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p6.z_coordinate * drawing_scale ),
            Offset( p5.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p5.z_coordinate * drawing_scale ),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==6)?selected_faces_filler: line_painter
        );

        canvas.drawLine(
            Offset( p5.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p5.z_coordinate * drawing_scale),
            Offset( p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p1.z_coordinate * drawing_scale),
            (piece_model.piece_id==selected_face.piece_id &&selected_face.face_name==4)?selected_faces_filler: line_painter
        );



        path.moveTo(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p1.z_coordinate * drawing_scale);
        path.lineTo(p2.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p2.z_coordinate * drawing_scale);
        path.lineTo(p6.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p6.z_coordinate * drawing_scale);
        path.lineTo(p5.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p5.z_coordinate * drawing_scale);
        path.lineTo(p1.x_coordinate * drawing_scale + box_model.box_origin.x_coordinate, box_model.box_origin.z_coordinate - p1.z_coordinate * drawing_scale);

      }




      for(int s=0;s<selected_pieces.length;s++){
        if (piece_model == selected_pieces[s]) {
          // if (piece_model.piece_name != 'inner' && piece_model.piece_name != 'Door') {

            canvas.drawPath(path, selected_pieces_filler);
            canvas.drawPath(path, line_painter);
          // }
        }
      }





      if(piece_model.piece_name.contains('inner')){
        canvas.drawPath(path, unselect_inner_filler);
        canvas.drawPath(path, thin_line_painter);

        // canvas.drawCircle(
        //     Offset(
        //         piece_model.piece_origin.x_coordinate* drawing_scale + box_model.box_origin.x_coordinate,
        //         box_model.box_origin.y_coordinate-piece_model.piece_origin.y_coordinate* drawing_scale
        //     ), 3, Paint());
        //

      }
      else {
        canvas.drawPath(path, line_painter);
      }

      if(piece_model.piece_name.contains("Door")){
        canvas.drawPath(path, doors_filler);
      }
      if (i == hover_id) {

        if (piece_model.piece_name.contains('inner')) {
          canvas.drawPath(path, inners_filler);
          // canvas.drawPath(path, line_painter);
        } else {
          canvas.drawPath(path, pieces_filler);
          canvas.drawPath(path, line_painter);

        }

        if(
        piece_model.piece_name.contains('Door')
        ){
          canvas.drawPath(path, doors_filler);
          canvas.drawPath(path, thin_line_painter);
        }


      }





    }
  }

  draw_text(Canvas c, String text, Offset offset, double t_size , int my_text_size) {
    TextSpan ts = TextSpan(
        text: text, style: TextStyle(fontSize: t_size/10*my_text_size, color: Colors.black));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(c, offset);
  }


}
