import 'package:flutter/material.dart';
import 'package:flutter_chatapp/all_page.dart';

class SearchWidget extends StatefulWidget {
  final String hintText;
  final String textSearch;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const SearchWidget({
    Key? key,
    required this.hintText,
    this.textSearch = "",
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controllerS = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: kSecondaryColor,
      ),
      width: double.infinity,
      height: 55,
      child: Center(
        child: TextField(
          controller: controllerS,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: Icon(Icons.search, color: kPrimarySwatchColor),
            suffixIcon: widget.textSearch.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      controllerS.clear();
                      widget.onChanged!("");
                    },
                    icon: const Icon(Icons.close))
                : null,
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
