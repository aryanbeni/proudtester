import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

class UserDataPage extends StatefulWidget {
  const UserDataPage({super.key});

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  List<dynamic> users = [];
  bool isLoading = true;
  String error = '';
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load users';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      100 + _random.nextInt(155),
      100 + _random.nextInt(155),
      100 + _random.nextInt(155),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : error.isNotEmpty
            ? Center(
          child: Text(
            error,
            style: const TextStyle(color: Colors.white),
          ),
        )
            : RefreshIndicator(
          onRefresh: fetchUsers,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getRandomColor(),
                      child: Text(
                        user['name'][0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      user['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['email']),
                        const SizedBox(height: 4),
                        Text(
                          user['phone'],
                          style: TextStyle(
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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