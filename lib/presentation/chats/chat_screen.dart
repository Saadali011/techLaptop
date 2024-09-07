import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = "/chat";

  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your message',
                ),
                onChanged: (value) {
                  chatProvider.setMessage(value);
                },
                controller: _messageController,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      chatProvider.clearMessage();
                      _messageController.clear();
                    },
                    child: Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (chatProvider.message.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Form Submitted'),
                            content: Text('Your message: ${chatProvider.message}'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                        chatProvider.clearMessage();
                        _messageController.clear();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
