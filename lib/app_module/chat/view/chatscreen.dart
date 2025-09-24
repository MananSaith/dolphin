import 'package:dolphin/app_module/chat/controller/chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/contants/app_colors.dart';
import '../model/chatmodel.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,

      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount:
                    controller.messages.length +
                    (controller.isTyping.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.messages.length) {
                    ChatMessage msg = controller.messages[index];
                    return Align(
                      alignment: msg.isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: msg.isSender
                              ? AppColors.magenta
                              : AppColors.darkPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    // Typing indicator bubble
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "typing...",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }
                },
              );
            }),
          ),

          // Input field + Send button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: AppColors.darkPurple,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      controller.inputText.value = value;
                    },
                  ),
                ),
                Obx(() {
                  bool isEmpty =
                      controller.inputText.trim().isEmpty ||
                      controller.isSending.value;
                  return IconButton(
                    icon: Icon(
                      Icons.send,
                      color: isEmpty ? Colors.grey : AppColors.magenta,
                    ),
                    onPressed: isEmpty
                        ? null
                        : () {
                            controller.sendMessage(
                              controller.inputText.value.trim(),
                            );
                            messageController.clear();
                            controller.inputText.value = '';
                          },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
