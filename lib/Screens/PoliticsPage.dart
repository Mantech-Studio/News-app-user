import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PoliticsPage extends StatefulWidget {
  @override
  _PoliticsPageState createState() => _PoliticsPageState();
}

class _PoliticsPageState extends State<PoliticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Politics').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              'No Data...',
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];

                  return Material(
                    elevation: 8,
                    child: Container(
                      child: ListTile(
                        title: Text(ds['title']),
                        subtitle: Text(ds['description']),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
