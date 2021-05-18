import 'package:flutter/material.dart';

import 'venda_form_widget.dart';

class AddVendaWidget extends StatefulWidget {
  AddVendaWidget({Key key}) : super(key: key);

  @override
  _AddVendaWidgetState createState() => _AddVendaWidgetState();
}

class _AddVendaWidgetState extends State<AddVendaWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Adicione uma venda"),
            SizedBox(height: 10),
            VendaFormWidget(),
          ],
        ),
      ),
    );
  }
}
