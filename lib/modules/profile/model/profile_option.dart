class ProfileOption {
  final String name;
  final ProfileOptionDetail detail;

  ProfileOption(this.name, this.detail);
}

class ProfileOptionDetail {
  final String icon;
  final bool isActiveBadge;

  ProfileOptionDetail(this.icon, this.isActiveBadge);
}
