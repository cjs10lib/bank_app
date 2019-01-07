import 'package:flutter/material.dart';

class Offer {
  String id;
  String createdBy;
  String title;
  String description;
  double amount;
  String imageUrl;
  bool isFavorite;
  DateTime startDate;
  DateTime endDate;
  DateTime created;
  DateTime lastUpdate;

  Offer(
      {@required this.id,
      @required this.createdBy,
      @required this.title,
      @required this.description,
      @required this.amount,
      @required this.imageUrl,
      this.isFavorite = false,
      @required this.startDate,
      @required this.endDate,
      this.created,
      this.lastUpdate});
}
