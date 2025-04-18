import 'package:bloc/bloc.dart';
import 'package:cullinarium/features/profile/data/datasources/profile_service.dart';
import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';
import 'package:cullinarium/features/profile/data/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthCubit _authCubit;
  final ProfileRepository profileRepository;

  ProfileCubit({
    required AuthCubit authCubit,
    required ProfileRepository profileService,
  })  : _authCubit = authCubit,
        profileRepository = profileService,
        super(ProfileInitial()) {
    _initialize();
    _authCubit.stream.listen((authState) {
      if (authState.isAuthenticated && authState.user != null) {
        _loadProfile(authState.user!);
      } else {
        emit(const ProfileError("User not authenticated"));
      }
    });
  }

  void _initialize() {
    final user = _authCubit.state.user;
    if (user != null) {
      _loadProfile(user);
    } else {
      emit(const ProfileError("User not authenticated"));
    }
  }

  Future<void> _loadProfile(dynamic user) async {
    emit(ProfileLoading());
    try {
      emit(ProfileLoaded(user, userType: user.role));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Helper method to get user ID from different user object types
  String _getUserId(dynamic user) {
    if (user is Map) return user['id'].toString();
    // if (user is ) return user.id.toString();
    throw Exception('Unsupported user type');
  }

  Future<void> updateUserData(UserModel user) async {
    if (state is! ProfileLoaded) return;

    emit(ProfileLoading());

    try {
      final updatedUser = await profileRepository.updateUserData(
        userId: _getUserId(user.id),
        userData: user,
      );
      emit(
        ProfileLoaded(
          updatedUser,
          userType: 'user',
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Type-specific update methods
  Future<void> updateChefProfile({
    required ChefModel chef,
  }) async {
    final updatedChef = await profileRepository.updateChefData(
      uid: _getUserId(chef),
      chefData: chef,
    );

    emit(ProfileLoaded(updatedChef, userType: 'chef'));
  }

  Future<void> updateAuthorProfile({
    required AuthorModel author,
  }) async {
    final updatedAuthor = await profileRepository.updateAuthorData(
      uid: _getUserId(author),
      authorData: author,
    );

    emit(ProfileLoaded(updatedAuthor, userType: 'author'));
  }
}
