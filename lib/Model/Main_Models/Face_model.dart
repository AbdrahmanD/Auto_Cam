import 'package:auto_cam/Model/Main_Models/Groove_model.dart';
import 'package:auto_cam/Model/Main_Models/Join_model.dart';

class Face_model{

  late Single_Face top_face;
  late Single_Face right_face;
  late Single_Face base_face;
  late Single_Face left_face;
  late Single_Face front_face;
  late Single_Face back_face;

  Face_model(this.top_face, this.right_face, this.base_face, this.left_face,
      this.front_face, this.back_face);

}

class Single_Face {
  late List<int> face_item;
  late List<Join_model> join_list;
  late List<Groove_model> groove_list;

  Single_Face(this.face_item, this.join_list, this.groove_list);
}