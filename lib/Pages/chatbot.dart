import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  final List<ChatMessage> _messages = []; // List to hold chat messages

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _addInitialMessages(); // Add initial messages
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
    } else {
      print('The user has denied the use of speech recognition.');
    }
  }

  void _addInitialMessages() {
    _messages.add(const ChatMessage(
      text: 'Hello! How can I help you today?',
      isMe: false,
    ));
    _messages.add(const ChatMessage(
      text: 'I want to know about your products.',
      isMe: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
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
              onSubmitted: _handleSubmit, // Pass the _handleSubmit function directly
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _text.trim().isEmpty ? null : () => _handleSubmit(_text), // Pass _text to _handleSubmit
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

  void _handleSubmit(String text) {
    if (text.isNotEmpty) {
      // Add message to the list
      setState(() {
        _messages.add(ChatMessage(
          text: text,
          isMe: true,
        ));
        _text = ''; // Clear text field
      });

      // Perform any logic here for responding to user messages

      // Simulate a response after a delay (for demo purposes)
      _simulateResponse();
    }
  }

  void _simulateResponse() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(const ChatMessage(
          text: 'Thank you for your message!',
          isMe: false,
        ));
      });
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
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
