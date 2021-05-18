import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movere_app/app/pages/home_page/widgets/add_venda_widget.dart';

import 'widgets/venda_list_widget.dart';
import 'widgets/venda_vazia_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> _vendas = FirebaseFirestore.instance
      .collection('vendas')
      .orderBy('nomeCliente')
      .snapshots();

  bool isMoneyAscending = false;
  bool isNameAscending = true;
  bool ascendingControl = true;
  int indexControl = 0;

  void appFilterMoney() {
    if (isMoneyAscending) {
      setState(() {
        indexControl = 2;
        isMoneyAscending = !isMoneyAscending;
        ascendingControl = isMoneyAscending;
        _vendas = FirebaseFirestore.instance
            .collection('vendas')
            .orderBy('valorVenda', descending: true)
            .snapshots();
      });
    } else {
      setState(() {
        indexControl = 2;
        isMoneyAscending = !isMoneyAscending;
        ascendingControl = isMoneyAscending;
        _vendas = FirebaseFirestore.instance
            .collection('vendas')
            .orderBy('valorVenda')
            .snapshots();
      });
    }
  }

  void appFilterName() {
    if (isNameAscending) {
      setState(() {
        indexControl = 0;
        isNameAscending = !isNameAscending;
        ascendingControl = isNameAscending;
        _vendas = FirebaseFirestore.instance
            .collection('vendas')
            .orderBy('nomeCliente', descending: true)
            .snapshots();
      });
    } else {
      setState(() {
        indexControl = 0;
        isNameAscending = !isNameAscending;
        ascendingControl = isNameAscending;
        _vendas = FirebaseFirestore.instance
            .collection('vendas')
            .orderBy('nomeCliente')
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movere Software'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: _appFilterMoney,
        //     icon: Icon(Icons.monetization_on),
        //   ),
        //   IconButton(
        //     onPressed: _appFilterName,
        //     icon: Icon(Icons.sort_by_alpha),
        //   )
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddVendaWidget(),
        ),
      ),
      body: StreamBuilder(
          stream: _vendas,
          builder: (context, streamSnapshot) {
            switch (streamSnapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (streamSnapshot.hasData) {
                  return VendaListWidget(
                    streamSnapshot: streamSnapshot,
                    filterName: appFilterName,
                    filterMoney: appFilterMoney,
                    ascendingFilterControl: ascendingControl,
                    indexFilterControl: indexControl,
                  );
                } else {
                  return VendaVaziaWidget();
                }
            }
          }),
    );
  }
}
