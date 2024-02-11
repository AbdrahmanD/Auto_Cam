import 'package:auto_cam/Controller/Active_controller.dart';
import 'package:auto_cam/View/Main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class View_Active_port extends StatefulWidget {
  const View_Active_port({Key? key}) : super(key: key);

  @override
  State<View_Active_port> createState() => _View_Active_portState();
}

class _View_Active_portState extends State<View_Active_port> {
  Active_controller active_controller = Get.find();

  bool password = false;
  TextEditingController active_code_controller = TextEditingController();

  GlobalKey<FormState> active_form = GlobalKey();

  final my_setting_data = GetStorage();

  bool active = false;

  late String unique_code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if (my_setting_data.read("installation_unique_key") != null) {
      unique_code = my_setting_data.read("installation_unique_key");
    } else {
      Active_controller();
      unique_code = "please restart this window to read the key";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 600,
      height: 600,
      child: Form(
        key: active_form,
        child: Column(
          children: [
            SizedBox(
              height: 56,
            ),

            /// unique code
            SelectableText(
              "$unique_code",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 32,
            ),

            /// un_limit
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                style: TextStyle(fontSize: 14),
                controller: active_code_controller,
                obscureText: true,
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
              height: 16,
            ),

            ///save
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 52, top: 18, bottom: 18),
              child: InkWell(
                onTap: () async {
                  String active_code = active_code_controller.text.toString();

                  if (active_form.currentState!.validate()) {
                    String resault = active_controller.check_active_code(active_code);
                    bool state=(resault=="limit" || resault=="un_limit");
                    Navigator.of(Get.overlayContext!).pop();
                    await Future.delayed(Duration(seconds: 1));
                    Get.defaultDialog(
                        content: Column(
                          children: [
                            Container(
                                                  width: 300,
                                                  height: 300,
                                                  child: Icon(
                            state ? Icons.check : Icons.cancel_outlined,
                            size: 128,
                            color: state ? Colors.teal : Colors.red,
                                                  ),
                                                ),

                            Text(resault)
                          ],
                        ));

                    await Future.delayed(Duration(seconds: 4), () {
                      Navigator.of(Get.overlayContext!).pop();
                    });
                  }

                  Get.to(Main_Screen());
                },
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                    'save',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    ));
  }
}
