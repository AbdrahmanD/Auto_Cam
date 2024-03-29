import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Filler_View_Painter.dart';
import 'package:auto_cam/Controller/Painters/Support_View_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/Model/Main_Models/Support_Filler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Model/Main_Models/Filler_model.dart';
class Add_Support_Dialog extends StatefulWidget {
  const Add_Support_Dialog({Key? key}) : super(key: key);

  @override
  State<Add_Support_Dialog> createState() => _Add_Support_Dialog();
}

class _Add_Support_Dialog extends State<Add_Support_Dialog> {

  TextEditingController Quantity = TextEditingController();

  TextEditingController support_width = TextEditingController();

  TextEditingController Material = TextEditingController();

  TextEditingController Left_Distance = TextEditingController();

  TextEditingController Right_Distance = TextEditingController();

  GlobalKey<FormState> add_partition_dialog_key = GlobalKey();

  Draw_Controller draw_Controller = Get.find();

  bool quantity = true;
  bool partition_center = true;
  bool distance = false;
  bool proportional = false;
  bool edit_enable = true;

  bool vertical=true;
  bool face=true;
  bool back=false;

  double width=60;
  double thickness=18;
  double left_or_down_Distance_value=0;
  double right_or_top_Distance_value=0;

  String right_or_top="Right";
  String left_or_down="Left";


  left_change(){

late double full_distance;

    if(vertical){
      full_distance= draw_Controller.box_repository.box_model.value.
      box_pieces[draw_Controller.hover_id].piece_width;
    }
    else{
      full_distance= draw_Controller.box_repository.box_model.value.
      box_pieces[draw_Controller.hover_id].piece_height;
    }

if (distance) {
  if (Left_Distance.text.toString() != '') {
    double  double_left_distance_0 = double.parse(Left_Distance.text.toString());
    left_or_down_Distance_value=double.parse(double_left_distance_0.toStringAsFixed(2));

    double right_distance=full_distance - left_or_down_Distance_value-width;

    Right_Distance.text ='${double.parse(right_distance.toStringAsFixed(2))}';
    // '${}';
  }
}



setState(() {});

  }


  right_change(){

late double full_distance;
    if(vertical){
      full_distance= draw_Controller.box_repository.box_model.value.
      box_pieces[draw_Controller.hover_id].piece_width;
    }
    else{
      full_distance= draw_Controller.box_repository.box_model.value.
      box_pieces[draw_Controller.hover_id].piece_height;
    }

if (distance) {
  if (Right_Distance.text.toString() != '') {
    double  double_right_distance_0 = double.parse(Right_Distance.text.toString());
    right_or_top_Distance_value=double.parse(double_right_distance_0.toStringAsFixed(2));

    double left_distance=full_distance - right_or_top_Distance_value-width;
left_or_down_Distance_value=left_distance;
    Left_Distance.text ='${double.parse(left_distance.toStringAsFixed(2))}';
    // '${}';
  }
}



setState(() {});

  }


  add_support() {

    int Quantity_value      =  double.parse(Quantity.text.toString()).toInt() ;

    if (add_partition_dialog_key.currentState!.validate()) {

      if (quantity) {

        if (!partition_center) {

          //  if (proportional) {
          //    left_or_down_Distance_value =
          //       (double.parse((double.parse(Left_Distance.text.toString()).toStringAsFixed(2))) / 100) *
          //           (draw_Controller.box_repository.box_model.value
          //               .box_pieces[draw_Controller.hover_id].piece_width) -
          //           width / 2;
          //
          //
          // }

          Support_Filler support_filler=Support_Filler(vertical, face, back, width, thickness, left_or_down_Distance_value);

draw_controller.add_support(support_filler, 1);

        }
        ///if partation center
        else {
          if(vertical){
            left_or_down_Distance_value = draw_Controller.box_repository.box_model.value
                        .box_pieces[draw_Controller.hover_id].piece_width /
                    2 -
                width / 2;
          }
          else{
            left_or_down_Distance_value = draw_Controller.box_repository.box_model.value
                .box_pieces[draw_Controller.hover_id].piece_height /
                2 -
                width / 2;
          }
          Support_Filler support_filler=Support_Filler(vertical, face, back, width, thickness, left_or_down_Distance_value);

          draw_controller.add_support(support_filler, 1);

        }
      }

      else{

        Support_Filler support_filler=Support_Filler(vertical, face, back, width, thickness, left_or_down_Distance_value);

          draw_controller.add_support(support_filler, Quantity_value);



      }

    }
    setState(() {

    });
  }

