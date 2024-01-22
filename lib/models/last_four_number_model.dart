import 'dart:convert';

class LastFourNumbersResponse {
  String? lastFourNumbers;

  LastFourNumbersResponse({this.lastFourNumbers});

  factory LastFourNumbersResponse.fromJson(String jsonStr) =>
      LastFourNumbersResponse.fromMap(json.decode(jsonStr));

  factory LastFourNumbersResponse.fromMap(Map<String, dynamic> json) =>
      LastFourNumbersResponse(
        lastFourNumbers: json['lastFourNumbers'],
      );

  Map<String, dynamic> toMap() => {
    'lastFourNumbers': lastFourNumbers,
  };
}
