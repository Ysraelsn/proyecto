import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto/Screens/LocalesHome.dart';
import 'package:proyecto/Screens/PlanificationHome.dart';
import 'package:proyecto/AppBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    saveAccessToken('access_token');
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {});
  }

  Future<String> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'Invitado';
  }

  Future<String> _getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }

  Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actions: [
          if (_isLoggedIn) ...[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ],
        ],
      ),
      body: _isLoggedIn ? PlanificacionesHome() : LocalesHome(),
      drawer: Drawer(
        backgroundColor: Colors.teal.shade50,
        child: Column(
          children: [
            FutureBuilder<String>(
              future: _getName(),
              builder: (context, snapshot) {
                return FutureBuilder<String>(
                  future: _getEmail(),
                  builder: (context, emailSnapshot) {
                    return _isLoggedIn
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/Screens/Profile');
                            },
                            child: UserAccountsDrawerHeader(
                              decoration:
                                  const BoxDecoration(color: Colors.teal),
                              currentAccountPicture: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2014/04/02/14/11/male-306408_1280.png',
                                ),
                              ),
                              accountName: Text(snapshot.data ?? 'Invitado'),
                              accountEmail: Text(emailSnapshot.data ?? ''),
                            ),
                          )
                        : UserAccountsDrawerHeader(
                            decoration: const BoxDecoration(color: Colors.teal),
                            currentAccountPicture: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2014/04/02/14/11/male-306408_1280.png',
                              ),
                            ),
                            accountName: Text(snapshot.data ?? 'Invitado'),
                            accountEmail: Text(emailSnapshot.data ?? ''),
                          );
                  },
                );
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(9),
                children: [
                  if (_isLoggedIn) ...[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/clientes');
                      },
                      child: const ListTile(
                        title: Text('Clientes'),
                        leading: Icon(Icons.person),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/eventos');
                      },
                      child: const ListTile(
                        title: Text('Eventos'),
                        leading: Icon(Icons.event),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/planificaciones');
                      },
                      child: const ListTile(
                        title: Text('Planificaciones'),
                        leading: Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                    const Divider(),
                  ],
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/locales');
                    },
                    child: const ListTile(
                      title: Text('Locales'),
                      leading: Icon(Icons.location_city),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/servicios');
                    },
                    child: const ListTile(
                      title: Text('Servicios'),
                      leading: Icon(Icons.local_activity),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/empresas');
                    },
                    child: const ListTile(
                      title: Text('Empresas'),
                      leading: Icon(Icons.business),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: _isLoggedIn
                        ? const Icon(Icons.logout)
                        : const Icon(Icons.login),
                    title: _isLoggedIn
                        ? const Text('Cerrar Sesión')
                        : const Text('Iniciar Sesión'),
                    onTap: () async {
                      if (_isLoggedIn) {
                        // Cerrar sesión
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('isLoggedIn');
                        await prefs.remove('name');
                        await prefs.remove('email');
                        setState(() {
                          _isLoggedIn = false;
                        });
                      } else {
                        // Navegar al LoginPage
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
