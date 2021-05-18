import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VendaListWidget extends StatefulWidget {
  VendaListWidget({
    Key key,
    @required this.streamSnapshot,
    @required this.filterName,
    @required this.filterMoney,
    @required this.ascendingFilterControl,
  }) : super(key: key);
  final AsyncSnapshot streamSnapshot;
  final VoidCallback filterName;
  final VoidCallback filterMoney;
  final bool ascendingFilterControl;

  @override
  _VendaListWidgetState createState() => _VendaListWidgetState();
}

class _VendaListWidgetState extends State<VendaListWidget> {
  int columnIndexFilterControl;
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: _buildDataColumns(),
        rows: _buildDataRows(widget.streamSnapshot.data));

    // return ListView.separated(
    //   itemCount: widget.streamSnapshot.data.docs.length,
    //   itemBuilder: (context, index) {
    //     final DocumentSnapshot documentSnapshot =
    //         widget.streamSnapshot.data.docs[index];

    //     return ListTile(
    //       title: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Container(
    //             child: Text(documentSnapshot['nomeCliente']),
    //           ),
    //           Container(
    //             child: Text(documentSnapshot['valorVenda'].toString()),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   separatorBuilder: (context, index) => Divider(),
    // );
  }

  List<DataColumn> _buildDataColumns() {
    return <DataColumn>[
      DataColumn(
        label: Text('Nome do cliente'),
        onSort: (_, __) {
          widget.filterName();
        },
      ),
      DataColumn(label: Text('Data da venda')),
      DataColumn(
        label: Text('Valor da venda'),
        numeric: true,
        onSort: (_, __) {
          widget.filterMoney();
        },
      ),
    ];
  }

  List<DataRow> _buildDataRows(QuerySnapshot snapshot) {
    List<DataRow> listVendas =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return DataRow(cells: _buildDataCells(documentSnapshot));
    }).toList();

    return listVendas;
  }

  List<DataCell> _buildDataCells(DocumentSnapshot documentSnapshot) {
    return <DataCell>[
      DataCell(Text(documentSnapshot['nomeCliente'])),
      DataCell(
        Text(
          DateFormat("yyyy-MM-dd").format(
            documentSnapshot['dataVenda'].toDate(),
          ),
        ),
      ),
      DataCell(Text("${documentSnapshot['valorVenda']}"))
    ];
  }
}
