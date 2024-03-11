import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Flexible_Shelf_Pattern_Painter.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Flixable_Shelf_Editor extends StatefulWidget {
  const Flixable_Shelf_Editor({Key? key}) : super(key: key);

  @override
  State<Flixable_Shelf_Editor> createState() => _Flixable_Shelf_EditorState();
}

class _Flixable_Shelf_EditorState extends State<Flixable_Shelf_Editor> {

  TextEditingController category_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController mini_distence_controller = TextEditingController();
  TextEditingController max_distence_controller = TextEditingController();

  TextEditingController Flexible_Shelf_A_controller = TextEditingController();
  TextEditingController Flexible_Shelf_B_controller = TextEditingController();
  TextEditingController Flexible_Shelf_C_controller = TextEditingController();
  TextEditingController Flexible_Shelf_Depth_controller = TextEditingController();
  TextEditingController Flexible_Shelf_Diameter_controller = TextEditingController();
  TextEditingController Flexible_Shelf_Quantity_controller = TextEditingController();



  List<JoinHolePattern> list_Flexible_Shelves = [];
  List<Bore_unit> Flexible_Shelf_units = [];


  Draw_Controller draw_controller = Get.find();

  int corrent_pattern=0;

  double min_length = 0;
  double max_length = 0;

  read_patterns() async {

    await draw_controller.read_pattern_files();

    Map<String, List<JoinHolePattern>> join_patterns =
        draw_controller.box_repository.join_patterns;

    list_Flexible_Shelves = join_patterns["Flexible_Shelves"]!;

    corrent_pattern=0;

   refresh();


  }


  refresh(){

    if (corrent_pattern!=100) {

      min_length=list_Flexible_Shelves[corrent_pattern]. min_length;
      max_length=list_Flexible_Shelves[corrent_pattern]. max_length;
      category_controller.text="Flexible_Shelves";
      name_controller.text="${list_Flexible_Shelves[corrent_pattern].name}";
      mini_distence_controller.text="${list_Flexible_Shelves[corrent_pattern].min_length}";
      max_distence_controller.text="${list_Flexible_Shelves[corrent_pattern].max_length}";

      Flexible_Shelf_A_controller.text="${list_Flexible_Shelves[corrent_pattern].bores[0].pre_distence}";
      Flexible_Shelf_B_controller.text="${list_Flexible_Shelves[corrent_pattern].bores[0].correct_y}";
      Flexible_Shelf_C_controller.text="${
          (list_Flexible_Shelves[corrent_pattern].bores.length>1)?
          (
              list_Flexible_Shelves[corrent_pattern].bores[0].correct_y-
              list_Flexible_Shelves[corrent_pattern].bores[1].correct_y
          )
              :0
      }";
      Flexible_Shelf_Depth_controller.text="${list_Flexible_Shelves[corrent_pattern].bores[0].face_bore.depth}";
      Flexible_Shelf_Diameter_controller.text="${list_Flexible_Shelves[corrent_pattern].bores[0].face_bore.diameter}";
      Flexible_Shelf_Quantity_controller.text="${list_Flexible_Shelves[corrent_pattern].bores.length}";

      Flexible_Shelf_units=list_Flexible_Shelves[corrent_pattern].bores;
    }


