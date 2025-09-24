class ChatMessage {
  final String message;
  final bool isSender; // true = user, false = API
  final DateTime time;

  ChatMessage({
    required this.message,
    required this.isSender,
    required this.time,
  });
}
