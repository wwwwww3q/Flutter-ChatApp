import 'package:flutter/material.dart';
import 'package:flutter_chatapp/all_page.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController txtSearch;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.txtSearch,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: kSecondaryColor,
      ),
      width: double.infinity,
      height: 55,
      child: Center(
        child: TextField(
          controller: widget.txtSearch,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: Icon(Icons.search, color: kPrimarySwatchColor),
            suffixIcon: widget.txtSearch.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() => widget.txtSearch.clear());
                      widget.onChanged("");
                    },
                    icon: const Icon(Icons.close))
                : null,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
