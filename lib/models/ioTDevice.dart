class IoTDevice{
/*{
<id>1</id>
<distanceP1>0.0</distanceP1>
<distanceP2>0.0</distanceP2>
<distanceBetween>0.0</distanceBetween>
<pulse>0.0</pulse>
<safe>false</safe>
<danger>false</danger>
<time/>
  }*/

  int id;
  double distanceP1;
  double distanceP2;
  double distanceBetween;
  double pulse;
  bool safe;
  bool danger;

  IoTDevice({
    required this.id,
    required this.distanceP1,
    required this.distanceP2,
    required this.distanceBetween,
    required this.pulse,
    required this.safe,
    required this.danger,
  });

  static IoTDevice fromJson(Map<String, dynamic> json){
    return IoTDevice(
      id: json['id'] as int,
      distanceP1: json['distanceP1'] as double,
      distanceP2: json['distanceP2'] as double,
      distanceBetween: json['distanceBetween'] as double,
      pulse: json['pulse'] as double,
      safe: json['safe'] as bool,
      danger: json['danger'] as bool,
    );
  }
}