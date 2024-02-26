import 'package:flutter/material.dart';
import 'package:rickandmorty/services/api.dart';
import 'package:rickandmorty/widgets/textfield.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({super.key});

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  late ApiService _apiService = ApiService();
  late List<Map<String, dynamic>> _locations = [];
  late List<Map<String, dynamic>> _filteredLocations = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _apiService = ApiService();
      _searchController = TextEditingController();
      fetchLocations();
    });
  }

  Future<void> fetchLocations() async {
    try {
      final List<Map<String, dynamic>> locations =
          await _apiService.fetchLocations();
      setState(() {
        _locations = locations;
        _filteredLocations = List.from(locations);
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchLocations(String value) {
    setState(() {
      _filteredLocations = _locations
          .where((locations) =>
              locations['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 30, 45, 1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              controller: _searchController,
              onChanget: _searchLocations,
              innerText: 'Найти локацию',
            ),
            SizedBox(height: 10),
            Text(
              'Всего локаций ${_locations.length}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(91, 105, 117, 1),
              ),
            ),
            _filteredLocations.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _filteredLocations.length,
                      itemBuilder: (context, index) {
                        final location = _filteredLocations[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location['name'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  location['type'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