  partition_center_change() {

    if (!partition_center) {
      partition_center = true;
      distance = false;
      proportional = false;
      edit_enable = false;
      Quantity.text='1';
      // Left_Distance.text = '0';
      // Right_Distance.text = '0';
    }
    else if (partition_center) {
      partition_center = false;
      distance = true;
      proportional = false;
      edit_enable = true;
    }
    setState(() {});
  }



  Draw_Controller draw_controller=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    thickness=draw_Controller.box_repository.box_model.value.init_material_thickness;


    Quantity.text='1';
    Material.text='$thickness';
    support_width.text='60';

    partition_center = true;
    distance = false;
    proportional = false;
    edit_enable = false;
    left_or_down_Distance_value = draw_Controller.box_repository.box_model.value.
    box_pieces[draw_Controller.hover_id].piece_width-60;

    Left_Distance.text='${double.parse(left_or_down_Distance_value.toStringAsFixed(2))}';
    Right_Distance.text = '0';


  }


  @override
  Widget build(BuildContext context) {

    width=double.parse(double.parse(support_width.text.toString()).toStringAsFixed(2));
    Piece_model p = draw_controller.box_repository.box_model.value.box_pieces.where((element) => element.piece_name=="left").first;
    Support_Filler support_filler = Support_Filler(vertical, face, back, width, thickness,1);



    return Row(
      children: [
        /// foto , ok and cancel button
        Column(
          children: [

            /// vertical or horizontal
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ///Horizontal
                Text('Horizontal'),
                Checkbox(value: !vertical, onChanged: (v){
                  vertical=!vertical  ;
                  right_or_top="Top";
                  left_or_down="Down";

                  if(vertical){
                    left_or_down_Distance_value= draw_Controller.box_repository.box_model.value.
                    box_pieces[draw_Controller.hover_id].piece_width-width;
                  }else{
                    left_or_down_Distance_value= draw_Controller.box_repository.box_model.value.
                    box_pieces[draw_Controller.hover_id].piece_height-width;
                  }

                  Left_Distance.text="${left_or_down_Distance_value}";

                  setState(() {

                  });
                }),
                SizedBox(width: 12,),


                ///Vertical
                Text('Vertical'),
                Checkbox(value:  vertical, onChanged: (v){
                  vertical=!vertical  ;
                  right_or_top="Right";
                  left_or_down="Left";

                  if(vertical){
                    left_or_down_Distance_value= draw_Controller.box_repository.box_model.value.
                    box_pieces[draw_Controller.hover_id].piece_width-width;
                  }else{
                    left_or_down_Distance_value= draw_Controller.box_repository.box_model.value.
                    box_pieces[draw_Controller.hover_id].piece_height-width;
                  }
                  Left_Distance.text="${left_or_down_Distance_value}";

                  setState(() {

                  });
                }),
                SizedBox(width: 12,),





              ],
            ),

            /// back - face
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ///Horizontal
                Text('Face'),
                Checkbox(value: face, onChanged: (v){
                  face=!face  ;
                  setState(() {

                  });
                }),
                SizedBox(width: 12,),


                ///back
                Text('back'),
                Checkbox(value: back, onChanged: (v){
                  back=!back  ;
                  setState(() {

                  });
                }),
                SizedBox(width: 12,),




              ],
            ),

            //
            // /// foto
            // Container(
            //   width: 200,
            //   height: 300,
            //   child: Image.asset('lib/assets/images/support.png'),
            // ),

            /// painter
            Container(
              width: 300,height:500,color: Colors.grey[300],

              child: CustomPaint(
                painter: Support_View_Painter(support_filler,p),
              ),
            ),
            SizedBox(
              height: 12,
            ),

            ///ok and cancel button
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ///ok
                  InkWell(
                    onTap: () {
                      add_support();
                    },
                    child: Container(
                      width: 80,
                      height: 32,
                      child: Center(child: Text('ok')),
                      color: Colors.teal[200],
                    ),
                  ),

                  SizedBox(
                    width: 12,
                  ),

                  ///cancel
                  InkWell(
                    onTap: () {
                      Navigator.of(Get.overlayContext!).pop();
                    },
                    child: Container(
                      width: 80,
                      height: 32,
                      child: Center(child: Text('cancle')),
                      color: Colors.redAccent[100],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(
          width: 24,
        ),

        /// all details fields
        Container(
          child: Form(
            key: add_partition_dialog_key,
            child:
    Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'Quantity',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: Quantity,
                        onChanged: (_) {
                          if (Quantity.text != '') {
                            if (double.parse(Quantity.text.toString()).toInt() >
                                1) {
                              quantity = false;
                              partition_center=false;
                              setState(() {});
                            } else {
                              quantity = true;
                              setState(() {});
                            }
                          }
                        },
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    Container(width: 45, child: Text('  mm'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'width',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: support_width,
                        validator: (v) {
                          if (!v!.isEmpty) {
                            double dv = double.parse(v.toString());
                            if (dv <= (draw_Controller.box_repository.box_model.value.box_depth-100-24)) {

                            } else {
                              return 'the Gap big';
                            }
                          } else {
                            return 'add value please';
                          }
                        },onChanged: (v){
                          setState(() {

                          });
                      },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    Container(width: 45, child: Text('  mm'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        'thickness',
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Material,
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
                    Container(width: 45, child: Text('  mm'))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 270,
                    child: Container(
                      color: Colors.grey,
                      child: Text(' '),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        width: 40,
                        child: Checkbox(
                          value: partition_center,
                          onChanged: (bool? value) {
                              partition_center_change();

                          },
                        )),
                    Container(
                        width: 90,
                        child: Text(
                          'Center',
                        )),
                    SizedBox(width: 12,),

                  ],),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 2,
                    width: 270,
                    child: Container(
                      color: Colors.grey,
                      child: Text(' '),
                    ),
                  ),
                ),
                /// distance or proportional
                // Row(
                //   children: [
                //     Container(
                //         width: 30,
                //         child: Checkbox(
                //           value: distance,
                //           onChanged: (bool? value) {
                //             if (edit_enable) {
                //               distance = !distance;
                //               proportional = !proportional;
                //               Left_Distance.text = '0';
                //               Right_Distance.text = '0';
                //               setState(() {});
                //             }
                //           },
                //         )),
                //     Container(
                //         width: 80,
                //         child: Text(
                //           'Distence',
                //         )),
                //     // Container(
                //     //     width: 30,
                //     //     child: Checkbox(
                //     //       value: proportional,
                //     //       onChanged: (bool? value) {
                //     //         if (edit_enable) {
                //     //           distance = !distance;
                //     //           proportional = !proportional;
                //     //           Left_Distance.text = '0';
                //     //           Right_Distance.text = '0';
                //     //           setState(() {});
                //     //         }
                //     //       },
                //     //     )),
                //     // Container(
                //     //     width: 100,
                //     //     child: Text(
                //     //       'Proportional',
                //     //     )),
                //   ],
                // ),

                ///right_or_top
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        right_or_top,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        onChanged: (_) {
                        right_change();
                        },
                        enabled: (quantity && edit_enable),
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Right_Distance,
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
                    Container(width: 45, child: Text(distance ? '  mm' : '  %'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///left_or_down
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        left_or_down,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: TextFormField(
                        onChanged: (_) {
left_change();

                        },
                        enabled: (quantity && edit_enable),
                        inputFormatters: [DecimalTextInputFormatter(1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: Left_Distance,
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
                    Container(width: 45, child: Text(distance ? '  mm' : '  %'))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

              ],
            )))]);

  }
}
