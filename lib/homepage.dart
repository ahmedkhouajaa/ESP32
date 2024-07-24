import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference? _sensorRef;
  String currentSensorValue = 'Loading...';

  late Future<DocumentSnapshot> _futureEnergyData;

  @override
  void initState() {
    super.initState();
    _sensorRef =
        FirebaseDatabase.instance.reference().child('Sensor').child('current');
    _fetchSensorData();
    _futureEnergyData = FirebaseFirestore.instance
        .collection('energie')
        .doc(widget.userId)
        .get();
  }

  void _fetchSensorData() {
    _sensorRef!.onValue.listen((event) {
      setState(() {
        currentSensorValue = event.snapshot.value.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sensorRef!.onDisconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureEnergyData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data found'));
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String name = data['name'] ?? 'User';
            String current = data['current'] ?? 'NA A';
            String voltage = data['voltage'] ?? 'NA V';
            String power = data['power'] ?? 'NA W';
            String energy = data['energy'] ?? 'NA Wh';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello $name', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('Current : $currentSensorValue',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Voltage: $voltage', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Power: $power', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Energy: $energy', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
