class Currency {
  final String symbol;
  final String name;
  final String code;

  Currency({required this.symbol,required this.name, required this.code});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(symbol: json['symbol_native'], name: json['name'], code: json['code']);
  }

}