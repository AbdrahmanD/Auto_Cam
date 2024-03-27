import 'package:auto_cam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam/Model/Main_Models/Box_Pieces_Arrang.dart';
import 'package:auto_cam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam/Model/Main_Models/Group_model.dart';
import 'package:auto_cam/Model/Main_Models/Piece_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Box_Pieces_List extends StatefulWidget {

  late Box_model b;

  Box_Pieces_List(this.b);

  @override
  State<Box_Pieces_List> createState() => _Box_Pieces_ListState(b);
}

class _Box_Pieces_ListState extends State<Box_Pieces_List> {

late Box_model b;


_Box_Pieces_ListState(this.b);

  Box_Repository box_repository = Get.find();

  late Box_Pieces_Arrang box_pieces_arrang;

  List<Piece_model> body=[];
  List<Piece_model> shelves=[];
  List<Piece_model> partitions=[];
  List<Piece_model> doors=[];
  List<List<Group_model>> drawers=[];
  List<Piece_model> supports=[];
  List<Piece_model> back_panels=[];

  List<bool> bool_body=[];
  List<bool> bool_shelves=[];
  List<bool> bool_partitions=[];
  List<bool> bool_doors=[];
  List<bool> bool_drawers=[];
  List<bool> bool_supports=[];
  List<bool> bool_back_panels=[];



  bool expand_box=false;
  bool expand_body=false;
  bool expand_shelves=false;
  bool expand_partitions=false;
  bool expand_doors=false;
  bool expand_drawers=false;
  bool expand_supports=false;
  bool expand_back_panels=false;


  double height_body=24;
  double height_shelves=24;
  double height_partitions=24;
  double height_doors=24;
  double height_drawers=24;
  double height_supports=24;
  double height_back_panels=24;

  refresh(){

    height_body=24;
    height_shelves=24;
    height_partitions=24;
    height_doors=24;
    height_drawers=24;
    height_supports=24;
    height_back_panels=24;

    for(int i=0;i<body.length;i++){if(bool_body[i]){height_body+=120;}else{height_body+=24;}}
    for(int i=0;i<shelves.length;i++){if(bool_shelves[i]){height_shelves+=120;}else{height_shelves+=24;}}
    for(int i=0;i<partitions.length;i++){if(bool_partitions[i]){height_partitions+=120;}else{height_partitions+=24;}}
    for(int i=0;i<doors.length;i++){if(bool_doors[i]){height_doors+=120;}else{height_doors+=24;}}
    for(int i=0;i<drawers.length;i++){if(bool_drawers[i]){height_drawers+=120;}else{height_drawers+=24;}}
    for(int i=0;i<supports.length;i++){if(bool_supports[i]){height_supports+=120;}else{height_supports+=24;}}
    for(int i=0;i<back_panels.length;i++){if(bool_back_panels[i]){height_back_panels+=120;}else{height_back_panels+=24;}}








    setState(() {

    });
  }


