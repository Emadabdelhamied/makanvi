import 'dart:convert';

class StatusAndMessage {
  final String message;
  final bool status;
  StatusAndMessage({
    required this.message,
    required this.status,
  });

  StatusAndMessage copyWith({
    String? message,
    bool? status,
  }) {
    return StatusAndMessage(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory StatusAndMessage.fromMap(Map<String, dynamic> map) {
    return StatusAndMessage(
      message: map['message'] ?? map['msg'] ?? '',
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusAndMessage.fromJson(String source) =>
      StatusAndMessage.fromMap(json.decode(source));

  @override
  String toString() => 'StatusAndMessage(message: $message, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusAndMessage &&
        other.message == message &&
        other.status == status;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode;
}
