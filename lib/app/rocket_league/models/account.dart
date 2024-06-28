class Account {
  final String platform;
  final String id;

  Account({
    required this.platform,
    required this.id,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      platform: json['platform'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'id': id,
    };
  }
}