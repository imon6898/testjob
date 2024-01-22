// To parse this JSON data, do
//
//     final getOpenTradesResponseModel = getOpenTradesResponseModelFromMap(jsonString);

import 'dart:convert';

List<GetOpenTradesResponseModel> getOpenTradesResponseModelFromMap(String str) => List<GetOpenTradesResponseModel>.from(json.decode(str).map((x) => GetOpenTradesResponseModel.fromMap(x)));

String getOpenTradesResponseModelToMap(List<GetOpenTradesResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetOpenTradesResponseModel {
  double? currentPrice;
  dynamic comment;
  int? digits;
  int? login;
  double? openPrice;
  DateTime? openTime;
  double? profit;
  double? sl;
  double? swaps;
  String? symbol;
  int? tp;
  int? ticket;
  int? type;
  double? volume;

  GetOpenTradesResponseModel({
    this.currentPrice,
    this.comment,
    this.digits,
    this.login,
    this.openPrice,
    this.openTime,
    this.profit,
    this.sl,
    this.swaps,
    this.symbol,
    this.tp,
    this.ticket,
    this.type,
    this.volume,
  });

  factory GetOpenTradesResponseModel.fromMap(Map<String, dynamic> json) {
    return GetOpenTradesResponseModel(
      currentPrice: (json["currentPrice"] as num?)?.toDouble(),
      comment: json["comment"],
      digits: json["digits"]?.toInt(),
      login: json["login"]?.toInt(),
      openPrice: (json["openPrice"] as num?)?.toDouble(),
      openTime: json["openTime"] == null ? null : DateTime.parse(json["openTime"]),
      profit: (json["profit"] as num?)?.toDouble(),
      sl: (json["sl"] as num?)?.toDouble(),
      swaps: (json["swaps"] as num?)?.toDouble(),
      symbol: json["symbol"],
      tp: json["tp"]?.toInt(),
      ticket: json["ticket"]?.toInt(),
      type: json["type"]?.toInt(),
      volume: (json["volume"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    "currentPrice": currentPrice,
    "comment": comment,
    "digits": digits,
    "login": login,
    "openPrice": openPrice,
    "openTime": openTime?.toIso8601String(),
    "profit": profit,
    "sl": sl,
    "swaps": swaps,
    "symbol": symbol,
    "tp": tp,
    "ticket": ticket,
    "type": type,
    "volume": volume,
  };
}
