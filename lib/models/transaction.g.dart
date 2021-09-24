// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  String amountString = json['amount'].toString();
  double amount = double.parse(amountString);
  return Transaction(
    id: json['id'] as String,
    title: json['title'] as String,
    amount: amount,
    date: DateTime.parse(json['date'] as String),
    category: json['category']  == null
        ? ""
        : json['category'] as String,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'description': instance.description,
    };
