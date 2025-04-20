import 'package:bloc/bloc.dart';
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
    initialize();
    _authCubit.stream.listen((authState) {
      if (authState.isAuthenticated && authState.user != null) {
        loadProfile(authState.user!);
      } else {
        emit(const ProfileError("User not authenticated"));
      }
    });
  }

  void initialize() {
    final user = _authCubit.state.user;
    if (user != null) {
      loadProfile(user);
    } else {
      emit(const ProfileError("User not authenticated"));
    }
  }

  Future<void> loadProfile(dynamic user) async {
    emit(ProfileLoading());
    try {
      emit(ProfileLoaded(user, userType: user.role));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUserData(UserModel user) async {
    if (state is! ProfileLoaded) return;

    emit(ProfileLoading());

    try {
      final updatedUser = await profileRepository.updateUserData(
        userId: user.id,
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
      uid: chef.id,
      chefData: chef,
    );

    emit(ProfileLoaded(updatedChef, userType: 'chef'));
  }

  Future<void> updateAuthorProfile({
    required AuthorModel author,
  }) async {
    final updatedAuthor = await profileRepository.updateAuthorData(
      uid: author.id,
      authorData: author,
    );

    emit(ProfileLoaded(updatedAuthor, userType: 'author'));
  }
}
