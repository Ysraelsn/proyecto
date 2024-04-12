import 'package:flutter/material.dart';
import 'package:proyecto/Futures/Companies/CompaniesList.dart';
import 'package:proyecto/models/Company.dart'; // Importar el archivo donde se encuentra la clase Customer

class Companies extends StatefulWidget {
  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  Future<List<Company>>? _futureCompanyList;

  @override
  void initState() {
    super.initState();
    _futureCompanyList = CompanyList.fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compañías'),
      ),
      body: Center(
        child: FutureBuilder<List<Company>>(
          future: _futureCompanyList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final company = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/screens/CompanyScreen',
                          arguments: company.id);
                    },
                    child: ListTile(
                      title: Text('Nombre: ${company.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tipo: ${company.type}'),
                          /*
                        Text('Descripción: ${company.description}'),
                        Text('Contacto: ${company.contact}'),
                        Text('Tipo: ${company.type}'),*/
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
