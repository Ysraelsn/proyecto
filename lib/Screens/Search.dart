import 'package:flutter/material.dart';
import 'package:proyecto/services/search_service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

enum SortType { date, eventType }

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  final _searchService = SearchService();
  String _searchQuery = '';
  SortType _sortType = SortType.date;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.teal.withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _searchEvents(value);
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                DropdownButton<SortType>(
                  borderRadius: BorderRadius.circular(18.0),
                  dropdownColor: Colors.teal[200],
                  value: _sortType,
                  onChanged: (SortType? newValue) {
                    setState(() {
                      _sortType = newValue!;
                      _searchEvents(_searchQuery);
                    });
                  },
                  items: SortType.values
                      .map<DropdownMenuItem<SortType>>((SortType value) {
                    return DropdownMenuItem<SortType>(
                      value: value,
                      child: Text(
                          value == SortType.date ? 'Fecha' : 'Tipo de evento'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchQuery.isNotEmpty
                ? _buildSearchResults()
                : const Center(
                    child: Text(
                      'Ingresa una consulta de búsqueda',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.separated(
      itemCount: _searchResults.length,
      separatorBuilder: (context, index) => const SizedBox(height: 3),
      itemBuilder: (context, index) {
        final event = _searchResults[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/screens/EventScreen',
              arguments: event['id'],
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5.0),
              //border: Border.all(color: Colors.teal),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.play_arrow,
                color: Colors.black87,
              ),
              title: Text(
                event['event_type'],
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Cliente: ${event['client_name']} - Lugar: ${event['location_name']}',
                style: const TextStyle(color: Colors.black87),
              ),
              trailing: Text(
                event['date'].toString(),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _searchEvents(String keyword) async {
    try {
      final searchResults = await _searchService.searchEvents(keyword);
      final sortedResults = _sortSearchResults(searchResults);
      setState(() {
        _searchResults = sortedResults;
      });
    } catch (e) {
      print('Error al realizar la búsqueda: $e');
    }
  }

  List<dynamic> _sortSearchResults(List<dynamic> results) {
    switch (_sortType) {
      case SortType.date:
        return results..sort((a, b) => a['date'].compareTo(b['date']));
      case SortType.eventType:
        return results
          ..sort((a, b) => a['event_type'].compareTo(b['event_type']));
      default:
        return results;
    }
  }
}
