import 'package:uuid/uuid.dart';

class GenerateIDs{
  String generateProductId(){
    String productID;
    String uuid=const Uuid().v4();

    productID= uuid.substring(0,8);

    return productID;
  }
}