  my_initState() {

    box_pieces_arrang = box_repository.arrange_box(b);

    body=box_pieces_arrang.body;
    shelves=box_pieces_arrang.shelves;
    partitions=box_pieces_arrang.partitions;
    doors=box_pieces_arrang.doors;
    drawers=box_pieces_arrang.drawers;
    supports=box_pieces_arrang.supports;
    back_panels=box_pieces_arrang.back_panels;

    for(int i=0;i<box_pieces_arrang.body.length;i++){bool_body.add(false);}
    for(int i=0;i<box_pieces_arrang.shelves.length;i++){bool_shelves.add(false);}
    for(int i=0;i<box_pieces_arrang.partitions.length;i++){bool_partitions.add(false);}
    for(int i=0;i<box_pieces_arrang.doors.length;i++){bool_doors.add(false);}
    for(int i=0;i<box_pieces_arrang.drawers.length;i++){bool_drawers.add(false);}
    for(int i=0;i<box_pieces_arrang.supports.length;i++){bool_supports.add(false);}
    for(int i=0;i<box_pieces_arrang.back_panels.length;i++){bool_back_panels.add(false);}

    refresh();

  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    my_initState();


    return
      Container(
          width: 264, height: h-200,
          // color: Colors.teal[100],
child:
ListView(
  children: [
    Row(children: [
      SizedBox(width: 6,),
      Container(width: 32,height: 32,
        child: InkWell(onTap: (){

          if(expand_box){
            expand_box=false;
            expand_body=false;
            expand_shelves=false;
            expand_partitions=false;
            expand_doors=false;
            expand_drawers=false;
            expand_supports=false;
          }
          else{
            expand_box=true;
          }

         setState(() {});},
            child: Icon(!expand_box ? Icons.add_circle_outline:Icons.remove_circle_outline ,
              color: expand_box?Colors.red:Colors.teal, size: 18,)
        ),
      ),
      SizedBox(width: 6,),
      Text(box_repository.box_model.value.box_name),
    ],),


    /// box items

    /// box body
    expand_box? Column(
      children: [

        /// body pieces
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_body=!expand_body;
            setState(() {});},
                child: Icon(

                  !expand_body ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_body?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("Box Body"),
        ],),
        expand_body?Container(height:height_body,


          child: ListView.builder(
            itemCount: body.length,
            itemBuilder: (context,i){

              bool expand_item=bool_body[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 190,
                    height: expand_item?120:24,
                    child: Column(
                      children: [
                        Row(
              children:
              [
                          SizedBox(width: 32,),

                          Container(width: 24,height: 24,
                            child: InkWell(onTap: (){

                              bool_body[i]=!bool_body[i];
                              refresh();
                              },
                                child: Icon(

                                  !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                  color: expand_item?Colors.red:Colors.teal, size: 18,)
                            ),
                          ),
                          SizedBox(width: 6,),

                          Text(body[i].piece_name),

                          Container(height: 24,
                            child: Checkbox(value: body[i].piece_inable,
                                onChanged: (v){
                              body[i].piece_inable=!body[i].piece_inable;
                              box_repository.enable_Piece(body[i], body[i].piece_inable);

                              setState(() {

                            });}),
                          )

                        ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 163,
                          height: expand_item?96:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("width ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${body[i].piece_width}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("height ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${body[i].piece_height}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("thickness",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${body[i].piece_thickness}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("material ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${body[i].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                     ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),

    /// box shelves
    (expand_box && shelves.length>0)? Column(
      children: [

        /// shelves
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_shelves=!expand_shelves;
            setState(() {});},
                child: Icon(

                  !expand_shelves ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_shelves?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("shelves"),
        ],),
        expand_shelves?Container(

          height:height_shelves,

          child: ListView.builder(
            itemCount: shelves.length,
            itemBuilder: (context,i){

              bool expand_item=bool_shelves[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 190,
                    height: expand_item?120:24,
                    child: Column(
                      children: [
                        Row(
                          children:
                          [
                            SizedBox(width: 32,),

                            Container(width: 24,height: 24,
                              child: InkWell(onTap: (){

                                bool_shelves[i]=!bool_shelves[i];
                                refresh();
                              },
                                  child: Icon(

                                    !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                    color: expand_item?Colors.red:Colors.teal, size: 18,)
                              ),
                            ),
                            SizedBox(width: 6,),

                            Text(shelves[i].piece_name),

                            Container(height: 24,
                              child: Checkbox(value: shelves[i].piece_inable,
                                  onChanged: (v){

                                    shelves[i].piece_inable=!shelves[i].piece_inable;

                                    box_repository.enable_Piece(shelves[i], shelves[i].piece_inable);

                                    setState(() {

                                    });}),
                            )

                          ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 163,
                          height: expand_item?96:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("width ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${shelves[i].piece_width}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("height ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${shelves[i].piece_height}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("thickness",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${shelves[i].piece_thickness}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("material ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${shelves[i].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                      ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),


    /// box partitions
    (expand_box&& partitions.length>0)? Column(
      children: [

        /// partitions
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_partitions=!expand_partitions;
            setState(() {});},
                child: Icon(

                  !expand_partitions ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_partitions?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("Partitions"),
        ],),
        expand_partitions?Container(height:height_partitions,


          child: ListView.builder(
            itemCount: partitions.length,
            itemBuilder: (context,i){

              bool expand_item=bool_partitions[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 190,
                    height: expand_item?120:24,
                    child: Column(
                      children: [
                        Row(
                          children:
                          [
                            SizedBox(width: 32,),

                            Container(width: 24,height: 24,
                              child: InkWell(onTap: (){

                                bool_partitions[i]=!bool_partitions[i];
                                refresh();
                              },
                                  child: Icon(

                                    !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                    color: expand_item?Colors.red:Colors.teal, size: 18,)
                              ),
                            ),
                            SizedBox(width: 6,),

                            Text(partitions[i].piece_name),

                            Container(height: 24,
                              child: Checkbox(value: partitions[i].piece_inable,
                                  onChanged: (v){
                                    partitions[i].piece_inable=!partitions[i].piece_inable;
                                    box_repository.enable_Piece(partitions[i], partitions[i].piece_inable);

                                    box_repository.box_model.value.box_pieces.firstWhere((element) => element.piece_id==partitions[i].piece_id).piece_inable= partitions[i].piece_inable;

                                    setState(() {

                                    });
                              }),
                            )

                          ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 163,
                          height: expand_item?96:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("width ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${partitions[i].piece_width}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("height ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${partitions[i].piece_height}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("thickness",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${partitions[i].piece_thickness}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("material ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${partitions[i].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                      ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),

    /// box doors
    (expand_box&& doors.length>0)? Column(
      children: [

        /// Doors
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_doors=!expand_doors;
            setState(() {});},
                child: Icon(

                  !expand_doors ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_doors?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("Doors"),
        ],),
        expand_doors?Container(height:height_doors,


          child: ListView.builder(
            itemCount: doors.length,
            itemBuilder: (context,i){

              bool expand_item=bool_doors[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 230,
                    height: expand_item?144:24,
                    child: Column(
                      children: [
                        Row(
                          children:
                          [
                            SizedBox(width: 32,),

                            Container(width: 24,height: 24,
                              child: InkWell(onTap: (){

                                bool_doors[i]=!bool_doors[i];
                                refresh();
                              },
                                  child: Icon(

                                    !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                    color: expand_item?Colors.red:Colors.teal, size: 18,)
                              ),
                            ),
                            SizedBox(width: 6,),

                            Text(doors[i].piece_name),

                            Container(height: 24,
                              child: Checkbox(value: doors[i].piece_inable,
                                  onChanged: (v){
                                    doors[i].piece_inable=!doors[i].piece_inable;
                                    box_repository.enable_Piece(doors[i], doors[i].piece_inable);

                                    box_repository.box_model.value.box_pieces.firstWhere((element) => element.piece_id==doors[i].piece_id).piece_inable= doors[i].piece_inable;

                                    setState(() {

                                    });
                                  }),
                            )

                          ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 200,
                          height: expand_item?120:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("direction ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${doors[i].piece_name}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("width ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${doors[i].piece_width}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("height ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${doors[i].piece_height}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("thickness",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${doors[i].piece_thickness}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("material ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${doors[i].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                      ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),


    /// box drawers
    (expand_box&& drawers.length>0)? Column(
      children: [

        /// Drawers
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_drawers=!expand_drawers;
            setState(() {});},
                child: Icon(

                  !expand_drawers ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_drawers?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("Drawers"),
        ],),
        expand_drawers?Container(height:height_drawers,


          child: ListView.builder(
            itemCount: drawers.length,
            itemBuilder: (context,i){

              bool expand_item=bool_drawers[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 230,
                    height: expand_item?120:24,
                    child: Column(
                      children: [
                        Row(
                          children:
                          [
                            SizedBox(width: 32,),

                            Container(width: 24,height: 24,
                              child: InkWell(onTap: (){

                                bool_drawers[i]=!bool_drawers[i];
                                refresh();
                              },
                                  child: Icon(

                                    !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                    color: expand_item?Colors.red:Colors.teal, size: 18,)
                              ),
                            ),
                            SizedBox(width: 6,),

                            Text("Drawer gorup : ${i+1}"),

                            Container(height: 24,
                              child: Checkbox(
                                  value: drawers[i][0].group_enable,
                                  onChanged: (v){
                                    drawers[i][0].group_enable=!drawers[i][0].group_enable;
                                    int group_id=double.parse("1").toInt();
                                    // box_repository.box_model.value.box_groups[group_id].pieces[i].piece_inable=drawers[i].group_enable;
                                    print("group_id : $group_id / drawer :${i}");

                                    setState(() {

                                    });
                                  }),
                            )

                          ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 196,
                          height: expand_item?96:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 70,child: Text(style: TextStyle(fontSize: 12),"${drawers[i][0].group_name}"))],),
                              // Row(children: [SizedBox(width: 64,),Container(height: 24,width: 48,child: Text("face ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${drawers[i].pieces[0].material_name}")],),
                              // Row(children: [SizedBox(width: 64,),Container(height: 24,width: 48,child: Text("box ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${drawers[i].pieces[1].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                      ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),

    /// box supports
    (expand_box&& supports.length>0)? Column(
      children: [

        /// supports
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_supports=!expand_supports;
            setState(() {});},
                child: Icon(

                  !expand_supports ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_supports?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("Supports"),
        ],),
        expand_supports?Container(height:height_supports,


          child: ListView.builder(
            itemCount: supports.length,
            itemBuilder: (context,i){

              bool expand_item=bool_supports[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 190,
                    height: expand_item?120:24,
                    child: Column(
                      children: [
                        Row(
                          children:
                          [
                            SizedBox(width: 32,),

                            Container(width: 24,height: 24,
                              child: InkWell(onTap: (){

                                bool_supports[i]=!bool_supports[i];
                                refresh();
                              },
                                  child: Icon(

                                    !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                    color: expand_item?Colors.red:Colors.teal, size: 18,)
                              ),
                            ),
                            SizedBox(width: 6,),

                            Text(supports[i].piece_name),

                            Container(height: 24,
                              child: Checkbox(value: supports[i].piece_inable,
                                  onChanged: (v){
                                    supports[i].piece_inable=!supports[i].piece_inable;
                                    box_repository.enable_Piece(supports[i], supports[i].piece_inable);

                                    box_repository.box_model.value.box_pieces.firstWhere((element) => element.piece_id==supports[i].piece_id).piece_inable= supports[i].piece_inable;

                                    setState(() {

                                    });
                                  }),
                            )

                          ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 163,
                          height: expand_item?96:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("width ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${supports[i].piece_width}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("height ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${supports[i].piece_height}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("thickness",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${supports[i].piece_thickness}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("material ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${supports[i].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                      ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),

    /// box back_panels
    (expand_box&& back_panels.length>0)? Column(
      children: [

        /// back_panels
        Row(children: [
          SizedBox(width: 26,),
          Container(width: 24,height: 24,
            child: InkWell(onTap: (){expand_back_panels=!expand_back_panels;
            setState(() {});},
                child: Icon(

                  !expand_back_panels ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                  color: expand_back_panels?Colors.red:Colors.teal, size: 18,)
            ),
          ),
          SizedBox(width: 6,),
          Text("Back Panels"),
        ],),
        expand_back_panels?Container(height:height_back_panels,


          child: ListView.builder(
            itemCount: back_panels.length,
            itemBuilder: (context,i){

              bool expand_item=bool_back_panels[i];

              return Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 26,),

                  /// each item details
                  Container(width: 190,
                    height: expand_item?120:24,
                    child: Column(
                      children: [
                        Row(
                          children:
                          [
                            SizedBox(width: 32,),

                            Container(width: 24,height: 24,
                              child: InkWell(onTap: (){

                                bool_back_panels[i]=!bool_back_panels[i];
                                refresh();
                              },
                                  child: Icon(

                                    !expand_item ? Icons.add_circle_outline:Icons.remove_circle_outline ,
                                    color: expand_item?Colors.red:Colors.teal, size: 18,)
                              ),
                            ),
                            SizedBox(width: 6,),

                            Text(back_panels[i].piece_name),

                            Container(height: 24,
                              child: Checkbox(value: back_panels[i].piece_inable,
                                  onChanged: (v){
                                    back_panels[i].piece_inable=!back_panels[i].piece_inable;
                                    box_repository.enable_Piece(back_panels[i], back_panels[i].piece_inable);

                                    box_repository.box_model.value.box_pieces.firstWhere((element) => element.piece_id==back_panels[i].piece_id).piece_inable= back_panels[i].piece_inable;

                                    setState(() {

                                    });
                                  }),
                            )

                          ],mainAxisAlignment: MainAxisAlignment.start,
                        ),

                        Container(width: 163,
                          height: expand_item?96:0,
                          child: expand_item?Column(
                            children: [
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("width ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${back_panels[i].piece_width}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("height ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${back_panels[i].piece_height}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("thickness",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${back_panels[i].piece_thickness}")],),
                              Row(children: [SizedBox(width: 64,),Container(height: 24,width: 58,child: Text("material ",style: TextStyle(fontSize: 12),)),Text(style: TextStyle(fontSize: 12),"${back_panels[i].material_name}")],),
                            ],
                          ):SizedBox(),
                        )
                      ],
                    ),
                  ),

                  /// //////////////
                ],
              );
            },
          ),
        ):SizedBox(),



      ],
    ):SizedBox(),



  ],
)

      );
  }

}

