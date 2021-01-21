
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:thoai/map/component/key_map.dart';
import 'package:thoai/map/component/location.dart';




class SearchMapBox extends StatefulWidget {
  final KeyMap bloc;
  SearchMapBox(this.bloc);

  @override
  _SearchMapBoxState createState() => _SearchMapBoxState();
}

class _SearchMapBoxState extends State<SearchMapBox> {
  FocusNode fieldNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(20),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: fieldNode,
          decoration: InputDecoration(
            
            icon: Icon(
              fieldNode.hasFocus ? Icons.location_on : Icons.search,
              color: fieldNode.hasFocus ? Colors.red :Color(0xff00104F)
            ),
            hintText: 'Từ khóa tìm kiếm',
            
            border: const UnderlineInputBorder(),
          ),
          // enabledBorder: UnderlineInputBorder(),
        ),
        noItemsFoundBuilder: (context) => SizedBox.shrink(),
        suggestionsCallback: (pattern) async {
          return await widget.bloc.search(pattern);
        },
        itemBuilder: (BuildContext context, Location location) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: _size.height * 0.01),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              
              title: Container(
                margin: EdgeInsets.only(bottom: 7),
                child: Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(location.formattedAddress),
            ),
          );
        },
        onSuggestionSelected: (Location location) {
          widget.bloc.locationSelected(location);
        },
      ),
    );
  }
}