    setState(() {

    });
  }



  add_new_pattern(){

    corrent_pattern=100;
    Flexible_Shelf_units=[];

    name_controller.text="0";
    mini_distence_controller.text="0";
    max_distence_controller.text="0";
    Flexible_Shelf_A_controller.text="0";
    Flexible_Shelf_B_controller.text="0";
    Flexible_Shelf_C_controller.text="0";
    Flexible_Shelf_Depth_controller.text="0";
    Flexible_Shelf_Diameter_controller.text="0";
    Flexible_Shelf_Quantity_controller.text="0";

setState(() {

});

  }

  preview_Flexible_shelf_pattern() {


    double Shelf_A = double.parse(Flexible_Shelf_A_controller.text.toString());
    double Shelf_B = double.parse(Flexible_Shelf_B_controller.text.toString()) +
        draw_controller.box_repository.box_model.value.init_material_thickness /
            2;
    double Shelf_C = double.parse(Flexible_Shelf_C_controller.text.toString());
    double Depth =
    double.parse(Flexible_Shelf_Depth_controller.text.toString());
    double Diameter =
    double.parse(Flexible_Shelf_Diameter_controller.text.toString());
    double Quantity =
    double.parse(Flexible_Shelf_Quantity_controller.text.toString());

    Bore_model bore_model = Bore_model(Point_model(0, 0, 0), Diameter, Depth);
    Bore_model emety_bore = Bore_model(Point_model(0, 0, 0), 0, 0);

    if (Quantity == 1) {
      Bore_unit bore_unit = Bore_unit(Shelf_A, 0, Shelf_B, emety_bore, false, 0,
          emety_bore, bore_model, false, true);
      Flexible_Shelf_units.add(bore_unit);
    } else if (Quantity % 2 == 0) {
      for (int i = 0; i < Quantity; i++) {
        Bore_unit bore_unit_1 = Bore_unit(
            Shelf_A,
            0,
            Shelf_B + ((Quantity / 2 - 1) * Shelf_C) - i * Shelf_C,
            emety_bore,
            false,
            0,
            emety_bore,
            bore_model,
            false,
            true);
        Flexible_Shelf_units.add(bore_unit_1);
      }
    } else if (Quantity % 2 != 0) {
      Bore_unit bore_unit_0 = Bore_unit(Shelf_A, 0, Shelf_B, emety_bore, false,
          0, emety_bore, bore_model, false, true);
      Flexible_Shelf_units.add(bore_unit_0);

      for (int i = 1; i < (Quantity) / 2; i++) {
        Bore_unit bore_unit_1 = Bore_unit(Shelf_A, 0, Shelf_B + -i * Shelf_C,
            emety_bore, false, 0, emety_bore, bore_model, false, true);
        Bore_unit bore_unit_2 = Bore_unit(Shelf_A, 0, Shelf_B + i * Shelf_C,
            emety_bore, false, 0, emety_bore, bore_model, false, true);
        Flexible_Shelf_units.add(bore_unit_1);
        Flexible_Shelf_units.add(bore_unit_2);
      }
    }
  }


  save_pattern()async{
    JoinHolePattern drawer_joinHolePattern = JoinHolePattern(
        name_controller.text.toString(),
        min_length,
        max_length,0,0,
        Flexible_Shelf_units,
        true);

    await draw_controller.save_joinHolePattern(
        drawer_joinHolePattern, "Flexible_Shelves");

    await draw_controller.read_pattern_files();

    read_patterns();

  }

  delete_pattern()async{

    await  draw_controller.delete_joinHolePattern(list_Flexible_Shelves[corrent_pattern],"Flexible_Shelves");
    list_Flexible_Shelves.removeAt(corrent_pattern);
    read_patterns();


  }

  @override
  void initState() {

    read_patterns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(),

      body: Row(
        children: [

          Column(
            children: [
              Container(width: 200,height: h-156,
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: ListView.builder(
                        itemCount: list_Flexible_Shelves.length,
                        itemBuilder: (context, i) {

                          bool corrent = (corrent_pattern == i);
                          bool enable_pattern =
                              list_Flexible_Shelves[i].pattern_enable;
                          String pattern_name = list_Flexible_Shelves[i].name;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 200,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: enable_pattern,
                                      onChanged: (v) {
                                        // list_Flexible_Shelves =
                                        // list_Flexible_Shelves[i];
                                        // corrent_join_pattern_id = i;
                                        // selected_pattern = i;
                                        // setState(() {});
                                        // enable_or_diable_pattern();
                                      }),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      corrent_pattern=i;
                                      refresh();
                                      },
                                    child: Container(
                                      width: corrent ? 140 : 80,
                                      color: corrent
                                          ? Colors.teal[200]
                                          : Colors.grey[100],
                                      child: Center(
                                        child: Text(
                                          "$pattern_name",
                                          style: TextStyle(
                                              fontSize: corrent ? 20 : 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
              ),
              Container(height: 100,width:200,                  color: Colors.grey[100],
                child: InkWell(
                onTap: (){
                  add_new_pattern();
                },child: Icon(Icons.add,size: 32,),
              ),)
            ],
          ),

          Container(

              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 32,
                    ),

                    /// pattern category
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Center(
                            child: Text(
                              'pattern category',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          child: TextFormField(
                            controller: category_controller,
                            style: TextStyle(fontSize: 12),
                            onChanged: (_) {},
                            enabled: false,
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
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    /// pattern name
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Center(
                            child: Text(
                              'pattern name',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          child: TextFormField(
                            controller: name_controller,
                            style: TextStyle(fontSize: 12),
                            onChanged: (_) {},
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
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    /// minimum length
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'Minimum length',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: mini_distence_controller,
                            style: TextStyle(fontSize: 12),
                            onChanged: (_) {
                              refresh();
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
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    /// maximum length
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'Maximum length',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: max_distence_controller,
                            style: TextStyle(fontSize: 12),
                            onChanged: (_) {
                              refresh();
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
                      ],
                    ),

                    /// DIVIDER
                    /// DIVIDER
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 2,
                        width: 300,
                        color: Colors.grey,
                      ),
                    ),

                    /// Pre Distance
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Center(
                              child: Text(
                                'Pre Distance (A)',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: Flexible_Shelf_A_controller,
                            onChanged: (_) {},
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
                      ],
                    ),

                    /// hole distance : B
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'B',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: Flexible_Shelf_B_controller,
                            onChanged: (_) {},
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
                      ],
                    ),

                    ///C
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'C',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: Flexible_Shelf_C_controller,
                            onChanged: (_) {},
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
                      ],
                    ),

                    // ///D
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 100,
                    //       height: 35,
                    //       child: Center(
                    //         child: Text(
                    //           'Quantity',
                    //           style: TextStyle(fontSize: 12),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 12,
                    //     ),
                    //     Container(
                    //       width: 75,
                    //       height: 25,
                    //       child: TextFormField(
                    //         keyboardType: TextInputType.number,
                    //         inputFormatters: [DecimalTextInputFormatter(2)],
                    //         controller: face_depth_controller,
                    //         onChanged: (_) {},
                    //         validator: (d) {
                    //           if (d!.isEmpty) {
                    //             return 'add value please';
                    //           }
                    //         },
                    //         decoration: InputDecoration(
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    ///Quantity
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'Quantity',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: Flexible_Shelf_Quantity_controller,
                            onChanged: (_) {},
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
                      ],
                    ),

                    ///  Diameter
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'Diameter',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: Flexible_Shelf_Diameter_controller,
                            onChanged: (_) {},
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
                      ],
                    ),

                    /// Depth
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              'Depth',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 75,
                          height: 25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: Flexible_Shelf_Depth_controller,
                            onChanged: (_) {},
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
                      ],
                    ),

                    // /// have mirror
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 100,
                    //       height: 35,
                    //       child: Center(
                    //         child: Text(
                    //           'have mirror??',
                    //           style: TextStyle(fontSize: 12),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 12,
                    //     ),
                    //     Checkbox(
                    //         value: have_mirror,
                    //         onChanged: (v) {
                    //           have_mirror = !have_mirror;
                    //
                    //           setState(() {});
                    //         }),
                    //   ],
                    // ),


                    SizedBox(
                      height: 12,
                    ),

                    /// preview_Flexible_shelf_pattern
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      InkWell(
                        onTap: () {
                          preview_Flexible_shelf_pattern();
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'preview pattern',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    /// save pattern
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          save_pattern();
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'save pattern',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    /// delete pattern
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          delete_pattern();
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.redAccent[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                                'delete pattern',
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              )
          ),

          Expanded(child:
          Column(
            children: [
              ///photo
              Container(
                height: 270,
                child: Image.asset("lib/assets/images/flexible_shelf.png"),
              ),

              ///divider
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  height: 2,
                  width: 300,
                  color: Colors.grey,
                ),
              ),

              Container(
                height: 400,
                width: 500,
                color: Colors.grey[100],
                child: CustomPaint(
                  painter: Flexible_Shelf_Pattern_Painter(
                      Flexible_Shelf_units,
                      draw_controller
                          .box_repository.box_model.value.init_material_thickness,
                       max_length,
                      400,
                       max_length,
                      "Flexible_Shelves"),
                  child: Container(),
                ),
              ),
            ],
          )),


        ],
      ),

    );
  }


}
