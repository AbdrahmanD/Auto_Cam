import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class View_option extends StatelessWidget {
  Draw_Controller draw_controller=Get.find();
  double text_size = 12;
  double selected_text_size = 14;

  double w0=50;
  double w1=70;
  double h0=32;
  double h1=50;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container( color: Colors.grey[300],
        width: 300,height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            SizedBox(height: 24,),

            /// choos 3d or 2d , right top front
            Obx(() =>
                Column(
                  children: [
                    /// choos 3d or 2d
                    Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [


                    /// change view to : 2D
                    InkWell(onTap: (){
                      draw_controller.draw_3_D.value=false;

                    },

                      child: Container(width: (!draw_controller.draw_3_D.value)?75:32,
                        height: (!draw_controller.draw_3_D.value)?50:24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((draw_controller.draw_3_D.value)?0:14)
                          ,                    color: Colors.teal[300],
                        ),
                        child: Center(child: Text('2D',style: TextStyle(fontSize: (!draw_controller.draw_3_D.value)?18:12,fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    SizedBox(width: 24,),

                    /// change view to : 3D
                    InkWell(onTap: (){
                      draw_controller.draw_3_D.value=true;

                    },

                      child: Container(width: (draw_controller.draw_3_D.value)?75:32,height: (draw_controller.draw_3_D.value)?50:24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular((!draw_controller.draw_3_D.value)?0:14)
                            ,                    color: Colors.teal[300],
                          ),
                          child: Center(child: Text('3D',style: TextStyle(fontSize: (draw_controller.draw_3_D.value)?18:12,fontWeight: FontWeight.bold),))
                      ),
                    ),


              ],
            ),

                    /// divider
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Divider(height: 2,),
                    ),

                    /// choos  right top front
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        /// change view to : front
                        InkWell(onTap: (){

                          draw_controller.view_port.value='F';
                        },

                          child:
                          Container(
                            width:  (draw_controller.view_port.value=='F')?w1:w0,
                            height: (draw_controller.view_port.value=='F')?h1:h0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular((draw_controller.view_port.value=='F')?12:0)
                              ,                             color:(draw_controller.view_port.value=='F')? Colors.teal[300]:Colors.grey[400],
                            ),
                            child: Center(child:
                            Text('Front',style: TextStyle(fontSize: (draw_controller.view_port.value=='F')?16:12,
                            ),)),
                          ),
                        ),

                        SizedBox(width: 6,),

                        /// change view to : top
                        InkWell(onTap: (){
                          draw_controller.view_port.value='T';

                        },

                          child:
                          Container(
                            width:  (draw_controller.view_port.value=='T')?w1:w0,
                            height: (draw_controller.view_port.value=='T')?h1:h0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular((draw_controller.view_port.value=='T')?12:0)
                              ,                    color:(draw_controller.view_port.value=='T')? Colors.teal[300]:Colors.grey[400],
                            ),
                            child: Center(child:
                            Text('Top',style: TextStyle(fontSize: (draw_controller.view_port.value=='T')?16:12,
                               ),)),
                          ),
                        ),

                        SizedBox(width: 6,),


                        /// change view to : right
                        InkWell(onTap: (){
                          draw_controller.view_port.value='R';

                        },

                          child:
                          Container(
                            width: ( draw_controller.view_port.value=='R')?w1:w0,
                            height: (draw_controller.view_port.value=='R')?h1:h0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular((draw_controller.view_port.value=='R')?12:0)
                              ,                    color:(draw_controller.view_port.value=='R')? Colors.teal[300]:Colors.grey[400],
                            ),
                            child: Center(child:
                            Text('Right',style: TextStyle(fontSize: (draw_controller.view_port.value=='R')?16:12,
                            ),)),
                          ),
                        ),

                      ],
                    ),

                  ],
                ), ),

            /// divider
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Divider(height: 2,),
            ),

            /// box or piece table
            Obx(
              ()=> Container(width: 200,height: 500,
                child: (draw_controller.selected_id.value == 100)
                    ?
                ListView.builder(
                      itemCount: draw_controller.box_repository.box_model.value.box_pieces.length,
                      itemBuilder: (context, i) {
                        if(draw_controller.box_repository.box_model.value.box_pieces[i].piece_name!='inner'){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'name :',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                    Text(
                                      '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_name}',
                                      style: TextStyle(
                                          fontSize: text_size,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.5,
                                  width: 100,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'width :',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                    Text(
                                      '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_width}',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.5,
                                  width: 100,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'height :',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                    Text(
                                      '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_height}',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.5,
                                  width: 100,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'thickness :',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                    Text(
                                      '${draw_controller.box_repository.box_model.value.box_pieces[i].piece_thickness}',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.5,
                                  width: 100,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'material :',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                    Text(
                                      '${draw_controller.box_repository.box_model.value.box_pieces[i].material_name}',
                                      style: TextStyle(fontSize: text_size),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Divider(
                                  height: 2,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          return SizedBox();
                        }

                      })

                    :
                    /// selected piece
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Text('Selected Piece',
                          style: TextStyle(fontSize: 16,color: Colors.redAccent,fontWeight: FontWeight.bold),

                ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'name :',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                          Text(
                            '${draw_controller.box_repository.box_model.value.box_pieces[draw_controller.selected_id.value].piece_name}',
                            style: TextStyle(
                                fontSize: selected_text_size,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 1,
                        width: 100,
                        color: Colors.grey,
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Row(
                        children: [
                          Text(
                            'width :',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                          Text(
                            '${draw_controller.box_repository.box_model.value.box_pieces[draw_controller.selected_id.value].piece_width}',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                        ],
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Container(
                        height: 1,
                        width: 100,
                        color: Colors.grey,
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Row(
                        children: [
                          Text(
                            'height :',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                          Text(
                            '${draw_controller.box_repository.box_model.value.box_pieces[draw_controller.selected_id.value].piece_height}',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                        ],
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Container(
                        height: 1,
                        width: 100,
                        color: Colors.grey,
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Row(
                        children: [
                          Text(
                            'thickness :',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                          Text(
                            '${draw_controller.box_repository.box_model.value.box_pieces[draw_controller.selected_id.value].piece_thickness}',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                        ],
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Container(
                        height: 1,
                        width: 100,
                        color: Colors.grey,
                      ),                      SizedBox(
                        height: 2,
                      ),

                      Row(
                        children: [
                          Text(
                            'material :',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                          Text(
                            '${draw_controller.box_repository.box_model.value.box_pieces[draw_controller.selected_id.value].material_name}',
                            style: TextStyle(fontSize: selected_text_size),
                          ),
                        ],
                      ),                      SizedBox(
                        height: 2,
                      ),

                      SizedBox(
                        height: 12,
                      ),




                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              draw_controller.delete_piece();
                            },
                            child: Container(
                              width: 64,height: 32,decoration: BoxDecoration(
                              color: Colors.teal[300],borderRadius: BorderRadius.circular(12)
                            ),child: Center(child: Text('Delete')),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              width: 64,height: 32,decoration: BoxDecoration(
                                color: Colors.teal[300],borderRadius: BorderRadius.circular(12)
                            ),child: Center(child: Text('Save')),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

              ),
            ),



          ],
        ),
      ),
    );
  }
}
