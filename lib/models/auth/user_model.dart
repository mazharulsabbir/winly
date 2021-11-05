class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phoneNumber;
  String? referralCode;
  int? referrals;

  // DailyEarnings? dailyEarnings;
  dynamic membership;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.phoneNumber,
      this.referralCode,
      this.referrals,
      // this.dailyEarnings,
      this.membership});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    referralCode = json['referral_code'];
    referrals = json['referrals'];
    // dailyEarnings = json['dailyEarnings'] != null
    //     ? new DailyEarnings.fromJson(json['dailyEarnings'])
    //     : null;
    membership = json['membership'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['referral_code'] = this.referralCode;
    data['referrals'] = this.referrals;
    // if (this.dailyEarnings != null) {
    //   data['dailyEarnings'] = this.dailyEarnings!.toJson();
    // }
    data['membership'] = this.membership;
    return data;
  }
}

class DailyEarnings {
  String? dailyEarning;
  String? dailyTotalEarning;
  String? referralEarning;
  String? totalEarningBalance;

  DailyEarnings({
    this.dailyEarning,
    this.dailyTotalEarning,
    this.referralEarning,
    this.totalEarningBalance,
  });

  DailyEarnings.fromJson(Map<String, dynamic> json) {
    dailyEarning = json['daily_earning'].toString();
    dailyTotalEarning = json['daily_total_earning'].toString();
    referralEarning = json['referral_earning'].toString();
    totalEarningBalance = json['total_earning_balance'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily_earning'] = this.dailyEarning;
    data['daily_total_earning'] = this.dailyTotalEarning;
    data['referral_earning'] = this.referralEarning;
    data['total_earning_balance'] = this.totalEarningBalance;
    return data;
  }
}
