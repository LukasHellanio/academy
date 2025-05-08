import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class CheckLocationPermission extends MapEvent {}

class RequestLocationPermission extends MapEvent {}

class GetCurrentLocation extends MapEvent {}

class StartTrackingLocation extends MapEvent {}

class DrawRouteToNearestSede extends MapEvent {
  final LatLng userLocation;
  final LatLng sedeLocation;

  const DrawRouteToNearestSede({
    required this.userLocation,
    required this.sedeLocation,
  });

  @override
  List<Object?> get props => [userLocation, sedeLocation];
}
