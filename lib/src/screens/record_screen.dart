import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Past Data', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.teal[300]!, Colors.teal[900]!],
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            itemCount: 7, // Limiting the number of records to 7
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white.withOpacity(0.9),
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.history, color: Colors.teal),
                  title: Text("Record ${index + 1}", style: TextStyle(color: Colors.teal)),
                  subtitle: Text("Detail for record ${index + 1}"),
                  onTap: () {
                    // Here you can define what happens when a record is tapped
                    // For example, navigating to a detailed view or executing a function
                    print('Record ${index + 1} tapped');
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
