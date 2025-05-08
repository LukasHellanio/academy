import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final String name;
  final String avatarUrl;
  final String userType;

  const DashboardState({
    this.name = 'Guest',
    this.avatarUrl = '',
    this.userType = 'Unknown',
  });

  DashboardState copyWith({String? name, String? avatarUrl, String? userType}) {
    return DashboardState(
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [name, avatarUrl, userType];
}
