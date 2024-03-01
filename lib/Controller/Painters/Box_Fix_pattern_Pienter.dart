

import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Box_Fix_pattern_Pienter extends CustomPainter{

  late List<Bore_unit> bore_units;
  late double thickness;
  late double width;
  late double screen_width;

  late double scale;

  Box_Fix_pattern_Pienter(
      this.bore_units, this.thickness, this.width, this.screen_width);

  @override
  void paint(Canvas canvas, Size size) {

    scale=(screen_width-300)/width;
    draw_pattern(canvas,width,thickness,scale);

  }


  draw_pattern(Canvas canvas, double w, double th, double scal) {

    Paint bore_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;



    Path main_piece_face = Path();

    Path second_piece_face = Path();

    Offset main_origin = Offset(50, 225);

    Offset second_origin = Offset(50, 175);

    main_piece_face.moveTo(main_origin.dx, main_origin.dy + 6 * th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy + 6 * th * scal);


    second_piece_face.moveTo(second_origin.dx , second_origin.dy - 3 * th * scal);
    second_piece_face.lineTo(second_origin.dx, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal , second_origin.dy - 3 * th * scal);


    canvas.drawPath(main_piece_face, piece_painter);
    canvas.drawPath(second_piece_face, piece_painter);


    for (int i = 0; i < bore_units.length; i++)
    {


      bool mirror=bore_units[i].mirror;
      bool center=bore_units[i].center;

      double pre_distence = bore_units[i].pre_distence;

      Bore_model side = bore_units[i].side_bore;
      Bore_model nut = bore_units[i].nut_bore;

      Bore_model face = bore_units[i].face_bore;



if(center){

  if (bore_units[i].have_nut_bore) {

    canvas.drawCircle(
        Offset(
            (width/2)*scal+main_origin.dx ,
            bore_units[i].nut_bore_distence*scal+ main_origin.dy
        ),
        nut.diameter * scal / 2,
        bore_painter
    );


    canvas.drawCircle(
        Offset(
            (width/2)*scal+second_origin.dx ,
            - thickness/2*scal+ second_origin.dy
        ),
        face.diameter * scal / 2,
        bore_painter
    );

    canvas.drawRect(
        Offset(
            (width/2)*scal+main_origin.dx-side.diameter/2*scal,
            main_origin.dy
        )
        &
        Size(
            side.diameter*scal,
            -face.depth*scal
        ),

        bore_painter);

  }
  else{




    canvas.drawCircle(
        Offset(
            (width/2)*scal+second_origin.dx ,
            - thickness/2*scal+ second_origin.dy
        ),
        face.diameter * scal / 2,
        bore_painter
    );

    canvas.drawRect(
        Offset(
            (width/2)*scal+main_origin.dx-bore_units[i].side_bore.diameter/2*scal,
            main_origin.dy
        )
        &
        Size(
            side.diameter*scal,
            -face.depth*scal
        ),

        bore_painter);

  }

}
else{
  if(mirror){
    if (bore_units[i].have_nut_bore) {

      canvas.drawCircle(
          Offset(
              pre_distence*scal+main_origin.dx ,
              bore_units[i].nut_bore_distence*scal+ main_origin.dy
          ),
          nut.diameter * scal / 2,
          bore_painter
      );
      canvas.drawCircle(
          Offset(
              width*scale- pre_distence*scal+main_origin.dx ,
              bore_units[i].nut_bore_distence*scal+ main_origin.dy
          ),
          nut.diameter * scal / 2,
          bore_painter
      );


      canvas.drawCircle(
          Offset(
              pre_distence*scal+second_origin.dx ,
              - thickness/2*scal+ second_origin.dy
          ),
          face.diameter * scal / 2,
          bore_painter
      );

      canvas.drawCircle(
          Offset(
              width*scale- pre_distence*scal+second_origin.dx ,
              - thickness/2*scal+ second_origin.dy
          ),
          face.diameter * scal / 2,
          bore_painter
      );

      canvas.drawRect(
          Offset(
              pre_distence*scal+main_origin.dx-side.diameter/2*scal,
              main_origin.dy
          )
          &
          Size(
              side.diameter*scal,
              -face.depth*scal
          ),

          bore_painter);

      canvas.drawRect(
          Offset(
              width*scale- pre_distence*scal+main_origin.dx-side.diameter/2*scal,
              main_origin.dy
          )
          &
          Size(
              side.diameter*scal,
              -face.depth*scal
          ),

          bore_painter);

    }
    else{




      canvas.drawCircle(
          Offset(
              pre_distence*scal+second_origin.dx ,
              - thickness/2*scal+ second_origin.dy
          ),
          face.diameter * scal / 2,
          bore_painter
      );

      canvas.drawCircle(
          Offset(
              width*scale- pre_distence*scal+second_origin.dx ,
              - thickness/2*scal+ second_origin.dy
          ),
          face.diameter * scal / 2,
          bore_painter
      );


      canvas.drawRect(
          Offset(
              pre_distence*scal+main_origin.dx-bore_units[i].side_bore.diameter/2*scal,
              main_origin.dy
          )
          &
          Size(
              side.diameter*scal,
              -face.depth*scal
          ),

          bore_painter);

      canvas.drawRect(
          Offset(
              width*scale-pre_distence*scal+main_origin.dx-bore_units[i].side_bore.diameter/2*scal,
              main_origin.dy
          )
          &
          Size(
              side.diameter*scal,
              -face.depth*scal
          ),

          bore_painter);


    }

  }
  else{
    if (bore_units[i].have_nut_bore) {

      canvas.drawCircle(
          Offset(
              pre_distence*scal+main_origin.dx ,
              bore_units[i].nut_bore_distence*scal+ main_origin.dy
          ),
          nut.diameter * scal / 2,
          bore_painter
      );


      canvas.drawCircle(
          Offset(
              pre_distence*scal+second_origin.dx ,
              - thickness/2*scal+ second_origin.dy
          ),
          face.diameter * scal / 2,
          bore_painter
      );

      canvas.drawRect(
          Offset(
              pre_distence*scal+main_origin.dx-side.diameter/2*scal,
              main_origin.dy
          )
          &
          Size(
              side.diameter*scal,
              -face.depth*scal
          ),

          bore_painter);

    }
    else{




      canvas.drawCircle(
          Offset(
              pre_distence*scal+second_origin.dx ,
              - thickness/2*scal+ second_origin.dy
          ),
          face.diameter * scal / 2,
          bore_painter
      );

      canvas.drawRect(
          Offset(
              pre_distence*scal+main_origin.dx-bore_units[i].side_bore.diameter/2*scal,
              main_origin.dy
          )
          &
          Size(
              side.diameter*scal,
              -face.depth*scal
          ),

          bore_painter);

    }
  }
}


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




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;

  }



}