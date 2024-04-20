import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
      // ignore: avoid_print
      onStatus: (status) => print('Status: $status'),
      // ignore: avoid_print
      onError: (error) => print('Error: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
    } else {
      // ignore: avoid_print
      print('The user has denied the use of speech recognition.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                // Chat messages display area
                const ChatMessage(
                  text: 'Hello! How can I help you today?',
                  isMe: false,
                ),
                const ChatMessage(
                  text: 'I want to know about your products.',
                  isMe: true,
                ),
                // Add more chat messages as needed
              ],
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.keyboard_voice),
            onPressed: _isListening ? null : _startListening,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Type your message here...',
              ),
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _text.trim().isEmpty ? null : _handleSubmit,
          ),
        ],
      ),
    );
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
        });
      },
    );
  }

  void _handleSubmit() {
    // Send message logic
    setState(() {
      // Clear text field
      _text = '';
    });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 20.0 : 5.0),
          topRight: Radius.circular(isMe ? 5.0 : 20.0),
          bottomLeft: const Radius.circular(20.0),
          bottomRight: const Radius.circular(20.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}