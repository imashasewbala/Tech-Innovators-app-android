import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'result_screen.dart';
import 'image_details.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImage> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7), // Changed to brown
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFDF3E7), // Beige background color
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // New "Upload Image" title inside the body
              const Padding(
                padding: EdgeInsets.only(bottom: 14.0),
                child: Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown, // Changed to brown for contrast
                  ),
                ),
              ),
              Image.asset('assets/images/cinnamon6.png', width: 240, height: 240),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select an option',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown, // Changed to brown
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildUploadOption(Icons.folder_open, "Select an image from device storage", context),
              _buildUploadOption(Icons.camera_alt, "Capture an image from camera", context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadOption(IconData icon, String text, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      color: Colors.brown[50], // Changed to a light brown shade
      child: ListTile(
        leading: Icon(icon, color: Colors.brown, size: 40), // Changed to brown
        title: Text(text, style: const TextStyle(color: Colors.brown)), // Changed to brown
        onTap: () async {
          if (text == "Capture an image from camera") {
            await _initializeControllerFuture;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TakePictureScreen(camera: _controller!.description),
              ),
            );
          } else {
            final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(imagePath: pickedFile.path),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
//File validation method
bool _validateFile(XFile file) {
  // Allowed file extensions
  const allowedExtensions = ['jpg', 'jpeg', 'png'];
  // Maximum file size in bytes (e.g., 15MB)
  const maxSizeInBytes = 15 * 1024 * 1024;

  // Get file extension
  final extension = file.path.split('.').last.toLowerCase();
  // Check file size
  final fileSize = File(file.path).lengthSync();

  // Validate extension and size
  if (!allowedExtensions.contains(extension)) {
  print('Invalid file type: $extension');
  return false;
  }
  if (fileSize > maxSizeInBytes) {
  print('File size exceeds limit: ${fileSize / (1024 * 1024)} MB');
  return false;
  }
  return true;
}
// Show error dialog
void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}




class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Image'),
        backgroundColor: Color(0xFFFDF3E7), // Changed to brown
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFDF3E7), // Changed to brown
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7), // Changed to brown
        title: const Text(''),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Image Preview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown, // Changed to brown
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Future.delayed(Duration(seconds: 2), () {
                  ImageDetails details = ImageDetails(
                      imagePath: imagePath,
                      imageId: '123456',
                      quality: 'High',
                      date: '2024-04-24',
                      time: '12:34 PM'
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ResultScreen(details: details)),
                  );
                });
                showCustomSnackBar(context, imagePath);
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown, // Changed to brown
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomSnackBar(BuildContext context, String imagePath) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFFFDF3E7), // Changed to brown
        behavior: SnackBarBehavior.floating,
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/cinnamon6.png'),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload Successfully!',
                style: TextStyle(color: Colors.brown, fontSize: 16),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}





