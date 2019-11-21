import 'package:flutter/material.dart';

class DialogCheckbox extends StatefulWidget{
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChange,
  });
  final ValueChanged<bool> onChange;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox>{

  bool value;


  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v){
        widget.onChange(v);
        setState(() {
          value = v;
        });
      },
    );
  }
}


