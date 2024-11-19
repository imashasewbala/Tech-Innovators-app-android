import 'package:flutter/material.dart';
import 'record_details.dart';
import '../models/record.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<Record> records = [
    Record(
      title: "Record 1",
      description: "Image ID 111\nQuality: High quality\nDate: 11|04|2024\nTime: 11:11",
      imagePath: "assets/images/record1.jpg",
    ),
    Record(
      title: "Record 2",
      description: "Image ID 112\nQuality: Special High quality\nDate: 13|05|2024\nTime: 10:28",
      imagePath: "assets/images/record2.jpg",
    ),
    Record(
      title: "Record 3",
      description: "Image ID 113\nQuality: Middle quality\nDate: 18|05|2024\nTime: 10:13",
      imagePath: "assets/images/record3.jpg",
    ),
    Record(
      title: "Record 4",
      description: "Image ID 114\nQuality: Low quality\nDate: 21|05|2024\nTime: 09:45",
      imagePath: "assets/images/record4.jpg",
    ),
    Record(
      title: "Record 5",
      description: "Image ID 115\nQuality: Middle quality\nDate: 24|05|2024\nTime: 07:15",
      imagePath: "assets/images/record5.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7),
        title: const Text('Past Data', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF3E7), Color(0xFFFDF3E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordDetail(
                          title: record.title,
                          description: record.description,
                          imagePath: record.imagePath,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            record.imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Record Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.image, color: Colors.brown, size: 16),
                                  const SizedBox(width: 4),
                                  Text("ID: ${record.description.split("\n")[0].split(" ")[2]}"),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.brown, size: 16),
                                  const SizedBox(width: 4),
                                  Text(record.description.split("\n")[1]),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, color: Colors.brown, size: 16),
                                  const SizedBox(width: 4),
                                  Text(record.description.split("\n")[2]),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.brown, size: 16),
                                  const SizedBox(width: 4),
                                  Text(record.description.split("\n")[3]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
