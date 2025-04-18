class ProfileModel {
  final String description;
  final int jobExperience;
  final String location;
  final String? phoneNumber;
  final String? profilePicture;
  final String? instagram;
  final List<String>? categories;
  final List<String>? languages;
  final double? rating;
  final bool? isApprovied;

  const ProfileModel({
    required this.description,
    required this.jobExperience,
    required this.location,
    required this.phoneNumber,
    this.profilePicture,
    this.instagram,
    this.categories,
    this.languages,
    this.rating,
    this.isApprovied,
  });
}
