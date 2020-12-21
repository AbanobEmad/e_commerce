import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Constains.dart';
import 'package:ecommerce/Models/Product.dart';
class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addProduct(Product Product)
  {
    _firestore.collection(KProductsCollection).add(
      {
        KProductName :Product.pname,
        KProductPrice : Product.pprice,
        KProductDescription : Product.pdescription,
        KProductCaTegory : Product.pcategory,
        KProductLocation : Product.plocation,
      }
    );
  }
}