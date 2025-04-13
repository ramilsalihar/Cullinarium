import 'package:cullinarium/features/profile/data/models/chefs/chef_details_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';

class ChefModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final ProfileModel? profile;
  final ChefDetailsModel? chefDetails;

  const ChefModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.profile,
    this.chefDetails,
  });
}
