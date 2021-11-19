class WithdrawHistory {
  List<Withdraw>? withdraws;

  WithdrawHistory({this.withdraws});

  WithdrawHistory.fromJson(Map<String, dynamic> json) {
    if (json['withdraw_history'] != null) {
      withdraws = [];
      json['withdraw_history'].forEach((v) {
        withdraws?.add(Withdraw.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.withdraws != null) {
      data['withdraw_history'] =
          this.withdraws?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'WithdrawHistory{withdraws: $withdraws}';
  }
}

class Withdraw {
  final int? id;
  final String? userId;
  final String? username;
  final String? amount;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Withdraw({
    this.id,
    this.userId,
    this.username,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) {
    return Withdraw(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      amount: json['amount'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'username': username,
      'amount': amount,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Withdraw{id: $id, userId: $userId, username: $username, amount: $amount,status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
