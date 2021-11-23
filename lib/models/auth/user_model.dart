class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phoneNumber;
  String? referralCode;
  String? profileImage;
  int? referrals;
  int? isSuspended;
  DailyEarnings? earnings;
  dynamic membership;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phoneNumber,
    this.referralCode,
    this.profileImage,
    this.referrals,
    this.earnings,
    this.membership,
    this.isSuspended,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    referralCode = json['referral_code'];
    profileImage = json['profile_img'];
    referrals = json['referrals'];
    earnings = json['earnings'] != null
        ? DailyEarnings.fromJson(json['earnings'])
        : null;
    membership = json['membership'];
    isSuspended = json['is_suspended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['referral_code'] = referralCode;
    data['profile_img'] = profileImage;
    data['referrals'] = referrals;
    // if (this.dailyEarnings != null) {
    //   data['dailyEarnings'] = this.dailyEarnings!.toJson();
    // }
    data['membership'] = membership;
    return data;
  }
}

class DailyEarnings {
  String? totalTickets;
  String? totalBalance;
  String? totalReferBalance;

  DailyEarnings({
    this.totalTickets,
    this.totalBalance,
    this.totalReferBalance,
  });

  DailyEarnings.fromJson(Map<String, dynamic> json) {
    totalTickets = json['total_tickets'];
    totalBalance = json['total_balance'];
    totalReferBalance = json['refer_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_tickets'] = totalTickets;
    data['total_balance'] = totalBalance;
    data['refer_balance'] = totalReferBalance;
    return data;
  }

  @override
  String toString() {
    return 'DailyEarnings{totalTickets: $totalTickets, totalBalance: $totalBalance, totalReferBalance: $totalReferBalance}';
  }
}
