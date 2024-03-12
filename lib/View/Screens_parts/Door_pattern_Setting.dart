
import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Controller/Painters/Door_Pattern_Painter.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Door_pattern_Setting extends StatefulWidget {
  const Door_pattern_Setting({Key? key}) : super(key: key);

  @override
  State<Door_pattern_Setting> createState() => _Door_pattern_SettingState();
}

class _Door_pattern_SettingState extends State<Door_pattern_Setting> {

  Draw_Controller draw_controller = Get.find();


  List<JoinHolePattern> list_Door_Hinges = [];
  List<JoinHolePattern> list_side_Hinges = [];

  double min_length = 0;
  double max_length = 0;

  List<Bore_unit> door_bore_units = [];
  List<Bore_unit> side_bore_units = [];

  int selected_door_pattern = 0;


  bool add_new_door = false;
  bool edit_parameters = false;



  /// drawer setting

     TextEditingController category_controller = TextEditingController();
     TextEditingController name_controller = TextEditingController();
     TextEditingController mini_distence_controller = TextEditingController();
     TextEditingController max_distence_controller = TextEditingController();

  TextEditingController A_controller = TextEditingController();
  TextEditingController A_depth_controller = TextEditingController();
  TextEditingController B_controller = TextEditingController();
  TextEditingController C_controller = TextEditingController();
  TextEditingController D_controller = TextEditingController();
  TextEditingController E_controller = TextEditingController();
  TextEditingController F_controller = TextEditingController();
  TextEditingController H_depth_controller = TextEditingController();
  TextEditingController H_controller = TextEditingController();
  TextEditingController J_depth_controller = TextEditingController();
  TextEditingController J_controller = TextEditingController();

  TextEditingController door_quantity_controller = TextEditingController();
  TextEditingController pre_distence_controller = TextEditingController();


  save_pattern() async {
    double mini_length = double.parse(mini_distence_controller.text.toString());
    double max_length = double.parse(max_distence_controller.text.toString());

    int    quantity        =double.parse(door_quantity_controller.text.toString()).toInt();
    double Pre_distance = double.parse(pre_distence_controller.text.toString());

      JoinHolePattern door_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,
          quantity,
          Pre_distance,
          door_bore_units,
          true);
      JoinHolePattern side_joinHolePattern = JoinHolePattern(
          name_controller.text.toString(),
          mini_length,
          max_length,
          quantity,
          Pre_distance,
          side_bore_units,
          true);


      // print("side_bore_units from settig = ${side_bore_units.length}");

      await draw_controller.save_joinHolePattern(
          door_joinHolePattern, "Door_Hinges");
      await draw_controller.save_joinHolePattern(
          side_joinHolePattern, "side_Hinges");

      await draw_controller.read_pattern_files();
      selected_door_pattern = await draw_controller
          .box_repository.join_patterns["side_Hinges"]!.length;
      add_new_door = false;

    edit_parameters=false;

    refresh();

