import 'package:arrivo_flutter/api/user.model.dart';
import 'package:arrivo_flutter/controllers/user.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userFutureProvider = FutureProvider<User?>((ref) async {
  try {
    final userController = ref.read(userControllerProvider);
    final user = await userController.getCurrentUser();
    return user;
  } catch (e) {
    return null;
  }
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(User? user) : super(user);

  set(User user) {
    state = user;
  }

  clear() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  final user = ref.watch(userFutureProvider);
  return user.when(
    loading: () => UserNotifier(null),
    error: (err, stack) => UserNotifier(null),
    data: (data) => UserNotifier(data),
  );
});
