import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yool_project/Reclamations/reclamations.dart';

class Chat extends StatefulWidget {
  final Reclamation reclamation;

  const Chat({Key? key, required this.reclamation}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  String formatPhoneNumber(String phoneNumber) {
    String formattedNumber =
        phoneNumber.replaceAll('.', '').replaceAll(' ', '');
    if (!formattedNumber.startsWith('+')) {
      formattedNumber = '+212' + formattedNumber.substring(1);
    }
    return formattedNumber;
  }

  void sendMessage() async {
    String text = messageController.text.trim();
    if (text.isNotEmpty) {
      var formattedPhoneNumber =
          formatPhoneNumber(widget.reclamation.telephone);
      var url =
          "https://wa.me/$formattedPhoneNumber?text=${Uri.encodeComponent(text)}";

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
        // Enregistrer le message envoyé dans votre application si nécessaire
      } else {
        print("Impossible de lancer l'URL WhatsApp: $url");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.reclamation.nom,
              style: TextStyle(
                color: Color.fromARGB(255, 219, 125, 38),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              widget.reclamation.telephone,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 69, 69, 69)),
          splashColor: Color(0xFF2D417C),
          highlightColor: Color(0xFF2D417C),
          tooltip: 'Retour',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 20,
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(hintText: "Message"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
