import 'dart:io';
import 'package:flutter/material.dart';
import 'image_details.dart';
import 'upload_image.dart';
import 'dashboard.dart';

class ResultScreen extends StatelessWidget {
  final ImageDetails details;

  const ResultScreen({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Color(0xFFFDF3E7),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFFDF3E7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              child: Image.file(
                File(details.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Image ID: ${details.imageId}', style: const TextStyle(fontSize: 20, color: Colors.brown)),
            Text('Quality: ${details.quality}', style: const TextStyle(fontSize: 20, color: Colors.brown)),
            Text('Date: ${details.date}', style: const TextStyle(fontSize: 20, color: Colors.brown)),
            Text('Time: ${details.time}', style: const TextStyle(fontSize: 20, color: Colors.brown)),
            const SizedBox(height: 30),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => UploadImage()),
                    );
                  },
                  child: const Text('Retake'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFDF3E7),
                    foregroundColor: Colors.brown,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: const Size(60,40),
                    side: const BorderSide(
                      color: Colors.brown, // Brown border color
                      width: 2.0, // Border width
                    ),
                  ),
                ),

                const SizedBox(width: 25),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Dashboard()),
                    );
                  },
                  child: const Text('Home Page'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // No rounding for square corners
                    ),
                    minimumSize: const Size(60, 40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


