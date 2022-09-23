class Product {
  late String pName;
  late int pId;
  late int pCost;
  late int pAvailability;
  late String pDetails;
  late String pCategory;

  Product(
      {required this.pName,
      required this.pId,
      required this.pCost,
      required this.pAvailability,
      required this.pDetails,
      required this.pCategory});

  Product.fromJson(Map<String, dynamic> json) {
    pName = json['p_name'];
    pId = json['p_id'];
    pCost = json['p_cost'];
    pAvailability = json['p_availability'];
    pDetails = json['p_details'];
    pCategory = json['p_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_name'] = this.pName;
    data['p_id'] = this.pId;
    data['p_cost'] = this.pCost;
    data['p_availability'] = this.pAvailability;
    data['p_details'] = this.pDetails;
    data['p_category'] = this.pCategory;
    return data;
  }
}
