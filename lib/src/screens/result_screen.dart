import 'dart:io';
import 'package:flutter/material.dart';
import 'image_details.dart';
import 'upload_image.dart';

class ResultScreen extends StatelessWidget {
  final ImageDetails details;

  const ResultScreen({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinnamon Image Details'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.teal[800], // Dark teal background
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image in a more controlled size.
            Container(
              width: double.infinity,
              height: 280, // Fixed height for the image container.
              child: Image.file(
                File(details.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red); // Error handling for image load failure
                },
              ),
            ),
            const SizedBox(height: 20), // Adds space between the image and text
            Text('Image ID: ${details.imageId}', style: const TextStyle(fontSize: 20, color: Colors.white)),
            Text('Quality: ${details.quality}', style: const TextStyle(fontSize: 20, color: Colors.white)),
            Text('Date: ${details.date}', style: const TextStyle(fontSize: 20, color: Colors.white)),
            Text('Time: ${details.time}', style: const TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 30), // Adds space before the buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => UploadImage()),
                    );
                    // Implement retake functionality
                  },
                  child: const Text('Retake'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    foregroundColor: Colors.teal, // Text color
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement save functionality
                  },
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    foregroundColor: Colors.teal, // Text color
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


