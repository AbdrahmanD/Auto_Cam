import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Controller/Painters/Piece_Painter.dart';
import 'package:auto_cam/Controller/Painters/Faces_Painter.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Piece_List_view extends StatefulWidget {
  const Piece_List_view({Key? key}) : super(key: key);

  @override
  State<Piece_List_view> createState() => _Piece_List_viewState();
}

class _Piece_List_viewState extends State<Piece_List_view> {
  Draw_Controller draw_controller = Get.find();

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
                        'List of Pieces',
                        style: TextStyle(fontSize: 22),
                      ))),
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                              'to delete any piece from the cut list : un check it'))),
                  Container(
                    height: h-300,
                    child: ListView.builder(
                        itemCount: draw_controller
                            .box_repository.box_model.value.box_pieces.length,
                        itemBuilder: (context, i) {
                          if (draw_controller.box_repository.box_model.value
                                      .box_pieces[i].piece_name ==
                                  'inner' ||
                              draw_controller.box_repository.box_model.value
                                      .box_pieces[i].piece_name ==
                                  'HELPER'
                              ||(draw_controller.box_repository.box_model.value
                                          .box_pieces[i].is_changed && draw_controller.box_repository.box_model.value
                                          .box_pieces[i].piece_name.contains('drawer'))
                          )
                          {
                            return SizedBox();
                          } else {
                            return Row(
                              children: [
                                Checkbox(
                                    value: draw_controller
                                        .box_repository
                                        .box_model
                                        .value
                                        .box_pieces[i]
                                        .piece_inable,
                                    onChanged: (v) {
                                      draw_controller
                                              .box_repository
                                              .box_model
                                              .value
                                              .box_pieces[i]
                                              .piece_inable =
                                          !draw_controller
                                              .box_repository
                                              .box_model
                                              .value
                                              .box_pieces[i]
                                              .piece_inable;
                                      setState(() {});
                                    }),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(draw_controller.box_repository.box_model
                                    .value.box_pieces[i].piece_name)
                              ],
                            );
                          }
                        }),
                  ),

                  //Export cut list as excel
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

                              Excel_Controller my_excel=Excel_Controller();
                              my_excel.create_excel(draw_controller.box_repository.box_model.value);
// my_excel.create_excel();

                            },
                            child: Icon(
                              Icons.file_open_rounded,
                              size: 36,
                              color: Colors.teal,
                            )),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  //Export every piece \n  as G_code file
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                            width: 180,
                            child: Text('Export every piece \n  as G_code file',
                                style: TextStyle(
                                  fontSize: 14,
                                ))),
                        SizedBox(
                          width: 18,
                        ),
                        InkWell(
                            onTap: () {
                              draw_controller.extract_xml_files();
                            },
                            child: Icon(
                              Icons.code,
                              size: 36,
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
                  itemCount: draw_controller
                      .box_repository.box_model.value.box_pieces.length,
                  itemBuilder: (context, i) {
                    if (draw_controller.box_repository.box_model.value
                                .box_pieces[i].piece_name ==
                            'inner' ||
                        draw_controller.box_repository.box_model.value
                                .box_pieces[i].piece_direction ==
                            'help_shelf'||(
                        draw_controller.box_repository.box_model.value
                            .box_pieces[i].is_changed && draw_controller.box_repository.box_model.value
                            .box_pieces[i].piece_name.contains('drawer'))
                        ||
                        draw_controller.box_repository.box_model.value
                            .box_pieces[i].piece_name ==
                            'HELPER') {
                      return SizedBox();
                    } else if (draw_controller.box_repository.box_model.value
                        .box_pieces[i].piece_inable) {
                      return Column(
                        children: [
                          Container(
                              width: 500,
                              color: Colors.white,
                              height: 700,
                              child: CustomPaint(
                                painter: Faces_Painter(draw_controller
                                    .box_repository
                                    .box_model
                                    .value
                                    .box_pieces[i]),
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
                      child: Row(
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
                      child: ListView.builder(
                          itemCount: draw_controller
                              .box_repository.box_model.value.box_pieces.length,
                          itemBuilder: (BuildContext context, int index) {
                            Piece_model p = draw_controller.box_repository
                                .box_model.value.box_pieces[index];

                            if (p.piece_name == "inner" ||p.piece_name == "HELPER" || p.piece_name == "help_shelf" || p.is_changed || !p.piece_inable) {
                              return SizedBox();
                            } else {
                              return Column(
                                children: [
                                  Container(
                                    width: 486,
                                    height: 36,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                        Container(
                                            width: 30,
                                            child: Center(
                                                child: Text("${p.piece_id}"))),
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                        Container(
                                            width: 140,
                                            child: Center(
                                                child:
                                                    Text("${p.piece_name}"))),
                                        Container(
                                            width: 2,
                                            height: 100,
                                            color: Colors.black),
                                        Container(
                                            width: 60,
                                            child: Center(
                                                child: Text(
                                                    "${p.material_name}"))),
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                        Container(
                                            width: 60,
                                            child: Center(
                                                child: Text(
                                                    "${p.piece_thickness}"))),
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                        Container(
                                            width: 60,
                                            child: Center(
                                                child:
                                                    Text("${p.piece_height}"))),
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                        Container(
                                            width: 60,
                                            child: Center(
                                                child:
                                                    Text("${p.piece_width}"))),
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                        Container(
                                            width: 60,
                                            child: Center(
                                                child:
                                                Text("1"))),
                                        Container(
                                            width: 2,
                                            height: 36,
                                            color: Colors.black),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 486,
                                      height: 2,
                                      color: Colors.black),
                                ],
                              );
                            }
                            return SizedBox();
                          }),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
