

class CNC_Tool{

  late   String     tool_name ;
  late    int       tool_num ;
  late    String    tool_description ;
  late     double   tool_diameter ;
  late     double   tool_step_down ;
  late     int      tool_feed_rate_speed ;
  late     int      tool_plunge_rate_speed ;
  late     int      spindle_speed ;

  CNC_Tool(
      this.tool_name,
      this.tool_num,
      this.tool_description,
      this.tool_diameter,
      this.tool_step_down,
      this.tool_feed_rate_speed,
      this.tool_plunge_rate_speed,
      this.spindle_speed);
}