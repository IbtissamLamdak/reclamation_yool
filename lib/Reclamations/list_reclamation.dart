import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';
import 'package:yool_project/Reclamations/description_reclmation.dart';

import 'reclamations.dart';

class listreclamation extends StatefulWidget {
  const listreclamation({Key? key});

  @override
  State<listreclamation> createState() => _listereclamationState();
}

class _listereclamationState extends State<listreclamation> {
  var reclamationRef = FirebaseDatabase.instance.ref('reclamations');
  List<Reclamation> reclamationList = [];
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    reclamationRef.onChildAdded.listen((event) {
      setState(() {
        reclamationList.add(Reclamation.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Reclamations',
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
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            padding: EdgeInsets.only(right: 25),
            color: Color.fromARGB(255, 219, 125, 38),
            splashColor: Color(0xFF2D417C),
            highlightColor: Color(0xFF2D417C),
            tooltip: 'Filter',
            iconSize: 24.0,
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
                reclamationList.sort((a, b) {
                  DateTime dateA = convertStringToDate(a.date.toString());
                  DateTime dateB = convertStringToDate(b.date.toString());
                  if (isAscending) {
                    return dateA.compareTo(dateB);
                  } else {
                    return dateB.compareTo(dateA);
                  }
                });
              });
            },
          )
        ],
        elevation: 20,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: reclamationList.length,
            itemBuilder: (context, index) {
              Reclamation reclamation = reclamationList[index];
              DateTime date = convertStringToDate(reclamation.date.toString());
              String formattedDate = DateFormat.yMMMd().format(date);
              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF2D417C),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(7, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(reclamation.nom),
                      subtitle: Text(reclamation.titre),
                      trailing: Text(formattedDate.toString()),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReclamationDesc(reclamation)));
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(bottom: 15),
                          child: GlowText(
                            'Voir la description',
                            glowColor: Color.fromRGBO(255, 152, 0, 0.5),
                            style: TextStyle(
                                color: Color.fromARGB(255, 219, 125, 38)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        splashColor: Color(0xFF2D417C),
                        highlightColor: Color(0xFF2D417C),
                      ),
                    ),
                  ],
                ),
              );
            },
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
