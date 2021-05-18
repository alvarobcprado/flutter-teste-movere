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
    @required this.indexFilterControl,
  }) : super(key: key);
  final AsyncSnapshot streamSnapshot;
  final VoidCallback filterName;
  final VoidCallback filterMoney;
  final bool ascendingFilterControl;
  final int indexFilterControl;

  @override
  _VendaListWidgetState createState() => _VendaListWidgetState();
}

class _VendaListWidgetState extends State<VendaListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              headingRowHeight: 50,
              sortAscending: widget.ascendingFilterControl,
              sortColumnIndex: widget.indexFilterControl,
              columns: _buildDataColumns(),
              rows: _buildDataRows(widget.streamSnapshot.data)),
        ),
      ),
    );

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
        onSort: (index, __) {
          widget.filterName();
        },
      ),
      DataColumn(label: Text('Data da venda')),
      DataColumn(
        label: Text('Valor da venda (R\$)'),
        numeric: true,
        onSort: (index, __) {
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
      DataCell(
        Text(
          NumberFormat.currency(locale: "pt_BR", symbol: '')
              .format(documentSnapshot['valorVenda']),
        ),
      ),
    ];
  }
}
