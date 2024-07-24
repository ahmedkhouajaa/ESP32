import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  @override
  Admin createState() => Admin();
}

class Admin extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('energie').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var data = doc.data() as Map<String, dynamic>;
                String name = data['name'] ?? 'User';
                String current = data['current'] ?? 'NA A';
                String voltage = data['voltage'] ?? 'NA V';
                String power = data['power'] ?? 'NA W';
                String energy = data['energy'] ?? 'NA Wh';

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text('Name: $name', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text('Current: $current', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text('Voltage: $voltage', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text('Power: $power', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text('Energy: $energy', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
