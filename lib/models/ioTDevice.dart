class IoTDevice{
  int? id;
  int? latitude;
  int? longitude;
  int? pulse;

  IoTDevice({
      this.id, 
      this.latitude, 
      this.longitude, 
      this.pulse
      }
  );

  static IoTDevice fromJson(Map<String, dynamic> json){
    return IoTDevice(
      id: json["id"] as int?,
      latitude: json["latitude"] as int?,
      longitude: json["longitude"] as int?,
      pulse: json["pulse"] as int?
    );
  }
}