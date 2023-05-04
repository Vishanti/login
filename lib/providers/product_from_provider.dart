import 'package:flutter/material.dart';
import 'package:login/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    print(value);
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.id);
    print(product.name);
    print(product.price);

    return formKey.currentState?.validate() ?? false;
  }
}
