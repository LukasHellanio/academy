import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapPermissionDenied extends MapState {}

class MapPermissionGranted extends MapState {}

class MapLocationLoaded extends MapState {
  final LatLng userLocation;
  final List<LatLng> routePoints;

  const MapLocationLoaded(this.userLocation, {this.routePoints = const []});

  @override
  List<Object?> get props => [userLocation, routePoints];
}

class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}
