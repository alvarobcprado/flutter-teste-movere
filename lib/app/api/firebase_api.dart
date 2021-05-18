import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movere_app/app/models/Vendas.dart';

class FirebaseApi {
  static Future<void> addVenda(Vendas venda) async {
    final DocumentReference docVenda =
        FirebaseFirestore.instance.collection('vendas').doc();

    venda.docID = docVenda.id;
    await docVenda.set(venda.toMap());
  }
}
