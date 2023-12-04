import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dart_eval/dart_eval.dart';

class Project_View_option extends StatefulWidget {
  @override
  State<Project_View_option> createState() => _Project_View_optionState();
}

class _Project_View_optionState extends State<Project_View_option> {
  // Draw_Controller draw_controller = Get.find();
  Project_Controller project_controller = Get.find();

  TextEditingController x_move = TextEditingController();

  TextEditingController y_move = TextEditingController();

  double text_size = 12;

  double selected_text_size = 14;

  double w0 = 50;

  double w1 = 70;

  double h0 = 32;

  double h1 = 50;

  double x_move_value = 0;

  double y_move_value = 0;

  @override
  void initState() {

    super.initState();

    x_move_value = 0;
    y_move_value = 0;
    x_move.text = '0';
    y_move.text = '0';

  }
  @override
  Widget build(BuildContext context) {

List<Box_model> boxes=project_controller.box_repository.project_model.boxes;

    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        width: 300,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),

            /// choos 3d or 2d , right top front
            Obx(
              () =>
                  Column(
                children: [
                  /// choos 3d or 2d
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// change view to : 2D
                      InkWell(
                        onTap: () {
                          project_controller.draw_3_D.value = false;
                        },
                        child: Container(
                          width: (!project_controller.draw_3_D.value) ? 75 : 32,
                          height: (!project_controller.draw_3_D.value) ? 50 : 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                (project_controller.draw_3_D.value) ? 0 : 6),
                            color: Colors.teal[300],
                          ),
                          child: Center(
                              child: Text(
                            '2D',
                            style: TextStyle(
                                fontSize:
                                    (!project_controller.draw_3_D.value) ? 18 : 12,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),

                      SizedBox(
                        width: 24,
                      ),

                      /// change view to : 3D
                      InkWell(
                        onTap: () {
                          project_controller.draw_3_D.value = true;
                        },
                        child: Container(
                            width: (project_controller.draw_3_D.value) ? 75 : 32,
                            height: (project_controller.draw_3_D.value) ? 50 : 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  (!project_controller.draw_3_D.value) ? 0 : 6),
                              color: Colors.teal[300],
                            ),
                            child: Center(
                                child: Text(
                              '3D',
                              style: TextStyle(
                                  fontSize: (project_controller.draw_3_D.value)
                                      ? 18
                                      : 12,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ],
                  ),

                  /// divider
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Divider(
                      height: 2,
                    ),
                  ),

                  /// choos  right top front
                  (!project_controller.draw_3_D.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// change view to : front
                            InkWell(
                              onTap: () {
                                project_controller.view_port.value = 'F';
                              },
                              child: Container(
                                width: (project_controller.view_port.value == 'F')
                                    ? w1
                                    : w0,
                                height: (project_controller.view_port.value == 'F')
                                    ? h1
                                    : h0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (project_controller.view_port.value == 'F')
                                          ? 4
                                          : 0),
                                  color:
                                      (project_controller.view_port.value == 'F')
                                          ? Colors.teal[300]
                                          : Colors.grey[400],
                                ),
                                child: Center(
                                    child: Text(
                                  'Front',
                                  style: TextStyle(
                                    fontSize:
                                        (project_controller.view_port.value == 'F')
                                            ? 16
                                            : 12,
                                  ),
                                )),
                              ),
                            ),

                            SizedBox(
                              width: 6,
                            ),

                            /// change view to : top
                            InkWell(
                              onTap: () {
                                project_controller.view_port.value = 'T';
                              },
                              child: Container(
                                width: (project_controller.view_port.value == 'T')
                                    ? w1
                                    : w0,
                                height: (project_controller.view_port.value == 'T')
                                    ? h1
                                    : h0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (project_controller.view_port.value == 'T')
                                          ? 4
                                          : 0),
                                  color:
                                      (project_controller.view_port.value == 'T')
                                          ? Colors.teal[300]
                                          : Colors.grey[400],
                                ),
                                child: Center(
                                    child: Text(
                                  'Top',
                                  style: TextStyle(
                                    fontSize:
                                        (project_controller.view_port.value == 'T')
                                            ? 16
                                            : 12,
                                  ),
                                )),
                              ),
                            ),

                            SizedBox(
                              width: 6,
                            ),

                            /// change view to : right
                            InkWell(
                              onTap: () {
                                project_controller.view_port.value = 'R';
                              },
                              child: Container(
                                width: (project_controller.view_port.value == 'R')
                                    ? w1
                                    : w0,
                                height: (project_controller.view_port.value == 'R')
                                    ? h1
                                    : h0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (project_controller.view_port.value == 'R')
                                          ? 4
                                          : 0),
                                  color:
                                      (project_controller.view_port.value == 'R')
                                          ? Colors.teal[300]
                                          : Colors.grey[400],
                                ),
                                child: Center(
                                    child: Text(
                                  'Right',
                                  style: TextStyle(
                                    fontSize:
                                        (project_controller.view_port.value == 'R')
                                            ? 16
                                            : 12,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),

            /// divider
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Divider(
                height: 2,
              ),
            ),

            /// boxes or piece table
            Obx(
              () =>
                  Container(
                width: 200,
                height: 500,
                child:(project_controller.selected_id.value==100)?
                    /// list of all pieces
                    Container(
                      child: ListView.builder(
                          itemCount: boxes.length,
                          itemBuilder: (context,t){
                        return Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Column(
                            children: [
                              Row(
                                children: [

                                  Text('name : '),
                                  Text('${boxes[t].box_name}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('width : '),
                                  Text('${boxes[t].box_width}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('height : '),
                                  Text('${boxes[t].box_height}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('depth : '),
                                  Text('${boxes[t].box_depth}'),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 12,bottom: 12),
                                child: Container(height: 2,width: 130,color: Colors.grey,),
                              )
                            ],
                          ),
                        );
                      })
                    )
                    :

                    /// selected item details
                    Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'name :',
                          style: TextStyle(fontSize: text_size),
                        ),
                        Text(
                          '${project_controller.box_repository.project_model.boxes[project_controller.selected_id.value].box_name}',
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
                          '${project_controller.box_repository.project_model.boxes[project_controller.selected_id.value].box_width}',
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
                          '${project_controller.box_repository.project_model.boxes[project_controller.selected_id.value].box_height}',
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
                          'depth :',
                          style: TextStyle(fontSize: text_size),
                        ),
                        Text(
                          '${project_controller.box_repository.project_model.boxes[project_controller.selected_id.value].box_depth}',
                          style: TextStyle(fontSize: text_size),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.5,
                      width: 100,
                      color: Colors.grey,
                    ),

                    Divider(
                      height: 2,
                      color: Colors.black,
                    ),


                    /// move box

                    Text('Move'),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('X'),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: 65,
                          height: 24,
                          child: TextFormField(
                            style: TextStyle(fontSize: 12),
                            enabled: true,
                            keyboardType:
                            TextInputType.numberWithOptions(
                                decimal: true),
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
                        SizedBox(
                          width: 18,
                        ),
                        Text('Y'),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: 65,
                          height: 24,
                          child: TextFormField(
                            style: TextStyle(fontSize: 12),
                            enabled: true,
                            keyboardType:
                            TextInputType.numberWithOptions(
                                decimal: true),
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
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: InkWell( onTap: (){
                        x_move_value = double.parse(
                            '${eval(x_move.text.toString())}');
                        y_move_value = double.parse(
                            '${eval(y_move.text.toString())}');

                        project_controller.move_box(Offset(x_move_value, y_move_value));

                        x_move_value = 0;
                        y_move_value = 0;
                        x_move.text = '0';
                        y_move.text = '0';
                      },
                        child: Container(width: 200,height: 50,color: Colors.teal[300],child: Center(child: Text('move Box'),),),
                      ),
                    ),
                    SizedBox(height: 24,),



                    /// delete box
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: InkWell( onTap: (){
                        project_controller.delete_box();
                      },
                        child: Container(width: 200,height: 50,color: Colors.red[300],child: Center(child: Text('delete Box'),),),
                      ),
                    ),
                    SizedBox(height: 24,),


                    // move and edit button
                    // Padding(
                    //   padding: const EdgeInsets.all(28.0),
                    //   child: InkWell( onTap: (){
                    //   project_controller.Edit_box();
                    //   },
                    //     child: Container(width: 200,height: 50,color: Colors.teal[300],child: Center(child: Text('Edit Box'),),),
                    //   ),
                    // ),
                    // SizedBox(height: 24,),
                    //
                    //
                    // Padding(
                    //   padding: const EdgeInsets.all(28.0),
                    //   child: InkWell( onTap: (){
                    //
                    //   },
                    //     child: Container(width: 200,height: 50,color: Colors.teal[300],child: Center(child: Text('move box '),),),
                    //   ),
                    // ),
                    // SizedBox(height: 24,),

                  ],
                ),

              ),
            ),

            // Obx(()=> Container(height:200,child: SingleChildScrollView(child: Text(project_controller.my_print.value),),))
          ],
        ),
      ),
    );
  }
}

