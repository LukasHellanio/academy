import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'package:encora_community/data/services/auth_service.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AuthService authService;

  DashboardBloc({required this.authService}) : super(const DashboardState()) {
    on<LoadUserData>((event, emit) async {
      final user = await authService.getLoggedUser();
      if (user != null) {
        emit(
          state.copyWith(
            name: user.name,
            avatarUrl: user.avatarUrl,
            userType: user.description,
          ),
        );
      }
    });
  }
}
