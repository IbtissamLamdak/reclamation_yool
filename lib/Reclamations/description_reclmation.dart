import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';
import 'package:yool_project/Chats/chat.dart';
import 'package:yool_project/Reclamations/reclamations.dart';

class ReclamationDesc extends StatelessWidget {
  final Reclamation reclamation;
  ReclamationDesc(this.reclamation);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMd().format(reclamation.date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Reclamation',
          style: TextStyle(
            color: Color.fromARGB(255, 219, 125, 38),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 60),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF2D417C), // Change color of the shadow
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(7, 8)),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(reclamation.nom),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reclamation.mail),
                    Text(reclamation.telephone),
                  ],
                ),
                trailing: Text(formattedDate.toString()),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  reclamation.titre,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  reclamation.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: GlowIcon(Icons.reply, color: Color(0xFF2D417C)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(
                                        reclamation: reclamation,
                                      )),
                            );
                          },
                        ),
                        GlowText(
                          'Répondre',
                          glowColor: Color.fromRGBO(45, 65, 124, 1),
                          style:
                              TextStyle(color: Color.fromRGBO(45, 65, 124, 1)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: GlowIcon(Icons.check,
                              color: Color.fromARGB(255, 219, 125, 38)),
                          onPressed: () {},
                        ),
                        GlowText(
                          'Résolu',
                          glowColor: Color.fromRGBO(255, 152, 0, 0.5),
                          style: TextStyle(
                              color: Color.fromARGB(255, 219, 125, 38)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTime convertStringToDate(String dateString) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    return format.parse(dateString);
  }
}
