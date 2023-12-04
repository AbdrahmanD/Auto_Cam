import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Filler_View_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Filler_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Filler_Dialog extends StatefulWidget {
  late bool inside_filler;


  Add_Filler_Dialog(this.inside_filler);

  @override
  State<Add_Filler_Dialog> createState() => _Add_Filler_DialogState(inside_filler);
}

class _Add_Filler_DialogState extends State<Add_Filler_Dialog> {

  bool vertical_filler  =true;
  bool horizontal_filler=false;

  bool outside_filler=false;

  double x_move_value=0;
  double y_move_value=0;

  double filler_width_value=0;
  double filler_thickness_value=0;

  late bool inside_filler;

  _Add_Filler_DialogState(this.inside_filler);

  int corner=4;

  TextEditingController x_move=TextEditingController();
  TextEditingController y_move=TextEditingController();
  TextEditingController filler_width=TextEditingController();
  TextEditingController filler_thickness=TextEditingController();

  Draw_Controller draw_controller=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filler_thickness.text="18";
    filler_width.text='100';

  }
  @override
  Widget build(BuildContext context) {

    if(!(filler_width.text.toString()=="")){filler_width_value=double.parse(filler_width.text.toString());}
    if(!(filler_thickness.text.toString()=="")){filler_thickness_value=double.parse(filler_thickness.text.toString());}



    Piece_model p = draw_controller.box_repository.box_model.value.box_pieces.where((element) => element.piece_name=="left").first;

    Filler_model f = Filler_model(vertical_filler,inside_filler,100,filler_width_value,
         filler_thickness_value, corner, x_move_value, y_move_value);



    return Container(
      width: 600,
      height: 500,
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              SizedBox(height: 12,),

              /// horizontal or vertical
              inside_filler?Row(mainAxisAlignment: MainAxisAlignment.center,
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
              ):SizedBox(),

              SizedBox(height: 12,),

              /// choose the corner
              Text('choose the corner'),
              Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [



                 Text('1'),
                 Checkbox(value: (corner==4)?true:false, onChanged: (v){
                   corner=4;
                   setState(() {

                   });
                 }),
                 SizedBox(width: 12,),


                 Text('2'),
                 Checkbox(value: (corner==3)?true:false, onChanged: (v){
                   corner=3;
                   setState(() {

                   });
                 }),
                 SizedBox(width: 12,),

                 Text('3'),
                 Checkbox(value: (corner==1)?true:false, onChanged: (v){
                   corner=1;
                   setState(() {

                   });
                 }),
                 SizedBox(width: 12,),

                 Text('4'),
                 Checkbox(value: (corner==2)?true:false, onChanged: (v){
                   corner=2;
                   setState(() {

                   });
                 }),
                 SizedBox(width: 12,),



               ],
             ),

              SizedBox(height: 12,),

              Row(
                children: [
                  Container(width:100,child: Text('filler width')),
                  SizedBox(width: 6,),

                  Container(width: 80,height: 32,
                    child: TextFormField(
                      onChanged: (_) {
                        if (filler_width.text.toString()!='') {
                          filler_width_value=double.parse(filler_width.text.toString());
                        }
                        setState(() {
                        });                    },
                      enabled: true,
                      inputFormatters: [DecimalTextInputFormatter(2)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: filler_width,
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
              SizedBox(height: 12,),


              Row(
                children: [
                  Container(width:100,child: Text('filler thickness')),
                  SizedBox(width: 6,),

                  Container(width: 80,height: 32,
                    child: TextFormField(
                      onChanged: (_) {
                        if(filler_thickness.text.toString()!=''){
                          filler_thickness_value=double.parse(filler_thickness.text.toString());

                        }
                        setState(() {
                        });
                      },
                      enabled: true,
                      inputFormatters: [DecimalTextInputFormatter(2)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: filler_thickness,
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

              SizedBox(height: 12,),

              /// move the filler
              Row(
                children: [
                  Container(width:100,child: Text('Move X')),
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
                ],
              ),
              SizedBox(height: 12,),


              Row(
                children: [
                  Container(width:100,child: Text('Move Y')),
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

              SizedBox(height: 32,),
              /// add bottom
              InkWell(onTap:(){

                draw_controller.add_filler(f);
                Navigator.of(Get.overlayContext!).pop();

              },
                  child: Container(width: 100,height: 54,
                  decoration: BoxDecoration(color: Colors.teal[500],
                  borderRadius: BorderRadius.circular(6)),
                    child: Center(child: Text('Add Filler' ,style: TextStyle(fontSize: 14,color: Colors.white),)),
                  )

              )



            ],
          ),
          SizedBox(width: 20,),

          /// painter
          Container(
            width: 300,height:500,color: Colors.grey[300],

            child: CustomPaint(
              painter: Filler_View_Painter(f,p),
            ),
          ),
        ],
      ),
    );
  }
}
