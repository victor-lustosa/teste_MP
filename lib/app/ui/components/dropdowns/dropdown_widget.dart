import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(this.list, this.callback, this.name, {super.key, required this.width, required this.height});

  final Function(String) callback;
  final List<String> list;
  final String name;
  final double width;
  final double height;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _listSelected = '';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: const SizedBox(),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      items: widget.list.map<DropdownMenuItem<String>>(
            (String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: Container(
                margin: const EdgeInsets.only(top: 17, left: 25),
                child: Text(
                  val,
                  style: const TextStyle(fontSize: 12,color: Colors.black45),
                ),
              ),
            ),
          );
        },
      ).toList(),
      hint: Container(
        margin:  EdgeInsets.only(left: 25, right: MediaQuery.of(context).size.width * .1,top: 5),
        child: Text(
          widget.name,
          style: const TextStyle(fontSize: 12,color: Colors.black45),
        ),
      ),
      style: const TextStyle(fontSize: 12),
      onChanged: (newValue) {
        _dropDownItemSelected(newValue!);
        setState(
              () {
            _listSelected = newValue;
          },
        );
      },
      value: isSelected ? _listSelected : null,
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(
          () {
        _listSelected = novoItem;
        isSelected = true;
        widget.callback(_listSelected);
      },
    );
  }
}