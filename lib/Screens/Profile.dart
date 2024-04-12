import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto/models/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<User> fetchUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('id') ?? 0;
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/users/$userId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return User.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  Future<String?> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      'https://cdn.pixabay.com/photo/2016/12/20/22/03/background-1921589_1280.jpg',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      top: 75,
                      left: 120,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2014/04/02/14/11/male-306408_1280.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 25, color: Colors.teal),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          const Icon(Icons.calendar_today, color: Colors.teal),
                      title: const Text('Usuario desde:'),
                      subtitle: Text(user.created_at.toString()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<String?>(
                    future: _loadAccessToken(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('Access Token: ${snapshot.data}');
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error al cargar el Access Token: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
