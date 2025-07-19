import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadScreen extends StatelessWidget {
  final String imagePath;

  const UploadScreen({super.key, required this.imagePath});

  Future<void> _uploadImage(BuildContext context) async {
    try {
      // Use original image file, skip compression
      final fileToUpload = File(imagePath);

      // 1. Upload to backend (multipart/form-data)
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/api/upload-id'), // Update with your backend endpoint
      );
      request.files.add(await http.MultipartFile.fromPath('idCardImage', fileToUpload.path));
      request.fields['uniId'] = '123456'; // Replace with user input
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: \\${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm ID")),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _uploadImage(context),
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
