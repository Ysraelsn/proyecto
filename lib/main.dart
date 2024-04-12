import 'package:flutter/material.dart';
import 'package:proyecto/Home.dart';
import 'package:proyecto/Clientes.dart';
import 'package:proyecto/ErrorPage.dart';
import 'package:proyecto/LocalesPage.dart';
import 'package:proyecto/Screens/Auth/SignUp.dart';
import 'package:proyecto/Screens/CompanyScreen.dart';
import 'package:proyecto/Screens/EventScreen.dart';
import 'package:proyecto/ServiciosPage.dart';
import 'package:proyecto/EventosPage.dart';
import 'package:proyecto/PagosPage.dart';
import 'package:proyecto/FechasPage.dart';
import 'package:proyecto/EmpresasPage.dart';
import 'package:proyecto/PlanificacionesPage.dart';
import 'package:proyecto/UsuariosPage.dart';
import 'package:proyecto/Screens/CustomerScreen.dart';
import 'package:proyecto/Screens/LocationScreen.dart';
import 'package:proyecto/Screens/Locations/UpdateLocationScreen.dart';
import 'package:proyecto/Screens/Locations/AddLocation.dart';
import 'package:proyecto/Login.dart';
import 'package:proyecto/Screens/Planifications/AddPlanification.dart';
import 'models/Location.dart';
import 'package:proyecto/Screens/Profile.dart';
import 'package:proyecto/Screens/Search.dart';
import 'package:proyecto/Screens/PlanificationScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) =>
            const MyHomePage(title: 'PlanningCentral'),
        '/clientes': (BuildContext context) => Clientes(),
        '/locales': (BuildContext context) => Locales(),
        '/servicios': (BuildContext context) => Services(),
        '/eventos': (BuildContext context) => Eventos(),
        '/pagos': (BuildContext context) => PagosPage(),
        '/fechas': (BuildContext context) => FechasPage(),
        '/empresas': (BuildContext context) => Companies(),
        '/planificaciones': (BuildContext context) => PlanificacionesPage(),
        '/usuarios': (BuildContext context) => UsuariosPage(),
        '/screens/Locations/AddLocation': (BuildContext context) =>
            AddLocationScreen(),
        '/screens/PlanificationScreen': (BuildContext context) =>
            PlanificationScreen(
                id: ModalRoute.of(context)?.settings.arguments as int),
        '/screens/CustomerScreen': (BuildContext context) => CustomerScreen(
            id: ModalRoute.of(context)?.settings.arguments as int),
        '/screens/LocationScreen': (BuildContext context) => LocationScreen(
            id: ModalRoute.of(context)?.settings.arguments as int),
        '/screens/CompanyScreen': (BuildContext context) => CompanyScreen(
            id: ModalRoute.of(context)?.settings.arguments as int),
        '/screens/EventScreen': (BuildContext context) =>
            EventScreen(id: ModalRoute.of(context)?.settings.arguments as int),
        '/screens/Locations/UpdateLocation': (BuildContext context) =>
            UpdateLocationScreen(
                location:
                    ModalRoute.of(context)?.settings.arguments as Location),
        '/login': (BuildContext context) => LoginPage(),
        '/screens/SignUp': (BuildContext context) => SignUpScreen(),
        '/screens/Planifications/AddPlanification': (BuildContext context) =>
            AddPlanificationScreen(),
        '/Screens/Profile': (context) => ProfilePage(),
        '/search': (BuildContext context) => SearchPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext builder) => ErrorPage(),
        );
      },
    );
  }
}
