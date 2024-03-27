import 'package:auto_cam/Controller/Draw_Controllers/AnalyzeJoins.dart';
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
      for (int i = 0; i <
          project_controller.box_repository.project_model.boxes.length; i++) {
        for (int p = 0; p <
            project_controller.box_repository.project_model.boxes[i].box_pieces
                .length; p++) {
          pieces.add(project_controller.box_repository.project_model.boxes[i]
              .box_pieces[p]);
        }
      }
    }
    else {
      pieces = draw_controller.box_repository.box_model.value.box_pieces;
    }

    // print(pieces.length);
  }

  TextEditingController quantity_controller = TextEditingController();


  Widget quantity_dialog() {
    Widget widget = Container(width: 400, height: 300,
      child:
      Column(
        children: [
          SizedBox(height: 32,),

          Text("add the quantity of this item or project",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quantity : ",
                style: TextStyle(fontSize: 16),
              ),
              Container(width: 200,
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: quantity_controller,
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
            ],
          ),
          SizedBox(height: 24,),

          InkWell(
            onTap: () {
              int quantity = double.parse(quantity_controller.text.toString())
                  .toInt();
              Excel_Controller my_excel = Excel_Controller();
              my_excel.create_excel(quantity);
              Navigator.of(Get.overlayContext!).pop();
            },
            child: Container(width: 200,
              height: 65,
              color: Colors.teal[200],
              child: Center(child:
              Text("Export Excel file",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              )),),
          )

        ],
      ),

    );


    return widget;
  }


  double material_size_1 = 0;
  double material_size_2 = 0;
  double material_size_3 = 0;


  double material_thickness_1 = 0;
  double material_thickness_2 = 0;
  double material_thickness_3 = 0;

  bool collect_same_pieces=false;
  @override
  void initState() {
    calc_size();
  }

  calc_size() async {

    material_size_1 = 0;
    material_size_2 = 0;
    material_size_3 = 0;



    List<Cut_List_Item> p = await draw_controller.box_repository.cut_list_items;

    material_thickness_1=p[0].material_thickness;

    for(int i=1;i<p.length;i++){
      if(
      material_thickness_2==0 &&
          p[i].material_thickness!=material_thickness_1
      ){
        material_thickness_2=p[i].material_thickness;
      }
      else
        if(
        material_thickness_3==0 &&
          p[i].material_thickness!=material_thickness_1 &&
          p[i].material_thickness!=material_thickness_2
        )
      {
        material_thickness_3=p[i].material_thickness;

      }

    }


    for(int i=0;i<p.length;i++){

      double value=double.parse(((p[i].width/1000)*(p[i].hight/1000)*(p[i].quantity)).toStringAsFixed(2));

      if(material_thickness_1==p[i].material_thickness){
        material_size_1+=value;
      }else if(material_thickness_2==p[i].material_thickness){
        material_size_2+=value;

      }else if(material_thickness_3==p[i].material_thickness){
        material_size_3+=value;
      }




      material_size_1=double.parse("${material_size_1.toStringAsFixed(2)}");
      material_size_2=double.parse("${material_size_2.toStringAsFixed(2)}");
      material_size_3=double.parse("${material_size_3.toStringAsFixed(2)}");


    setState(() {

    });


  }}


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
              width: 250,
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
                    child: Container(color:Colors.grey[100],
                        height: 350,
                        child: project
                            ?

                            ///project pieces
                            ListView.builder(
                                itemCount: pieces.length,
                                itemBuilder: (context, i) {
                                  if (pieces[i].piece_name.contains("inner") ||
                                   pieces[i].piece_thickness==0||
                                      pieces[i].piece_name.contains('Helper') ||
                                      (pieces[i]
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
                                  if (pieces[i].piece_name.contains("inner") ||
                                      pieces[i].piece_thickness==0||

                                      pieces[i].piece_name.contains('Helper') ||
                                      ( pieces[i]
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
                            width: 150,
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
                            width: 150,
                            child: Text('Export cut list as excel ',
                                style: TextStyle(
                                  fontSize: 14,
                                ))),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          child: InkWell(
                              onTap: () {
                                // Excel_Controller my_excel = Excel_Controller();
                                // my_excel.create_excel();
                                Get.dialog(Dialog(
                                    child:quantity_dialog()));

                              },
                              child: Icon(
                                Icons.file_open_rounded,
                                size: 24,
                                color: Colors.teal,
                              )),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),



                  SizedBox(
                    height: 12,
                  ),

                  /// size 1
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "${material_thickness_1} mm  :",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${material_size_1}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Text(
                        "m2",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 12,
                  ),

                  /// size 2
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "${material_thickness_2} mm  :",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${material_size_2}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Text(
                        "m2",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  /// size 3
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "${material_thickness_3} mm  :",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${material_size_3}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Text(
                        "m2",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),


                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: 550,
              color: Colors.grey[300],
              child: ListView.builder(
                  itemCount: pieces.length,
                  itemBuilder: (context, i) {
                    if (pieces[i].piece_name.contains("inner") ||
                        pieces[i].piece_thickness==0||

                        pieces[i].piece_direction ==
                            'help_shelf' ||
                        (pieces[i].piece_name.contains('drawer')) ||
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
                width: 450,
                color: Colors.grey[300],
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),

                    /// collect same pieces
                    Row(children: [
                      Text("Collect Same Pieces "),
                      SizedBox(width: 12,),
                      Checkbox(value: collect_same_pieces, onChanged: (v){
                        collect_same_pieces=!collect_same_pieces;
                        AnalyzeJoins analayzejoins = AnalyzeJoins(project,collect_same_pieces);

                        setState(() {

});
                      }),


                    ],),
                    SizedBox(
                      height: 12,
                    ),
                    Container(width: 450, height: 2, color: Colors.black),
                    Container(
                      width: 450,
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
                            width: 100,
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
                    Container(width: 450, height: 2, color: Colors.black),
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
                                  width: 450,
                                  // height: 36,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          child: Center(
                                              child: Text("${index + 1}"))),
                                      Container(
                                          width: 120,
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
                                    width: 450, height: 2, color: Colors.black),
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

