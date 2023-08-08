class Greeting {
  int? id;
  String message;

  Greeting({this.id, required this.message});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
    };
  }

  factory Greeting.fromMap(Map<String, dynamic> map) {
    return Greeting(
      id: map['id'],
      message: map['message'],
    );
  }
}
class Preferencia {
  int? id;
  String preferenciaMessage;

  Preferencia({this.id,required this.preferenciaMessage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gusto': preferenciaMessage,
    };
  }

  factory Preferencia.fromMap(Map<String, dynamic> map) {
    return Preferencia(
      id: map['id'],
      preferenciaMessage: map['gusto'],
    );
  }
}