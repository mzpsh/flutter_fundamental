import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:flutter_fundamental/widgets/restaurant_list.dart';

class Search extends StatefulWidget {
  final String searchTerm;
  const Search({this.searchTerm = '', Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchFieldController = TextEditingController();
  bool _isSearching = false;

  void _clearSearchTerm() {
    _isSearching = false;
    _searchFieldController.clear();
    setState(() {});
  }

  @override
  void initState() {
    if (widget.searchTerm.isNotEmpty) {
      _searchFieldController.text = widget.searchTerm;
      _isSearching = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: TextField(
            onChanged: (input) {
              if (_searchFieldController.text.isEmpty) {
                _isSearching = false;
              } else {
                _isSearching = true;
              }

              setState(() {});
            },
            autofocus: true,
            controller: _searchFieldController,
            decoration: InputDecoration(
              suffixIcon: _isSearching
                  ? IconButton(
                      onPressed: () => _clearSearchTerm(),
                      icon: const Icon(Icons.clear),
                    )
                  : const SizedBox.shrink(),
              border: InputBorder.none,
              hintText: 'Find restaurants..',
            ),
          ),
        ),
        body: _isSearching
            ? FutureBuilder(
                future: Restaurant.findRestaurantsFromAPI(
                    searchTerm: _searchFieldController.text),
                builder: (context, snapshot) =>
                    RestaurantList(snapshot: snapshot, isSearching: true))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Enter search term.',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ));
  }
}
