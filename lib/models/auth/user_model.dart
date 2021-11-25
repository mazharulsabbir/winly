class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phoneNumber;
  String? referralCode;
  String? profileImage;
  int? referrals;
  String? isSuspended;
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
    phoneNumber = json['phone'];
    referralCode = json['referral_code'];
    profileImage = json['profile_img'];
    referrals = json['referrals'];
    earnings = json['earnings'] != null
        ? DailyEarnings.fromJson(json['earnings'])
        : null;
    membership = json['membership'];
    isSuspended = json['is_suspend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phoneNumber;
    data['referral_code'] = referralCode;
    data['profile_img'] = profileImage;
    data['referrals'] = referrals;
    if (earnings != null) {
      data['earnings'] = earnings!.toJson();
    }
    data['membership'] = membership;
    data['is_suspend'] = isSuspended;
    return data;
  }

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? phoneNumber,
    String? referralCode,
    String? profileImage,
    int? referrals,
    String? isSuspended,
    DailyEarnings? earnings,
    dynamic membership,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      referralCode: referralCode ?? this.referralCode,
      profileImage: profileImage ?? this.profileImage,
      referrals: referrals ?? this.referrals,
      isSuspended: isSuspended ?? this.isSuspended,
      earnings: earnings ?? this.earnings,
      membership: membership ?? this.membership,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email: $email, phoneNumber: $phoneNumber, referralCode: $referralCode, profileImage: $profileImage, referrals: $referrals, earnings: $earnings, membership: $membership, isSuspended: $isSuspended}';
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

  DailyEarnings copyWith({
    String? totalTickets,
    String? totalBalance,
    String? totalReferBalance,
  }) {
    return DailyEarnings(
      totalTickets: totalTickets ?? this.totalTickets,
      totalBalance: totalBalance ?? this.totalBalance,
      totalReferBalance: totalReferBalance ?? this.totalReferBalance,
    );
  }

  @override
  String toString() {
    return 'DailyEarnings{totalTickets: $totalTickets, totalBalance: $totalBalance, totalReferBalance: $totalReferBalance}';
  }
}
