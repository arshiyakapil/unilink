// scan_id_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ScanIdScreen extends StatefulWidget {
  const ScanIdScreen({super.key});
  @override
  State<ScanIdScreen> createState() => _ScanIdScreenState();
}

class _ScanIdScreenState extends State<ScanIdScreen> {
  String? selectedCollege;
  File? _front, _back;
  bool loading = false;
  final picker = ImagePicker();

  List<String> colleges = ['SRM Sonepat', 'Other'];

  Future<void> _pick(bool isFront) async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => isFront ? _front = File(picked.path) : _back = File(picked.path));
  }

  Future<void> _upload() async {
    if (_front == null || _back == null || selectedCollege == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all required fields')));
      return;
    }

    setState(() => loading = true);
    final req = http.MultipartRequest('POST', Uri.parse('http://<your-ip>:5000/api/srm-id'));

    req.fields['college'] = selectedCollege!;
    req.files
      ..add(await http.MultipartFile.fromPath('front', _front!.path))
      ..add(await http.MultipartFile.fromPath('back', _back!.path));

    final res = await req.send();
    final body = await res.stream.bytesToString();
    setState(() => loading = false);

    if (res.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login via SRM ID')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCollege,
              items: colleges.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => selectedCollege = val),
              decoration: const InputDecoration(labelText: 'Select College'),
            ),
            const SizedBox(height: 20),
            if (selectedCollege == 'SRM Sonepat') ...[
              _captureTile('Front of ID', _front, () => _pick(true)),
              const SizedBox(height: 12),
              _captureTile('Back of ID', _back, () => _pick(false)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: loading ? null : _upload,
                child: loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Submit'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _captureTile(String label, File? img, VoidCallback onTap) => ListTile(
        leading: CircleAvatar(backgroundImage: img != null ? FileImage(img) : null, child: img == null ? const Icon(Icons.photo_camera) : null),
        title: Text(label),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      );
}
