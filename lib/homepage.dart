import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> cards = [1, 2, 3]; 
  Map<int, TextEditingController> controllers = {}; 
  Map<int, bool> circleColors = {}; 

  @override
  void initState() {
    super.initState();
    for (var id in cards) {
      controllers[id] = TextEditingController();
      circleColors[id] = false;
    }
  }

  void _addNewCard() {
    setState(() {
      int newId = cards.length + 1;
      cards.add(newId);
      controllers[newId] = TextEditingController();
      circleColors[newId] = false;
    });
  }

  void _toggleCircleColor(int cardId) {
    setState(() {
      circleColors[cardId] = !circleColors[cardId]!; 
    });
  }

  void _deleteCard(int cardId) {
    setState(() {
      cards.remove(cardId);
      controllers[cardId]?.dispose();
      controllers.remove(cardId);
      circleColors.remove(cardId);
    });
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                int cardId = cards[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('ID: $cardId'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteCard(cardId);
                            },
                          ),
                        ),
                        TextField(
                          controller: controllers[cardId],
                          decoration: InputDecoration(
                            labelText: 'House Address',
                            hintText: 'Enter the address of the house',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.circle,
                              color: circleColors[cardId] ?? false ? Colors.green : Colors.red,
                            ),
                            IconButton(
                              icon: Icon(Icons.toggle_on),
                              onPressed: () {
                                _toggleCircleColor(cardId);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addNewCard,
              child: Text('Add New Card'),
            ),
          ),
        ],
      ),
    );
  }
}
