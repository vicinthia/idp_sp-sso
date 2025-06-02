class Product {
  final String nameClient;

  Product({this.nameClient});

  Map<String, dynamic> toJson() {
    return {
      'name_client': nameClient,
    };
  }
}
