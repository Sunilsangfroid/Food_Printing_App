import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'api_key.dart';
import 'chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> chatList = [];
  final TextEditingController controller = TextEditingController();
  File? image;

  void onSendMessage() async {
    late ChatModel model;

    if (image == null) {
      model = ChatModel(isMe: true, message: controller.text);
    } else {
      final imageBytes = await image!.readAsBytes();

      String base64EncodedImage = base64Encode(imageBytes);

      model = ChatModel(
        isMe: true,
        message: controller.text,
        base64EncodedImage: base64EncodedImage,
      );
    }

    chatList.insert(0, model);

    setState(() {});

    // Clear the text field after sending the message
    controller.clear();

    final geminiModel = await sendRequestToGemini(model);

    chatList.insert(0, geminiModel);
    setState(() {});
  }

  void selectImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      image = File(picker.path);
    }
  }

  Future<ChatModel> sendRequestToGemini(ChatModel model) async {
    String url = "";
    Map<String, dynamic> body = {};

    if (model.base64EncodedImage == null) {
      url =
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${GeminiApiKey.api_key}";

      body = {
        "contents": [
          {
            "parts": [
              {"text": model.message},
            ],
          },
        ],
      };
    } else {
      url =
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=${GeminiApiKey.api_key}";

      body = {
        "contents": [
          {
            "parts": [
              {"text": model.message},
              {
                "inline_data": {
                  "mime_type": "image/jpeg",
                  "data": model.base64EncodedImage,
                }
              }
            ],
          },
        ],
      };
    }

    Uri uri = Uri.parse(url);

    final result = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    print(result.statusCode);
    print(result.body);

    final decodedJson = json.decode(result.body);

    String message =
        decodedJson['candidates'][0]['content']['parts'][0]['text'];

    ChatModel geminiModel = ChatModel(isMe: false, message: message);

    return geminiModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatBot AI"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView.builder(
              reverse: true,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatList[index].isMe ? "Me" : "Gemini"),
                  subtitle: chatList[index].base64EncodedImage != null
                      ? Column(
                          children: [
                            Image.memory(
                              base64Decode(chatList[index].base64EncodedImage!),
                              height: 300,
                              width: double.infinity,
                            ),
                            Text(chatList[index].message),
                          ],
                        )
                      : Text(chatList[index].message),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.upload_file),
                      ),
                      hintText: "Message",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onSendMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
