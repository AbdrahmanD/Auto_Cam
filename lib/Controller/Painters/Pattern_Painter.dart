
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Pattern_Painter extends CustomPainter {

 late List<Bore_unit> bore_unit;
 late double length;
 late double scal;

  Pattern_Painter(this.bore_unit,this.length,this.scal);

  @override
  void paint(Canvas canvas, Size size) {

    double pw  = length;
    double ph  = pw/10 ;
    double pth = 18    ;


    draw_pattern(canvas,pw,ph,pth,scal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


  draw_pattern(Canvas canvas,double w, double h, double th,double scal) {

    Paint bore_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth=2
      ..color = Colors.black;


    Path side=Path();
    Path face=Path();
    Path second=Path();


    Offset side_origin = Offset(50,65);
    Offset second_origin = Offset(50,35);
    Offset face_origin = Offset(50,65);

    second.moveTo(second_origin.dx,       second_origin.dy-2*h*scal);
    second.lineTo(second_origin.dx,       second_origin.dy);
    second.lineTo(second_origin.dx+w*scal,second_origin.dy);
    second.lineTo(second_origin.dx+w*scal,second_origin.dy-2*h*scal);

    side.moveTo(side_origin.dx,  side_origin.dy);
    side.lineTo(side_origin.dx+w*scal,side_origin.dy);
    side.lineTo(side_origin.dx+w*scal,side_origin.dy-th*scal);
    side.lineTo(side_origin.dx,  side_origin.dy-th*scal);
    side.lineTo(side_origin.dx,  side_origin.dy);

    face.moveTo(face_origin.dx,  face_origin.dy+5*h*scal);
    face.lineTo(face_origin.dx,  face_origin.dy);
    face.lineTo(face_origin.dx+w*scal,face_origin.dy);
    face.lineTo(face_origin.dx+w*scal,face_origin.dy+5*h*scal);


    canvas.drawPath(second, piece_painter);
    canvas.drawPath(side, piece_painter);
    canvas.drawPath(face, piece_painter);

// print(joinHolePattern.bores.length);

    for(int i=0;i<bore_unit.length;i++){
      Bore_unit  unit= bore_unit[i];

      double pre_distence=unit.pre_distence;
      Bore_model side_bore=unit.side_bore;
      bool have_nut_bore=unit.have_nut_bore;
      double nut_bore_distence=unit.nut_bore_distence;
      Bore_model nut_bore=unit.nut_bore;
      Bore_model face_bore=unit.face_bore;

canvas.drawCircle(Offset(side_origin.dx+pre_distence*scal,side_origin.dy-9*scal), side_bore.diameter*scal/2, bore_painter);
canvas.drawCircle(Offset(second_origin.dx+pre_distence*scal,second_origin.dy-9*scal), face_bore.diameter*scal/2, bore_painter);
if(have_nut_bore){
  canvas.drawCircle(Offset(face_origin.dx+pre_distence*scal,face_origin.dy+nut_bore_distence*scal), nut_bore.diameter*scal/2, bore_painter);

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
}