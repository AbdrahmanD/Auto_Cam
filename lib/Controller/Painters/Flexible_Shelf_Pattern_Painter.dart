import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Flexible_Shelf_Pattern_Painter extends CustomPainter {
  late List<Bore_unit> bore_units;
  late double thickness;
  late double widh;

  late double screen_width;
  late double max_width;
  late String type_name;

  Flexible_Shelf_Pattern_Painter
      (
      this.bore_units, this.thickness,
      this.widh, this.screen_width, this.max_width,this.type_name
      );

  @override
  void paint(Canvas canvas, Size size) {
    late double scal;
    if (max_width > screen_width) {
      scal = screen_width / max_width;
    } else {
      scal = 0.8;
    }

    double pw = widh;
    double pth = thickness;

    draw_pattern(canvas, pw, pth, scal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_pattern(Canvas canvas, double w, double th, double scal) {
    Paint bore_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    Paint shelf_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth=th*scal
      ..color = Colors.blue[200]!;


    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;



     Path main_piece_face = Path();

    Offset main_origin = Offset(50, 100);


    main_piece_face.moveTo(main_origin.dx, main_origin.dy + 16* th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy + 16 * th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy + 16 * th * scal);

     canvas.drawPath(main_piece_face, piece_painter);

    canvas.drawLine(
        Offset(main_origin.dx, main_origin.dy+8*th*scal),
        Offset(main_origin.dx+w*scal, main_origin.dy+8*th*scal),
        shelf_painter);


    for (int i = 0; i <  bore_units.length; i++)
    {

      double pre_distence =  bore_units[i].pre_distence;

      Bore_model unit = bore_units[i].face_bore;

        canvas.drawCircle(
            Offset(
           pre_distence*scal+main_origin.dx ,
                main_origin.dy+8*th*scal+bore_units[i].correct_y*scal+bore_units[i].correct_x*scal),
            unit.diameter * scal / 2, bore_painter);

      canvas.drawCircle(
          Offset(
              (w-pre_distence)*scal+main_origin.dx ,
              main_origin.dy+8*th*scal+bore_units[i].correct_y*scal+bore_units[i].correct_x*scal),
          unit.diameter * scal / 2, bore_painter);



      }





    draw_text(canvas,"Box" , Offset(main_origin.dx+50, main_origin.dy-30 ), 2, 12,Colors.black);
    draw_text(canvas,"Shelf" , Offset(main_origin.dx+w-75, main_origin.dy+7*th*scal ), 2, 12 , Colors.blue[300]!);






  }

  draw_text(
      Canvas c, String text, Offset offset, double t_size, int my_text_size , Color color) {
    TextSpan ts = TextSpan(
        text: text,
        style: TextStyle(fontSize: t_size * my_text_size, color: color));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(c, offset);
  }
}
