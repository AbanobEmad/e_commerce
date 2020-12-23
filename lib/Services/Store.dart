import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Models/Product.dart';
class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addProduct(Product Product)async
  {
    await _firestore.collection(KProductsCollection).add(
      {
        KProductName :Product.pname,
        KProductPrice : Product.pprice,
        KProductDescription : Product.pdescription,
        KProductCaTegory : Product.pcategory,
        KProductLocation : Product.plocation,
      }
    );
  }
  Stream<QuerySnapshot> loadProduct(){
    return  _firestore.collection(KProductsCollection).snapshots();
  }
  deleteProduct(DocumentId){
    _firestore.collection(KProductsCollection).doc(DocumentId).delete();
  }
  editroduct(data,DocumentId)
  {
    _firestore.collection(KProductsCollection).doc(DocumentId).update(data);
  }
}