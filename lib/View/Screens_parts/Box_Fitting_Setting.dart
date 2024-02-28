import 'package:auto_cam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Box_Fitting_Setting extends StatefulWidget {
  const Box_Fitting_Setting({Key? key}) : super(key: key);

  @override
  State<Box_Fitting_Setting> createState() => _Box_Fitting_SettingState();
}

class _Box_Fitting_SettingState extends State<Box_Fitting_Setting> {
  ScrollController crt = ScrollController();

  bool screw = false;

  double d1=60;
  double d2=200;
  double d3=40;
  List<Bore_unit> bore_units = [
    Bore_unit(
        32,
        0,
        0,
        Bore_model(Point_model(0, 0, 0), 8, 10),
        true,
        33,
        Bore_model(Point_model(0, 0, 0), 8, 15),
        Bore_model(Point_model(0, 0, 0), 8, 15),
        false,
        false)
  ];

  add_bore_unit() {
    Bore_unit bore_unit = Bore_unit(
        32,
        0,
        0,
        Bore_model(Point_model(0, 0, 0), 8, 10),
        true,
        33,
        Bore_model(Point_model(0, 0, 0), 8, 15),
        Bore_model(Point_model(0, 0, 0), 8, 15),
        false,
        false);
    bore_units.add(bore_unit);
    setState(() {});
  }

  Widget table_row(Bore_unit bore_unit, int index) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            Container(
              width: d1,
              height: d3,
              child: Center(child: Text("$index")),
            ),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            InkWell(
              onTap: () {
                screw = !screw;
                setState(() {});
              },
              child: screw
                  ? Container(
                      width: d2,
                      height: d3,
                      child: Image.asset("lib/assets/images/screw.png"),
                    )
                  : Container(
                      width: d2,
                      height: d3,
                      child: Image.asset("lib/assets/images/dowel.png"),
                    ),
            ),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            Container(
                width: d1,
                height: d3,
                child: TextField(
                  controller: TextEditingController()..text = "0",
                  onChanged: (value) {
                    bore_units[index - 1].side_bore.diameter =
                        double.parse(value);
                  },
                )),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            Container(
                width: d1,
                height: d3,
                child: TextField(
                  controller: TextEditingController()..text = "0",
                  onChanged: (value) {
                    bore_units[index - 1].side_bore.depth = double.parse(value);
                  },
                )),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            Container(
              child: screw
                  ? Container(
                      width: d1,
                      height: d3,
                      child: Image.asset("lib/assets/images/face_nut.png"),
                    )
                  : Container(
                      width: d1,
                      height: d3,
                      child: Image.asset("lib/assets/images/nut.png"),
                    ),
            ),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            Container(
                width: d1,
                height: d3,
                child: TextField(
                  controller: TextEditingController()..text = "0",
                  onChanged: (value) {
                    bore_units[index - 1].face_bore.diameter =
                        double.parse(value);
                  },
                )),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            Container(
                width: d1,
                height: d3,
                child: TextField(
                  controller: TextEditingController()..text = "0",
                  onChanged: (value) {
                    bore_units[index - 1].face_bore.depth = double.parse(value);
                  },
                )),
            Container(
              width: 1,
              height: d3,
              color: Colors.grey,
            ),
            screw?Row(
              children: [
                Container(
                  width: d1,
                  height: d3,
                  child: Image.asset("lib/assets/images/nut.png"),
                ),
                Container(
                  width: 1,
                  height: d3,
                  color: Colors.grey,
                ),
                Container(
                    width: d1,
                    height: d3,
                    child: TextField(
                      controller: TextEditingController()..text = "0",
                      onChanged: (value) {
                        bore_units[index - 1].pre_distence =
                            double.parse(value);
                      },
                    )),
                Container(
                  width: 1,
                  height: d3,
                  color: Colors.grey,
                ),
                Container(
                    width: d1,
                    height: d3,
                    child: TextField(
                      controller: TextEditingController()..text = "0",
                      onChanged: (value) {
                        bore_units[index - 1].nut_bore.diameter = double.parse(value);
                      },
                    )),
                Container(
                  width: 1,
                  height: d3,
                  color: Colors.grey,
                ),
                Container(
                    width: d1,
                    height: d3,
                    child: TextField(
                      controller: TextEditingController()..text = "0",
                      onChanged: (value) {
                        bore_units[index - 1].nut_bore.depth = double.parse(value);
                      },
                    )),
                Container(
                  width: 1,
                  height: d3,
                  color: Colors.grey,
                ),
              ],
            ):SizedBox(),
            Container(
              width: d1,
              height: d3,
              child: InkWell(
                onTap: () {
                  bore_units.removeAt(index - 1);
                  setState(() {});
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 250,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "List of patterns ",
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "small 200-300",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "small 200-300",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "small 200-300",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "small 200-300",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: 12,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Container(
                            width: 132,
                            height: 32,
                            color: Colors.teal,
                            child: Center(child: Text("SAVE")),
                          )),
                      SizedBox(
                        height: 24,
                      ),
                      InkWell(
                          child: Container(
                        width: 132,
                        height: 32,
                        color: Colors.red[200],
                        child: Center(child: Text("cancel")),
                      )),
                      SizedBox(
                        height: 56,
                      ),
                    ],
                  ),
                ),
                Container(
                    width: w-250,
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          height: d3,
                          child: Row(
                            children: [
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d1,
                                height: d3,
                                child: Center(child: Text("N")),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d2,
                                height: d3,
                                child: Center(
                                    child: Text(
                                  "side fix",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d1,
                                height: d3,
                                child: Center(
                                    child: Text(
                                  "Diameter",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d1,
                                height: d3,
                                child: Center(
                                    child: Text(
                                  "Depth",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d1,
                                height: d3,
                                child: Center(
                                    child: Text(
                                  "face fix",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d1,
                                height: d3,
                                child: Center(
                                    child: Text(
                                  "Diameter",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: d1,
                                height: d3,
                                child: Center(
                                    child: Text(
                                  "Depth",
                                  style: TextStyle(fontSize: 12),
                                )),
                              ),
                              Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                              screw?Row(children: [
                                Container(
                                  width: d1,
                                  height: d3,
                                  child: Center(
                                      child: Text(
                                        "face nut",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: d1,
                                  height: d3,
                                  child: Center(
                                      child: Text(
                                        "Pre distance",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ),
                                Container(
                                  width: d1,
                                  height: d3,
                                  child: Center(
                                      child: Text(
                                        "Diameter",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: d1,
                                  height: d3,
                                  child: Center(
                                      child: Text(
                                        "Depth",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ],):SizedBox()
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          height: (bore_units.length * d3 < h - 200)
                              ? (bore_units.length * d3)
                              : (h - 300),
                          child: ListView.builder(
                            controller: crt,
                            itemCount: bore_units.length,
                            itemBuilder: (context, i) {
                              return table_row(bore_units[i], i + 1);
                            },
                          ),
                        ),
                        SizedBox(height: 32),
                        Container(
                          height: 32,
                          child: Row(
                            children: [
                              Container(
                                width: 51,
                                child: InkWell(
                                    onTap: () {
                                      crt.animateTo(1,
                                          duration:
                                              const Duration(milliseconds: 1),
                                          curve: Curves.bounceIn);
                                      add_bore_unit();
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 32,
                                      color: Colors.teal,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
