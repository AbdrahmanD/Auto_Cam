import 'package:auto_cam/Controller/Draw_Controllers/AnalyzeJoins.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam/Model/Main_Models/Cut_List_Item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cut_List_review extends StatefulWidget {
  const Cut_List_review({Key? key}) : super(key: key);

  @override
  State<Cut_List_review> createState() => _Cut_List_reviewState();
}

class _Cut_List_reviewState extends State<Cut_List_review> {

  bool collect_same_pieces=false;
  Draw_Controller draw_controller = Get.find();
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
            child: Container(width: 330,
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


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [

          Container(width: 300,color: Colors.grey[300],child: Column(children: [
            /// collect same pieces
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [

                  SizedBox(height: 32,),

                  /// collect same pieces
                  Row(children: [
                    Container(
                        width: 180,
                        child: Text("Collect Same Pieces ")),
                    SizedBox(width: 12,),
                    Checkbox(value: collect_same_pieces, onChanged: (v){
                      collect_same_pieces=!collect_same_pieces;
                      AnalyzeJoins analayzejoins = AnalyzeJoins(false,collect_same_pieces);

                      setState(() {

                      });
                    }),


                  ],),

                  SizedBox(height: 32,),
                  /// export excel file
                  ///Export cut list as excel
                  Container(
                    child: Row(
                      children: [

                        Container(
                            width: 180,
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


                ],
              ),
            ),
          ],),),
          Container(
              width: w-350,
              color: Colors.grey[100],
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),


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

    );
  }
}
