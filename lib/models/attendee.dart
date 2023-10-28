class Attendee {
  final int id;
  final String userName;
  final String name;
  final String email;

  Attendee({required this.id, required this.userName, required this.name, required this.email});

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: json['id'],
      userName: json['userName'],
      name: json['name'],
      email: json['email'],
    );
  }
}