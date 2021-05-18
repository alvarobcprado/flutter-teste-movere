import 'package:flutter/material.dart';
import 'package:movere_app/app/api/firebase_api.dart';
import 'package:movere_app/app/models/Vendas.dart';

class VendaFormWidget extends StatefulWidget {
  const VendaFormWidget({Key key}) : super(key: key);

  @override
  _VendaFormWidgetState createState() => _VendaFormWidgetState();
}

class _VendaFormWidgetState extends State<VendaFormWidget> {
  final TextEditingController nomeField = TextEditingController();
  final TextEditingController valorField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildNameField(),
          SizedBox(height: 10),
          _buildValorField(),
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
      controller: nomeField,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nome do cliente',
      ),
    );
  }

  Widget _buildValorField() {
    return TextFormField(
      controller: valorField,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Valor da venda',
      ),
    );
  }

  Widget _buildOkButton() {
    if (nomeField.text.isEmpty || valorField.text.isEmpty) {}
    return TextButton(
      onPressed: onSavePressed,
      child: Text('Adicionar'),
    );
  }

  Widget _buildQuitButton() {
    if (nomeField.text.isEmpty || valorField.text.isEmpty) {}
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Fechar'),
    );
  }

  void onSavePressed() {
    if (nomeField.text.isNotEmpty && valorField.text.isNotEmpty) {
      final venda = Vendas(
        nomeCliente: nomeField.text,
        valorVenda: double.parse(valorField.text),
      );
      FirebaseApi.addVenda(venda);
      Navigator.pop(context);
    }
  }
}
