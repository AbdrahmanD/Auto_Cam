import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Filler_View_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/Filler_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Filler_Dialog extends StatefulWidget {
  const Add_Filler_Dialog({Key? key}) : super(key: key);

  @override
  State<Add_Filler_Dialog> createState() => _Add_Filler_DialogState();
}

class _Add_Filler_DialogState extends State<Add_Filler_Dialog> {

  bool vertical_filler  =true;
  bool horizontal_filler=false;

  double x_move_value=0;
  double y_move_value=0;


  int corner=4;

  TextEditingController x_move=TextEditingController();
  TextEditingController y_move=TextEditingController();

  Draw_Controller draw_controller=Get.find();
  @override
  Widget build(BuildContext context) {

    // Piece_model p = Piece_model(1, '1', "V", 'mdf', 400, 600, 18, Point_model(0,0,0));
    Piece_model p = draw_controller.box_repository.box_model.value.box_pieces[2];
    Filler_model f = Filler_model(vertical_filler,100, 100, 18, corner, x_move_value, y_move_value);



    return Container(
      width: 300,
      height: 500,
      child: Column(
        children: [

          /// horizontal or vertical
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('Horizontal'),
              Checkbox(value: horizontal_filler, onChanged: (v){
                vertical_filler=!vertical_filler  ;
                horizontal_filler=!horizontal_filler;
                setState(() {

                });
              }),
              SizedBox(width: 12,),


              Text('Vertical'),
              Checkbox(value: vertical_filler, onChanged: (v){
                vertical_filler=!vertical_filler  ;
                horizontal_filler=!horizontal_filler;
                setState(() {

                });
              }),


            ],
          ),


          SizedBox(height: 12,),

          /// choose the corner
          Text('choose the corner'),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('1'),
              Checkbox(value: (corner==1)?true:false, onChanged: (v){
                corner=1;
                setState(() {

                });
              }),
              SizedBox(width: 12,),

              Text('2'),
              Checkbox(value: (corner==2)?true:false, onChanged: (v){
                corner=2;
                setState(() {

                });
              }),
              SizedBox(width: 12,),

              Text('3'),
              Checkbox(value: (corner==3)?true:false, onChanged: (v){
                corner=3;
                setState(() {

                });
              }),
              SizedBox(width: 12,),


              Text('4'),
              Checkbox(value: (corner==4)?true:false, onChanged: (v){
                corner=4;
                setState(() {

                });
              }),
              SizedBox(width: 12,),

            ],
          ),



          SizedBox(height: 12,),

          /// painter
          Container(
            width: 200,height:260,color: Colors.grey[200],

            child: CustomPaint(
              painter: Filler_View_Painter(f,p),
            ),
          ),
          SizedBox(height: 18,),

          /// move the filler
          Text('Move'),
          SizedBox(height: 8,),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('X'),
              SizedBox(width: 6,),

              Container(width: 80,height: 32,
                child: TextFormField(
                  onChanged: (_) {
                    if (x_move.text.toString()!='') {
                      x_move_value=double.parse(x_move.text.toString());
                    }
                    setState(() {
                    });                    },
                  enabled: true,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: x_move,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'add value please';
                    }
                  },
                ),
              ),
              SizedBox(width: 18,),

              Text('Y'),
              SizedBox(width: 6,),

              Container(width: 80,height: 32,
                child: TextFormField(
                  onChanged: (_) {
                    if(y_move.text.toString()!=''){
                      y_move_value=double.parse(y_move.text.toString());

                    }
                    setState(() {
                    });
                    },
                  enabled: true,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: y_move,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  validator: (d) {
                    if (d!.isEmpty) {
                      return 'add value please';
                    }
                  },
                ),
              ),
            ],
          ),


          SizedBox(height: 24,),
          /// add bottom
          InkWell(onTap:(){

            draw_controller.add_filler(f);
            Navigator.of(Get.overlayContext!).pop();

          },
              child: Container(width: 100,height: 32,
              decoration: BoxDecoration(color: Colors.teal[500],
              borderRadius: BorderRadius.circular(6)),
                child: Center(child: Text('Add stile' ,style: TextStyle(fontSize: 14,color: Colors.white),)),
              )
          
          )



        ],
      ),
    );
  }
}
