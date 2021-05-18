import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Vendas {
  String docID;
  String nomeCliente;
  double valorVenda;
  DateTime dataVenda;

  Vendas(
      {this.docID,
      @required this.nomeCliente,
      @required this.valorVenda,
      DateTime data})
      : this.dataVenda = data ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'docID': docID,
      'nomeCliente': nomeCliente,
      'valorVenda': valorVenda,
      'dataVenda': Timestamp.fromDate(dataVenda),
    };
  }

  factory Vendas.fromMap(Map<String, dynamic> map) {
    return Vendas(
      docID: map['docID'],
      nomeCliente: map['nomeCliente'],
      valorVenda: map['valorVenda'],
      data: DateTime.fromMillisecondsSinceEpoch(map['dataVenda']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vendas.fromJson(String source) => Vendas.fromMap(json.decode(source));
}
