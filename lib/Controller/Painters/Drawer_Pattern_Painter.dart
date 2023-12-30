import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Drawer_Pattern_Painter extends CustomPainter {
  late List<Bore_unit> drawer_bore_units;
  late List<Bore_unit> box_bore_units;
  late double thickness;
  late double widh;

  late double screen_width;
  late double max_width;
  late String type_name;

  Drawer_Pattern_Painter
      (
      this.drawer_bore_units,this.box_bore_units, this.thickness,
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

    Paint center_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;


    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;



     Path main_piece_face = Path();

    Path second_piece_face = Path();

    Offset main_origin = Offset(50, 100);

    Offset second_origin = Offset(50, 500);

    main_piece_face.moveTo(main_origin.dx, main_origin.dy + 6* th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + w * scal, main_origin.dy + 6 * th * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy + 6 * th * scal);


    second_piece_face.moveTo(second_origin.dx , second_origin.dy -12 * th * scal);
    second_piece_face.lineTo(second_origin.dx, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + w * scal , second_origin.dy - 12 * th * scal);
    second_piece_face.lineTo(second_origin.dx , second_origin.dy - 12 * th * scal);


     canvas.drawPath(main_piece_face, piece_painter);
    canvas.drawPath(second_piece_face, piece_painter);

    canvas.drawLine(Offset(main_origin.dx, main_origin.dy+3*th*scal), Offset(main_origin.dx+w*scal, main_origin.dy+3*th*scal), center_painter);
    canvas.drawLine(Offset(second_origin.dx, second_origin.dy-6*th*scal), Offset(second_origin.dx+w*scal, second_origin.dy-6*th*scal), center_painter);

// print(joinHolePattern.bores.length);

    for (int i = 0; i < drawer_bore_units.length; i++)
    {



      double pre_distence = drawer_bore_units[i].pre_distence;

      Bore_model unit = drawer_bore_units[i].face_bore;

        canvas.drawCircle(
            Offset(
           pre_distence*scal+main_origin.dx ,
                main_origin.dy+3*th*scal),
            unit.diameter * scal / 2, bore_painter);

      }

    for (int i = 0; i < box_bore_units.length; i++)
    {



      double pre_distence = box_bore_units[i].pre_distence;

      Bore_model unit = box_bore_units[i].face_bore;

      canvas.drawCircle(
          Offset(
              pre_distence*scal+second_origin.dx , second_origin.dy-6*th*scal), unit.diameter * scal / 2, bore_painter);

    }




    draw_text(canvas,"Box side" , Offset(main_origin.dx+50, main_origin.dy-30 ), 2, 12);

    draw_text(canvas, "Drawer", Offset(second_origin.dx+50, second_origin.dy  ), 2, 12);





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
