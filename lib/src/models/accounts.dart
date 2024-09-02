class Account {
  int? accountId; // `account_id` is auto-incremented, so it might be null initially
  int userId;
  String accountName;
  String accountType; // 'Credit', 'Debit', 'Cash', etc.
  double balance;
  int used; // 0 for unused, 1 for used

  Account({
    this.accountId,
    required this.userId,
    required this.accountName,
    required this.accountType,
    this.balance = 0.0,
    this.used = 0,
  });

  // Convert a Map to an Account object
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      accountId: map['account_id'],
      userId: map['user_id'],
      accountName: map['account_name'],
      accountType: map['account_type'],
      balance: map['balance'] ?? 0.0,
      used: map['used'] ?? 0,
    );
  }

  // Convert an Account object to a Map
  Map<String, dynamic> toMap() {
    return {
      'account_id': accountId,
      'user_id': userId,
      'account_name': accountName,
      'account_type': accountType,
      'balance': balance,
      'used': used,
    };
  }
}
