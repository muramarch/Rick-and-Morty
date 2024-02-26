import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/character_detail_page.dart';
import 'package:rickandmorty/services/api.dart';
import 'package:rickandmorty/widgets/textfield.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({Key? key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late ApiService _apiService = ApiService();
  late List<Map<String, dynamic>> _characters = [];
  late List<Map<String, dynamic>> _filteredCharacters = [];
  late TextEditingController _searchController;

  bool _viewValue = false;

  void toggleValue() {
    setState(() {
      _viewValue = !_viewValue;
    });
    print(_viewValue);
  }

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _searchController = TextEditingController();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      final List<Map<String, dynamic>> characters =
          await _apiService.fetchCharacters();
      setState(() {
        _characters = characters;
        _filteredCharacters = List.from(characters);
      });
    } catch (error) {
      print(error);
    }
  }

  void _searchCharacters(String value) {
    setState(() {
      _filteredCharacters = _characters
          .where((character) =>
              character['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 30, 45, 1),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SearchTextField(
              controller: _searchController,
              onChanget: _searchCharacters,
              innerText: 'Найти персонажа',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Всего персонажей ${_characters.length}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(91, 105, 117, 1),
                  ),
                ),
                _viewValue == true
                    ? IconButton(
                        onPressed: () {
                          toggleValue();
                        },
                        icon: Icon(
                          Icons.grid_view,
                          color: Color.fromRGBO(91, 105, 117, 1),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          toggleValue();
                        },
                        icon: Icon(
                          Icons.list_rounded,
                          color: Color.fromRGBO(76, 95, 112, 1),
                        ),
                      )
              ],
            ),
            _filteredCharacters.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _viewValue
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _filteredCharacters.length,
                            itemBuilder: (context, index) {
                              final character = _filteredCharacters[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CharacterDetail(character: character),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 74,
                                        height: 74,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(character['image']),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            character['status'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: character['status'] ==
                                                        'Alive'
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                          Text(
                                            character['name'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            character['gender'],
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: _filteredCharacters.length,
                            itemBuilder: (context, index) {
                              final character = _filteredCharacters[index];
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(character['image']),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        character['status'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                character['status'] == 'Alive'
                                                    ? Colors.green
                                                    : Colors.red),
                                      ),
                                      Text(
                                        character['name'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        character['gender'],
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
          ],
        ),
      ),
    );
  }
}
