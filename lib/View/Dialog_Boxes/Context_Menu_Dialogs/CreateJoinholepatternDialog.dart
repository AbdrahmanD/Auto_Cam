import 'package:auto_cam/Controller/DecimalTextInputFormatter.dart';
import 'package:auto_cam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateJoinholepatternDialog extends StatefulWidget {
  const CreateJoinholepatternDialog({Key? key}) : super(key: key);

  @override
  State<CreateJoinholepatternDialog> createState() =>
      _CreateJoinholepatternDialogState();
}

class _CreateJoinholepatternDialogState
    extends State<CreateJoinholepatternDialog> {
  Draw_Controller draw_controller = Get.find();

  TextEditingController name_controller = TextEditingController();
  TextEditingController mini_distence_controller = TextEditingController();
  TextEditingController max_distence_controller = TextEditingController();

  TextEditingController pre_distence_controller = TextEditingController();
  TextEditingController diameter_controller = TextEditingController();
  TextEditingController face_diameter_controller = TextEditingController();
  TextEditingController depth_controller = TextEditingController();
  TextEditingController face_depth_controller = TextEditingController();
  TextEditingController nut_distence_controller = TextEditingController();
  TextEditingController nut_diameter_controller = TextEditingController();
  TextEditingController nut_depth_controller = TextEditingController();

  bool have_nut = false;
  bool have_mirror = true;
  bool center = false;

  double min_length=0;
  double max_length=0;

  List<Bore_unit> bore_units = [];
  List<Bore_unit> Paint_bore_units_min = [];
  List<Bore_unit> Paint_bore_units_max = [];

  JoinHolePattern corrent_join_pattern=JoinHolePattern('name', 150, 300, []);

  add_to_pattern() {

    double pre_distance = double.parse(pre_distence_controller.text.toString());
    double diameter     = double.parse(diameter_controller.text.toString());
    double face_diameter     = double.parse(face_diameter_controller.text.toString());
    double depth        = double.parse(depth_controller.text.toString());
    double face_depth        = double.parse(face_depth_controller.text.toString());

    double nut_destance = have_nut ? double.parse(nut_distence_controller.text.toString()) : 0;
    double nut_diameter = have_nut ? double.parse(nut_diameter_controller.text.toString()) : 0;
    double nut_depth    = have_nut ? double.parse(nut_depth_controller.text.toString()) : 0;

    // double min_length=double.parse(mini_distence_controller.text.toString());
    // double max_length=double.parse(max_distence_controller.text.toString());



    late Bore_model side_bore;
    late Bore_model face_bore;
    late Bore_model nut_bore;

    Point_model init_origin=Point_model(0, 0, 0);
    side_bore = Bore_model(init_origin,diameter, depth       );
    face_bore = Bore_model(init_origin,face_diameter, face_depth       );
    nut_bore =  Bore_model(init_origin,nut_diameter, nut_depth );

     Bore_unit bore_unit = Bore_unit(pre_distance, side_bore, have_nut, nut_destance, nut_bore , face_bore,  center,have_mirror);
     bore_units.add(bore_unit);

    refresh();

  }
  refresh(){

    // print("center : $center");
    // print("mirror : $have_mirror");


    min_length=double.parse(mini_distence_controller.text.toString());
    max_length=double.parse(max_distence_controller.text.toString());

    corrent_join_pattern.bores=bore_units;

    Paint_bore_units_min  = corrent_join_pattern.apply_pattern(min_length);
    Paint_bore_units_max  = corrent_join_pattern.apply_pattern(max_length);

    setState(() {

    });
  }

  pattern_from_history(JoinHolePattern pattern){

    bore_units=[];
    Paint_bore_units_min=[];
    Paint_bore_units_max=[];


    min_length=pattern.min_length;
    max_length=pattern.max_length;

    mini_distence_controller.text='$min_length';
    max_distence_controller.text ='$max_length';
    name_controller.text ='${pattern.name}';

    bore_units=pattern.bores;


    Paint_bore_units_min  = corrent_join_pattern.apply_pattern(min_length);
    Paint_bore_units_max  = corrent_join_pattern.apply_pattern(max_length);


    refresh();

  }


  save_pattern() async {

    double mini_length=double.parse(mini_distence_controller.text.toString());
    double max_length =double.parse(max_distence_controller.text.toString());

    JoinHolePattern joinHolePattern = JoinHolePattern(name_controller.text.toString(),mini_length,max_length,bore_units);

    await draw_controller.save_joinHolePattern(joinHolePattern);
    await draw_controller.read_pattern_files();

    refresh();


  }

  read_patterns()async{
  await  draw_controller.read_pattern_files();
  setState(() {

  });
  }
@override
  void initState() {

    super.initState();

    name_controller.text='0';
    mini_distence_controller.text='0';
    max_distence_controller.text='0';
    pre_distence_controller.text='0';
    diameter_controller.text='0';
    face_diameter_controller.text='0';
    depth_controller.text='0';
    face_depth_controller.text='0';
    nut_distence_controller.text='0';
    nut_diameter_controller.text='0';
    nut_depth_controller.text='0';
    read_patterns();

}

  @override
  Widget build(BuildContext context) {




    return Container(
      width: 800,
      height: 600,
      color: Colors.grey[100],
      child:
      Column(
        children: [
          SizedBox(
            height: 24,
          ),


          Row(
            children: [

              /// pattern name
              Container(
                width: 90,
                child: Center(
                  child: Text(
                    'pattern name',style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 190,
                height: 35,
                child: TextFormField(
                  controller: name_controller,
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
                width: 32,
              ),
              /// minimum length
              Container(
                width: 90,
                child: Center(
                  child: Text(
                    'Minimum length',style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 90,
                height: 35,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  controller: mini_distence_controller,
                  onChanged: (_) {    refresh();},
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
              Container(width: 45, child: Text('  mm')),

              SizedBox(
                width: 32,
              ),

              /// maximum length


              Container(
                width: 90,
                child: Center(
                  child: Text(
                    'Maximum length',style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 90,
                height: 35,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [DecimalTextInputFormatter(2)],
                  controller: max_distence_controller,
                  onChanged: (_) {    refresh();},
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
              Container(width: 45, child: Text('  mm'))
            ],
          ),

          SizedBox(
            height: 32,
          ),

          Row(
            children: [
              /// parameter editor
              Container(
                  width: 200 ,height: 500,
                  child: ListView(
                    children: [

                      ///  undo
                      Row(
                        children: [
                          SizedBox(width: 12,),

                        ],
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
                                  'Pre Distance',
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

                      /// Diameter
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
                              controller: diameter_controller,
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

                      /// Face Diameter
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 35,
                            child: Center(
                              child: Text(
                                'Face Diameter',
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
                              controller: face_diameter_controller,
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
                              controller: depth_controller,
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

                      ///face Depth
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 35,
                            child: Center(
                              child: Text(
                                'Face Depth',
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
                              controller: face_depth_controller,
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


                      /// have mirror
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 35,
                            child: Center(
                              child: Text(
                                'have mirror??',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Checkbox(
                              value: have_mirror,
                              onChanged: (v) {
                                have_mirror = !have_mirror;

                                setState(() {});
                              }),
                        ],
                      ),

                      /// center
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 35,
                            child: Center(
                              child: Text(
                                'Center??',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Checkbox(
                              value:center,
                              onChanged: (v) {
                                if(!center){
                                  have_mirror=false;
                                  pre_distence_controller.text="${double.parse(mini_distence_controller.text.toString())/2}";
                                }
                                center = !center;

                                setState(() {});
                              }),
                        ],
                      ),

                      /// have face hole
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 35,
                            child: Center(
                              child: Text(
                                'have nut??',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Checkbox(
                              value: have_nut,
                              onChanged: (v) {
                                have_nut = !have_nut;
                                setState(() {});
                              }),
                        ],
                      ),

                      /// nut Distance
                      have_nut
                          ? Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      'nut Distance',
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
                                    inputFormatters: [
                                      DecimalTextInputFormatter(2)
                                    ],
                                    controller: nut_distence_controller,
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
                            )
                          : SizedBox(height: 35,),

                      ///
                      /// nut Diameter
                      have_nut
                          ? Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      'nut Diameter',
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
                                    inputFormatters: [
                                      DecimalTextInputFormatter(2)
                                    ],
                                    controller: nut_diameter_controller,
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
                            )
                          : SizedBox(height: 35,),

                      /// nut Depth
                      have_nut
                          ? Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      'nut Depth',
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
                                    inputFormatters: [
                                      DecimalTextInputFormatter(2)
                                    ],
                                    controller: nut_depth_controller,
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
                            )
                          : SizedBox(height: 35,),

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
                                add_to_pattern();
                                setState(() {

                                });
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
                            padding: const EdgeInsets.only(top: 8.0,right: 8,bottom: 8),
                            child: InkWell(
                              onTap: () {
bore_units.removeAt(bore_units.length-1);
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
                                      Icons.undo,color: Colors.white,
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
                        height: 32,
                      ),



                    ],
                  )),
              ///Devider
              Container(height: 500,
                width: 2,color: Colors.grey,
              ),

              Column(
                children: [
                  /// MIN Painter
                  Container(
                    height:250,
                    width: 400
                    ,child: CustomPaint(
                    painter: draw_controller.draw_Pattern(Paint_bore_units_min,min_length,300/max_length),
                  ),
                  ),

                  ///MAX Painter
                  Container(
                    height:250,
                    width: 400
                    ,child: CustomPaint(
                    painter: draw_controller.draw_Pattern(Paint_bore_units_max,max_length,300/max_length),
                  ),
                  ),
                ],
              ),
              ///Devider
              Container(height: 500,
                width: 2,color: Colors.grey,
              ),

              /// patterns listview
              Column(
                children: [
                  Text('patterns List'),
                  SizedBox(height: 10,),
                  Container(
                      width: 150,height:480,
                      child: ListView.builder(

                          itemCount:draw_controller.box_repository.join_patterns.length,
                          itemBuilder: (context , i){

                            return Container(
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    InkWell(onTap: (){
                                      pattern_from_history(draw_controller.box_repository.join_patterns[i]);
                                      refresh();
                                    }
                                        ,child: Center(child: Text('${draw_controller.box_repository.join_patterns[i].name}'))),
                                    SizedBox(height: 3,),
                                    Container(height: 1,width: 100,color: Colors.grey,)
                                  ],
                                ),
                              ),

                            );
                          })

                  ),
                ],
              ),




            ],
          )
        ],
      ),
    );
  }
}
