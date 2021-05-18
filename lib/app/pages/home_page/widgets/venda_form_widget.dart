import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movere_app/app/api/firebase_api.dart';
import 'package:movere_app/app/models/Vendas.dart';
import 'package:intl/intl.dart';

class VendaFormWidget extends StatefulWidget {
  const VendaFormWidget({Key key}) : super(key: key);

  @override
  _VendaFormWidgetState createState() => _VendaFormWidgetState();
}

class _VendaFormWidgetState extends State<VendaFormWidget> {
  final TextEditingController _nomeField = TextEditingController();
  final TextEditingController _valorField = TextEditingController();
  final TextEditingController _dateField = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateField.text = DateFormat("yyyy-MM-dd").format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildNameField(),
          SizedBox(height: 10),
          _buildValorField(),
          SizedBox(height: 10),
          _buildDataField(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuitButton(),
              _buildOkButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: _nomeField,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nome do cliente',
      ),
    );
  }

  Widget _buildValorField() {
    return TextFormField(
      controller: _valorField,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Valor da venda',
      ),
    );
  }

  Widget _buildDataField() {
    return TextFormField(
      controller: _dateField,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Data da venda',
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (datePicked != null) {
      setState(() {
        _selectedDate = datePicked;
        _dateField.text = DateFormat("yyyy-MM-dd").format(_selectedDate);
      });
    }
  }

  Widget _buildOkButton() {
    if (_nomeField.text.isEmpty ||
        _valorField.text.isEmpty ||
        double.tryParse(_valorField.text).isNaN) {}
    return TextButton(
      onPressed: onSavePressed,
      child: Text('Adicionar'),
    );
  }

  Widget _buildQuitButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Fechar'),
    );
  }

  void onSavePressed() {
    if (_nomeField.text.isNotEmpty && _valorField.text.isNotEmpty) {
      final venda = Vendas(
        nomeCliente: toBeginningOfSentenceCase(_nomeField.text),
        valorVenda: double.parse(_valorField.text),
        data: _selectedDate,
      );
      FirebaseApi.addVenda(venda);
      Navigator.pop(context);
    }
  }
}
