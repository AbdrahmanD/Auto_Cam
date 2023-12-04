import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Controller/Painters/Piece_Painter.dart';
import 'package:auto_cam/Controller/Painters/Faces_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Cut_List_Item.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam/project/Projecet_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Piece_List_view extends StatefulWidget {
  late bool project;

  Piece_List_view(bool project) {
    this.project = project;
  }

  @override
  State<Piece_List_view> createState() => _Piece_List_viewState(project);
}

class _Piece_List_viewState extends State<Piece_List_view> {
  Draw_Controller draw_controller = Get.find();
  Project_Controller project_controller = Get.find();
  late bool project;
  List<Piece_model> pieces = [];

  _Piece_List_viewState(bool project) {
    this.project = project;

    if (project) {
      for (int i = 0; i < project_controller.box_repository.project_model.boxes.length;i++) {

        for (int p = 0;p < project_controller.box_repository.project_model.boxes[i].box_pieces.length; p++) {

          pieces.add(project_controller.box_repository.project_model.boxes[i].box_pieces[p]);

        }
      }
    }
    else {
      pieces = draw_controller.box_repository.box_model.value.box_pieces;
    }

    print(pieces.length);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[100],
        child: Row(
          children: [
            Container(
              width: 300,
              color: Colors.grey[300],
              child: Column(
                children: [
                  Container(
                      height: 70,
                      child: Center(
                          child: Text(
                        !project
                            ? 'List of Box Pieces'
                            : 'List of Project boxes Pieces',
                        style: TextStyle(fontSize: 18),
                      ))),
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                              'to delete any piece from the \n cut list : un check it'))),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(color:Colors.grey[200],
                        height: h - 400,
                        child: project
                            ?

                            ///project pieces
                            ListView.builder(
                                itemCount: pieces.length,
                                itemBuilder: (context, i) {
                                  if (pieces[i].piece_name == 'inner' ||
                                      pieces[i].piece_name.contains('Helper') ||
                                      (pieces[i].is_changed &&
                                          pieces[i]
                                              .piece_name
                                              .contains('drawer'))) {
                                    return SizedBox();
                                  } else {
                                    return Row(
                                      children: [
                                        Checkbox(
                                            value: pieces[i].piece_inable,
                                            onChanged: (v) {
                                              pieces[i].piece_inable =
                                                  !pieces[i].piece_inable;
                                              setState(() {});
                                            }),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(pieces[i].piece_name)
                                      ],
                                    );
                                  }
                                })
                            :

                            /// box pieces
                            ListView.builder(
                                itemCount: pieces.length,
                                itemBuilder: (context, i) {
                                  if (pieces[i].piece_name == 'inner' ||
                                      pieces[i].piece_name.contains('Helper') ||
                                      (pieces[i].is_changed &&
                                          pieces[i]
                                              .piece_name
                                              .contains('drawer'))) {
                                    return SizedBox();
                                  } else {
                                    return Row(
                                      children: [
                                        Checkbox(
                                            value: pieces[i].piece_inable,
                                            onChanged: (v) {
                                              pieces[i].piece_inable =
                                                  !pieces[i].piece_inable;
                                              setState(() {});
                                            }),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(pieces[i].piece_name)
                                      ],
                                    );
                                  }
                                })),
                  ),

                  SizedBox(
                    height: 56,
                  ),

                  ///Export every piece \n  as G_code file
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                            width: 180,
                            child: Text('Export XML files',
                                style: TextStyle(
                                  fontSize: 14,
                                ))),
                        SizedBox(
                          width: 18,
                        ),
                        InkWell(
                            onTap: () {
                              draw_controller.extract_xml_files(project);
                            },
                            child: Icon(
                              Icons.code,
                              size: 24,
                              color: Colors.teal,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),


                  ///Export cut list as excel
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                            width: 180,
                            child: Text('Export cut list as excel ',
                                style: TextStyle(
                                  fontSize: 14,
                                ))),
                        SizedBox(
                          width: 18,
                        ),
                        InkWell(
                            onTap: () {
                              Excel_Controller my_excel = Excel_Controller();
                              my_excel.create_excel(draw_controller
                                  .box_repository.box_model.value.box_name);
                            },
                            child: Icon(
                              Icons.file_open_rounded,
                              size: 24,
                              color: Colors.teal,
                            )),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),




                  ///Export Details sheets as PDF
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                            width: 180,
                            child: Text('Details sheets as   PDF ',
                                style: TextStyle(
                                  fontSize: 14,
                                ))),
                        SizedBox(
                          width: 18,
                        ),
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.picture_as_pdf,
                              size: 24,
                              color: Colors.teal,
                            )),
                      ],
                    ),
                  ),




                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: 600,
              color: Colors.grey[300],
              child: ListView.builder(
                  itemCount: pieces.length,
                  itemBuilder: (context, i) {
                    if (pieces[i].piece_name ==
                            'inner' ||
                        pieces[i].piece_direction ==
                            'help_shelf' ||
                        (pieces[i].is_changed && pieces[i].piece_name.contains('drawer')) ||
                        pieces[i].piece_name
                            .contains("Helper")) {
                      return SizedBox();
                    } else if (pieces[i].piece_inable) {
                      return Column(
                        children: [
                          Container(
                              width: 500,
                              color: Colors.white,
                              height: 700,
                              child: CustomPaint(
                                painter: Faces_Painter(pieces[i]),
                              )),
                          SizedBox(
                            height: 33,
                          )
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
                width: 486,
                color: Colors.grey[300],
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(width: 486, height: 2, color: Colors.black),
                    Container(
                      width: 486,
                      height: 36,
                      color: Colors.white,
                      child:
                      Row(
                        children: [
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 30,
                            child: Center(
                                child: Text(
                              "N",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 140,
                            child: Center(
                                child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              "Material",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              "Thickness",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              "Height",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              "Width",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                          Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              "Quantity",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                            color: Colors.grey[400],
                          ),
                          Container(width: 2, height: 36, color: Colors.black),
                        ],
                      ),
                    ),
                    Container(width: 486, height: 2, color: Colors.black),
                    Container(
                      width: 486,
                      height: h - 300,
                      child:

                      ListView.builder(
                          itemCount: draw_controller
                              .box_repository.cut_list_items.length,
                          itemBuilder: (BuildContext context, int index) {
                            Cut_List_Item p = draw_controller
                                .box_repository.cut_list_items[index];

                            return Column(
                              children: [
                                Container(
                                  width: 486,
                                  // height: 36,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          child: Center(
                                              child: Text("${index + 1}"))),
                                      Container(
                                          width: 140,
                                          child: Center(
                                              child:
                                              Text("${p.pieces_names}"))),
                                      Container(
                                          width: 60,
                                          child: Center(
                                              child:
                                              Text("${p.material_name}"))),
                                      Container(
                                          width: 60,
                                          child: Center(
                                              child: Text(
                                                  "${p.material_thickness}"))),
                                      Container(
                                          width: 60,
                                          child: Center(
                                              child: Text("${p.hight}"))),
                                      Container(
                                          width: 60,
                                          child: Center(
                                              child: Text("${p.width}"))),
                                      Container(
                                          width: 60,
                                          child: Center(
                                              child: Text("${p.quantity}"))),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 486, height: 2, color: Colors.black),
                              ],
                            );
                          })

                      ,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
