class Currency {
  final String displayName;
  final String displayNameCountOne;
  final String displayNameCountOther;
  final String? symbol;

  Currency({
    required this.displayName,
    required this.displayNameCountOne,
    required this.displayNameCountOther,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      displayName: json['displayName'],
      displayNameCountOne: json['displayName-count-one'],
      displayNameCountOther: json['displayName-count-other'],
      symbol: json['symbol'],
    );
  }
}
