import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam/View/Main_Screen.dart';
import 'package:auto_cam/View/Piece_List_view.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:auto_cam/project/Project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Setting_Project_Form extends StatefulWidget {



  @override
  State<Setting_Project_Form> createState() => _Setting_Project_FormState();
}

class _Setting_Project_FormState extends State<Setting_Project_Form> {

  late Box_model box_model;

  bool is_back_panel=true;

  GlobalKey<FormState> form_key = GlobalKey();

  Draw_Controller draw_Controller = Get.find();
  Project_Controller project_controller = Get.find();

  TextEditingController project_name_controller=TextEditingController();
  TextEditingController project_description_controller=TextEditingController();
  TextEditingController project_note_controller=TextEditingController();

  Draw_Controller draw_controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    box_model=draw_Controller.get_box();


    project_name_controller.text="vanity 1";
    project_description_controller.text="Floor 3 - flat 2 ";
    project_note_controller.text="walnut veneer as final lamination ";



  }
  @override
  Widget build(BuildContext context) {


    return Form(
      key: form_key,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0 , right: 20),
        child: ListView(scrollDirection: Axis.vertical,

          children: [
            SizedBox(
              height: 18,
            ),
            ///back button and lable
            Row(
              children: [
                //Back button
                Container(
                  width: 50,
                  child: InkWell(
                    child: Icon(
                      Icons.home,
                      size: 26,
                      color: Colors.teal,
                    ),
                    onTap: () {
                      Get.to(Main_Screen());
                    },
                  ),
                ),
                //lable
                Container(
                  width: 150,
                  child: Center(
                    child:
                    Text(
                      'setting up project',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),

            //divider
            Container(
              height: 1,
              color: Colors.grey,
            ),

            SizedBox(
              height: 12,
            ),

            ///project name
            Row(
              children: [


                Text(' project name  :'),
                SizedBox(
                  width: 12,
                ),

              ],
            ),
            SizedBox(
              height: 12,
            ),

            Container(
              width: 150,
              height: 26,
              child: TextFormField(  style: TextStyle(fontSize: 14),
                controller: project_name_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (d) {
                  if (d!.isEmpty) {
                    return 'please add value';
                  }
                },

              ),
            ),

            SizedBox(
              height: 12,
            ),


            ///date
            Row(
              children: [


                Text(' Date   : s'),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 150,
                  height: 26,
                  child: Text('12-2-2023')),

              ],
            ),
            SizedBox(
              height: 24,
            ),

            ///project description
            SizedBox(
              width: 16,
            ),
            Text('project description:'),
            SizedBox(
              height: 12,
            ),
            Container(
              width: 140,
              // height: 26,
              child: TextFormField(  style: TextStyle(fontSize: 14),
                controller: project_description_controller,minLines: 1,maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (d) {
                  if (d!.isEmpty) {
                    return 'please add value';
                  }
                },

              ),
            ),
            SizedBox(
              height: 12,
            ),

            ///project note
            SizedBox(
              width: 16,
            ),
            Text(' project note  :'),
            SizedBox(
              height: 12,
            ),
            Container(
              width: 100,
              // height: 26,
              child: TextFormField(  style: TextStyle(fontSize: 14),
                controller: project_note_controller,minLines: 2,maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (d) {
                  if (d!.isEmpty) {
                    return 'please add value';
                  }
                },

              ),
            ),
            SizedBox(
              height: 12,
            ),



            //divider
            Container(
              height: 1,
              color: Colors.grey,
            ),

            /// add item to project
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 52, top: 18, bottom: 18),
              child: InkWell(
                onTap: () {

                  project_controller.insert_box();
        setState(() {

        });

                },
                child: Container(
                   height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                        'Add item to project',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              ),
            ),
            ///////////////////////
            ///////////////////////

            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 32,
            ),

            //review cut list
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  Container(
                      width: 150,
                      child: Text('Review cut list  ',
                          style: TextStyle(
                            fontSize: 14,
                          ))),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                      onTap: () {
                        project_controller.extract_cutList();
                        Future.delayed(Duration(milliseconds: 1000)).then((value) => Get.to(Piece_List_view(true)));


                      },
                      child: Icon(
                        Icons.list,
                        size: 36,
                        color: Colors.teal,
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 12,
            ),



            ///preview Nesting sheets
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  Container(
                      width: 150,
                      child: Text('preview Nesting sheets',
                          style: TextStyle(
                            fontSize: 14,
                          ))),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                      onTap: () {
                        // draw_Controller.print_pieces_coordinate();
                        // print(draw_Controller.box_repository.project_model.boxes.length);

                      },
                      child: Icon(
                        Icons.margin_outlined,
                        size: 36,
                        color: Colors.teal,
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 12,
            ),

            ///Export every piece \n  as G_code file
            // Container(
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 18,
            //       ),
            //       Container(
            //           width: 180,
            //           child: Text('Export  G_code files',
            //               style: TextStyle(
            //                 fontSize: 14,
            //               ))),
            //       SizedBox(
            //         width: 18,
            //       ),
            //       InkWell(
            //           onTap: () {
            //             draw_controller.extract_xml_files(true);
            //
            //             },
            //           child: Icon(
            //             Icons.code,
            //             size: 36,
            //             color: Colors.teal,
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 12,
            // ),


            ///Save project
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                  ),
                  Container(
                      width: 150,
                      child: Text('Save project',
                          style: TextStyle(
                            fontSize: 14,
                          ))),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                      onTap: () {

                        project_controller.save_project();


                        },
                      child: Icon(
                        Icons.save,
                        size: 36,
                        color: Colors.teal,
                      )),
                ],
              ),
            ),

          ],
        ),
      ),
    );

  }
}
