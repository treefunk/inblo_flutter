class UserDetails {
  final int userId;
  final String username;
  final int stableId;
  final int roleId;

  const UserDetails({
    required this.userId,
    required this.username,
    required this.stableId,
    required this.roleId,
  });

  String get roleText {
    if (roleId == 1) {
      return "Person-in-Charge";
    } else if (roleId == -1) {
      return "Guest";
    }

    return "Trainer";
  }
}
