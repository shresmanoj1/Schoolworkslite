// import 'package:flutter/foundation.dart';

class MoredetailUpdateRequest {
  final String? contact;
  final String? address;

  MoredetailUpdateRequest({
    this.contact,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "contact": contact,
      "address": address,
    };
  }
}
