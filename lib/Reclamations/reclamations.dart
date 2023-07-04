import 'package:firebase_database/firebase_database.dart';

class Reclamation {
  final String nom;
  final DateTime date;
  final String mail;
  final String telephone;
  final String titre;
  final String description;

  Reclamation({
    required this.nom,
    required this.date,
    required this.mail,
    required this.telephone,
    required this.titre,
    required this.description,
  });
  factory Reclamation.fromSnapshot(DataSnapshot snapshot) {
    return Reclamation(
      nom: snapshot.child('nom').value.toString(),
      date: DateTime.parse(snapshot.child('date').value.toString()),
      mail: snapshot.child('mail').value.toString(),
      telephone: snapshot.child('telephone').value.toString(),
      titre: snapshot.child('titre').value.toString(),
      description: snapshot.child('description').value.toString(),
    );
  }
}
