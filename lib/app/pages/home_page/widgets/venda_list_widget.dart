import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendaListWidget extends StatefulWidget {
  VendaListWidget({Key key, @required this.streamSnapshot}) : super(key: key);
  final AsyncSnapshot streamSnapshot;

  @override
  _VendaListWidgetState createState() => _VendaListWidgetState();
}

class _VendaListWidgetState extends State<VendaListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.streamSnapshot.data.docs.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot documentSnapshot =
            widget.streamSnapshot.data.docs[index];

        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(documentSnapshot['nomeCliente']),
              ),
              Container(
                child: Text(documentSnapshot['valorVenda'].toString()),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
