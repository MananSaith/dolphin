import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/chatmodel.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var isTyping = false.obs;
  var isSending = false.obs;
  var inputText = ''.obs;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    messages.add(
      ChatMessage(message: text, isSender: true, time: DateTime.now()),
    );

    isTyping.value = true;
    isSending.value = true;

    try {
      // API endpoint (replace with your own if needed)
      final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

      // Send user message as JSON payload
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'message': text}),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Example response from jsonplaceholder: {id: 101, message: "..."}
        final reply = data['id'] != null
            ? "Message received! Server ID: ${data['id']}"
            : "Response received";

        messages.add(
          ChatMessage(message: reply, isSender: false, time: DateTime.now()),
        );
      } else {
        messages.add(
          ChatMessage(
            message: "Model not response",
            isSender: false,
            time: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      messages.add(
        ChatMessage(
          message: "Model not response",
          isSender: false,
          time: DateTime.now(),
        ),
      );
    } finally {
      isTyping.value = false;
      isSending.value = false;
    }
  }
}
