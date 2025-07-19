import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  final String type, title, description, location, creator;
  final DateTime createdAt;
  Request({required this.type, required this.title, required this.description, required this.location, required this.creator, required this.createdAt});
  factory Request.fromJson(Map<String, dynamic> json) => Request(
    type: json['type'],
    title: json['title'],
    description: json['description'],
    location: json['location'] ?? '',
    creator: json['creator']?['uniId'] ?? '',
    createdAt: DateTime.parse(json['createdAt']),
  );
  static List<Request> fromJsonList(String body) {
    final list = json.decode(body) as List;
    return list.map((e) => Request.fromJson(e)).toList();
  }
}

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<Request> _requests = [];
  String? _selectedType;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();

  Future<void> _fetchRequests() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/requests'));
    if (response.statusCode == 200) {
      setState(() => _requests = Request.fromJsonList(response.body));
    }
  }

  Future<void> _submitRequest() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/requests'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_JWT_TOKEN'},
      body: json.encode({
        'type': _selectedType?.toLowerCase(),
        'title': _titleController.text,
        'description': _descController.text,
        'location': _locationController.text,
      }),
    );
    if (response.statusCode == 201) {
      Navigator.pop(context);
      _fetchRequests();
    }
  }

  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Request'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: ['Carpool', 'Food', 'Project', 'Study']
                  .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  )).toList(),
                onChanged: (val) => setState(() => _selectedType = val),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Description')),
              TextField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: _submitRequest,
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showRequestDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (ctx, i) => Card(
          child: ListTile(
            title: Text(_requests[i].title),
            subtitle: Text('${_requests[i].type} • ${_requests[i].description}\n${_requests[i].location}'),
            trailing: Text(_requests[i].creator),
          ),
        ),
      ),
    );
  }
}