    // read_patterns();


  }

  delete_pattern() async {

      await   draw_controller.delete_joinHolePattern(list_Door_Hinges[selected_door_pattern],'Door_Hinges');
      await  draw_controller.delete_joinHolePattern(list_side_Hinges[selected_door_pattern], 'side_Hinges');


      list_Door_Hinges.removeAt((selected_door_pattern==0)?selected_door_pattern:selected_door_pattern-1);
      list_side_Hinges.removeAt((selected_door_pattern==0)?selected_door_pattern:selected_door_pattern-1);

      selected_door_pattern=0;


    read_patterns();

  }

  add_door_unit() async {
    double Pre_distance = double.parse(pre_distence_controller.text.toString());
    double A_value = double.parse(A_controller.text.toString());
    double A_depth_value = double.parse(A_depth_controller.text.toString());
    double B_value = double.parse(B_controller.text.toString());
    double C_value = double.parse(C_controller.text.toString());
    double D_value = double.parse(D_controller.text.toString());
    double E_value = double.parse(E_controller.text.toString());
    double F_value = double.parse(F_controller.text.toString());

    double H_depth_value = double.parse(H_depth_controller.text.toString());
    double H_value = double.parse(H_controller.text.toString());
    double J_depth_value = double.parse(J_depth_controller.text.toString());
    double J_value = double.parse(J_controller.text.toString());

    Bore_model main_hole =
    Bore_model(Point_model(0, 22.5 - B_value, 0), A_value, A_depth_value);
    Bore_model main_hole_support_1 = Bore_model(
        Point_model(0, C_value - B_value, 0), H_value, H_depth_value);
    Bore_model main_hole_support_2 = Bore_model(
        Point_model(0, C_value - B_value, 0), H_value, H_depth_value);

    Bore_model side_hole_1 =
    Bore_model(Point_model(0, E_value, 0), J_value, J_depth_value);
    Bore_model side_hole_2 =
    Bore_model(Point_model(0, E_value, 0), J_value, J_depth_value);

    Bore_model emety_bore = Bore_model(Point_model(0, 22, 0), 0, 0);

    Bore_unit Door_unit_1 = Bore_unit(Pre_distance, 0, 0, emety_bore, false, 0,
        emety_bore, main_hole, false, false);

    Bore_unit Door_unit_2 = Bore_unit(
        Pre_distance,C_value - B_value,
        D_value / 2,

        emety_bore,
        false,
        0,
        emety_bore,
        main_hole_support_1,
        false,
        false);

    Bore_unit Door_unit_3 = Bore_unit(
        Pre_distance,(C_value - B_value),
        D_value / 2,

        emety_bore,
        false,
        0,
        emety_bore,
        main_hole_support_2,
        false,
        false);

    Bore_unit side_unit_1 = Bore_unit(Pre_distance,37 - E_value, F_value / 2,
        emety_bore, false, 0, emety_bore, side_hole_1, false, false);

    Bore_unit side_unit_2 = Bore_unit(Pre_distance, 37 - E_value, F_value / 2,
        emety_bore, false, 0, emety_bore, side_hole_2, false, false);

    // door_bore_units.add(Door_unit_1);
    // door_bore_units.add(Door_unit_2);
    // door_bore_units.add(Door_unit_3);
    //
    // side_bore_units.add(side_unit_1);
    // side_bore_units.add(side_unit_2);


    ///
    if (add_new_door) {
      int    quantity        =double.parse(door_quantity_controller.text.toString()).toInt();
      double Pre_distance = double.parse(pre_distence_controller.text.toString());



      JoinHolePattern doorJoinHolePattern=JoinHolePattern(
          name_controller.text.toString(),
          min_length,
          max_length,
          quantity,Pre_distance,
          [
            Door_unit_1,
            Door_unit_2,
            Door_unit_3
          ],
          true);

      JoinHolePattern sideJoinHolePattern=JoinHolePattern(
          name_controller.text.toString(),
          min_length,
          max_length,
          quantity,Pre_distance,

          [
            side_unit_1,
            side_unit_2
          ],
          true);


      door_bore_units=doorJoinHolePattern.apply_pattern_on_door(max_length);
      side_bore_units=sideJoinHolePattern.apply_pattern_on_side(max_length);


    }
    add_new_door=false;

read_patterns();
  }

  add_new_pattern(){
    add_new_door=true;

    door_bore_units=[];
    side_bore_units=[];

  }

  enable_pattern_changed(){



    list_Door_Hinges[selected_door_pattern].pattern_enable=!list_Door_Hinges[selected_door_pattern].pattern_enable;
    list_side_Hinges[selected_door_pattern].pattern_enable=!list_side_Hinges[selected_door_pattern].pattern_enable;


    refresh();
  }


  refresh(){





    door_bore_units=[];
    side_bore_units=[];


   if (!add_new_door) {

     print("inside not new");
     JoinHolePattern corrent_door_pattern=list_Door_Hinges[selected_door_pattern];
     JoinHolePattern corrent_side_pattern=list_side_Hinges[selected_door_pattern];


     door_bore_units=corrent_door_pattern.bores;
     side_bore_units=corrent_side_pattern.bores;


     category_controller.text="Doors";
     name_controller.text="${corrent_door_pattern.name}";

     door_quantity_controller.text="${corrent_door_pattern.quantity}";
     pre_distence_controller .text="${corrent_door_pattern.main_pre_distance}";



     if (!edit_parameters) {
       mini_distence_controller.text="${corrent_door_pattern.min_length}";
       max_distence_controller.text="${corrent_door_pattern.max_length}";


       min_length = corrent_door_pattern.min_length;
       max_length = corrent_door_pattern.max_length;
     }




     door_bore_units=list_Door_Hinges[selected_door_pattern].bores;
     side_bore_units=list_side_Hinges[selected_door_pattern].bores;



     A_controller       .text="${corrent_door_pattern.bores[0].face_bore.diameter}";
     A_depth_controller .text="${corrent_door_pattern.bores[0].face_bore.depth}";
     B_controller       .text="${corrent_door_pattern.bores[0].face_bore.origin.y_coordinate+22.5}";
     C_controller       .text="${corrent_door_pattern.bores[1].correct_y+corrent_door_pattern.bores[1].face_bore.origin.y_coordinate}";
     D_controller       .text="${corrent_door_pattern.bores[1].correct_y*2}";
     E_controller       .text="${corrent_side_pattern.bores[0].face_bore.origin.y_coordinate}";
     F_controller       .text="${corrent_side_pattern.bores[0].correct_y*2}";
     H_depth_controller .text="${corrent_door_pattern.bores[1].face_bore.depth}";
     H_controller       .text="${corrent_door_pattern.bores[1].face_bore.diameter}";
     J_depth_controller .text="${corrent_side_pattern.bores[0].face_bore.depth}";
     J_controller       .text="${corrent_side_pattern.bores[0].face_bore.diameter}";
   }
   else{

     min_length = double.parse(mini_distence_controller.text.toString());
   max_length = double.parse(max_distence_controller.text.toString());

   }




    setState(() {});
  }


  read_patterns() async {

    list_Door_Hinges = [];
    list_side_Hinges = [];

    await draw_controller.read_pattern_files();

    Map<String, List<JoinHolePattern>> join_patterns =
        draw_controller.box_repository.join_patterns;

    list_Door_Hinges = join_patterns["Door_Hinges"]!;
    list_side_Hinges = join_patterns["side_Hinges"]!;

selected_door_pattern=0;
  refresh();

  }


  @override
  void initState() {

    /// hinges
    A_controller.text = "35";
    A_depth_controller.text = "13";
    B_controller.text = "22.5";
    C_controller.text = "32";
    D_controller.text = "45";
    E_controller.text = "37";
    F_controller.text = "32";
    H_depth_controller.text = "3";
    H_controller.text = "3";
    J_depth_controller.text = "3";
    J_controller.text = "3";


    read_patterns();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Scaffold(
       body: Row(
        children: [

          /// list of patterns
          Column(
            children: [
              SizedBox(height: 24,),
              Text("Door patterns list",style: TextStyle(fontSize: 18),),

              Container(
                  width: 200,
                  height: h - 350,
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: ListView.builder(
                        itemCount: list_Door_Hinges.length,
                        itemBuilder: (context, i) {

                          bool corrent = (selected_door_pattern == i);
                          bool enable_pattern = list_Door_Hinges[i].pattern_enable;
                          String pattern_name = list_Door_Hinges[i].name;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 200,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: enable_pattern,
                                      onChanged: (v) {
                                        selected_door_pattern=i;

                                        enable_pattern_changed();

                                      }),

                                  InkWell(
                                    onTap: () {
                                      selected_door_pattern=i;
                                      refresh();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: corrent ? 150 : 100,
                                      color: corrent
                                          ? Colors.teal[200]
                                          : Colors.grey[100],
                                      child: Center(
                                        child: Text(
                                          "$pattern_name",
                                          style: TextStyle(
                                              fontSize: corrent ? 18 : 12),
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

              SizedBox(
                height: 32,
              ),

              /// add new pattern
              Container(
                width: 65,
                height: 65,
                child: InkWell(
                  onTap: () {
                    add_new_pattern();
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.teal,
                    size: 24,
                  ),
                ),
              )
            ],
          ),

          Container(color: Colors.grey[400],width: 2,),

          /// parameters editor
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
                width: 280,
                child: ListView(
                  children: [

                    SizedBox(
                      height: 24,
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
                          width: 100,
                          height: 30,
                          child: TextFormField(
                            controller: category_controller,
                            style: TextStyle(fontSize: 12),
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
                            onChanged: (_) {
                              edit_parameters=true;

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
                              edit_parameters=true;

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
                              edit_parameters=true;

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

                    ///divider
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 2,
                        width: 300,
                        color: Colors.grey,
                      ),
                    ),



                    /// details
                    ExpansionTile(collapsedBackgroundColor: Colors.blue[100],
                      title: Text("details"),
                      children: [

                        ///photo
                        Container(
                          width: 250,
                          child: Image.asset("lib/assets/images/hinges.png"),
                        ),

                        ///divider
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 2,
                            width: 300,
                            color: Colors.grey,
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    ' ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'distance',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'deoth',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///A
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'A',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: A_controller,
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
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: A_depth_controller,
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

                        SizedBox(
                          height: 8,
                        ),

                        ///B
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'B',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: B_controller,
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
                            Container(width: 100, height: 24, child: Container()),
                          ],
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        ///C
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'C',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: C_controller,
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
                            Container(width: 100, height: 24, child: Container()),
                          ],
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        ///H
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'H',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: H_controller,
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
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: H_depth_controller,
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

                        SizedBox(
                          height: 8,
                        ),

                        ///D
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'D',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: D_controller,
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

                        SizedBox(
                          height: 8,
                        ),

                        ///E
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'E',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: E_controller,
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
                            Container(width: 100, height: 24, child: Container()),
                          ],
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        ///J
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'J',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: J_controller,
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
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: J_depth_controller,
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

                        SizedBox(
                          height: 8,
                        ),

                        ///F
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 24,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'F',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 24,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [DecimalTextInputFormatter(2)],
                                controller: F_controller,
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

                        SizedBox(
                          height: 8,
                        ),


                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    ///pre distance
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Center(
                              child: Text(
                                'pre distance',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: pre_distence_controller,
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


                    SizedBox(
                      height: 12,
                    ),


                    ///quantity
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Center(
                              child: Text(
                                'quantity',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalTextInputFormatter(2)],
                            controller: door_quantity_controller,
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



                    SizedBox(
                      height: 12,
                    ),

                    /// add to pattern button
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              add_door_unit();
                             },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.teal[200],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                    'ADD TO PATTERN',
                                    style: TextStyle(fontSize: 12),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                          child: InkWell(
                            onTap: () {
                              if (door_bore_units.length > 0) {
                                door_bore_units
                                    .removeAt(door_bore_units.length - 1);
                                side_bore_units
                                    .removeAt(side_bore_units.length - 1);
                              }

                              refresh();
                            },
                            child: Container(
                              width: 50,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Icon(
                                    Icons.undo,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ],
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
                )),
          ),

          Container(color: Colors.grey[400],width: 2,),

          ///painter
          Transform.rotate(angle: 3.14/2,
            child: Container(
              child: Column(
                children: [
                  Container(width: h-250,
                    height: 500,
                    child: CustomPaint(
                      painter: Door_Pattern_Painter(
                          door_bore_units,
                          side_bore_units,
                          draw_controller.box_repository.box_model.value.init_material_thickness,
                          max_length,
                          h-300,
                          max_length,
                          "Doors"),
                      child: Container(),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),

                ],
              )
            ),
          ),




        ],
      ),

    );
  }
}
