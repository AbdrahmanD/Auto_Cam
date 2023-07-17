class Door_Model{

  late int door_num;
  late double material_thickness;
  late String material_name;
  late double round_gap;
  late int inner_id;

  late double up_over_lap;
  late double right_over_lap;
  late double down_over_lap;
  late double left_over_lap;

  late String direction;

  Door_Model(
      this.door_num,
      this.material_thickness,
      this.material_name,
      this.round_gap,
      this.inner_id,
      this.up_over_lap,
      this.right_over_lap,
      this.down_over_lap,
      this.left_over_lap,
      this.direction
      );
}