class Door_Model{

  late int door_num;
  late double material_thickness;
  late String material_name;
  late int inner_id;

  late double  up_gap;
  late double  right_gap;
  late double  down_gap;
  late double  left_gap;
  late double  center_gap;

  late String direction;
  late bool inner_door;
  late bool fix_door;

  Door_Model(
      this.door_num,
      this.material_thickness,
      this.material_name,
      this.inner_id,
      this.up_gap,
      this.right_gap,
      this.down_gap,
      this.left_gap,
      this.center_gap,
      this.direction,
      this.inner_door,
      this.fix_door
      );



}