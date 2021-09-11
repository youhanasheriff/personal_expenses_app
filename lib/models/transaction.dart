import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime? dateTime;
  final String category;
  final String? description;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
    this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

class AddTx {
  final addTx;
  AddTx(this.addTx);
}

class IsPIN {
  final isPIN;
  IsPIN(this.isPIN);
}
