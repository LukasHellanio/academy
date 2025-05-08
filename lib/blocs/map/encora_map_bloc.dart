import 'dart:async';

import 'package:encora_community/blocs/map/encora_map_event.dart';
import 'package:encora_community/blocs/map/encora_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:encora_community/repositories/map_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository;
  StreamSubscription<Position>? _positionSubscription;

  MapBloc({required this.mapRepository}) : super(MapInitial()) {
    on<CheckLocationPermission>(_onCheckPermission);
    on<RequestLocationPermission>(_onRequestPermission);
    on<GetCurrentLocation>(_onGetLocation);
    on<DrawRouteToNearestSede>(_onDrawRoute);
    on<StartTrackingLocation>(_onStartTrackingLocation);
  }

  Future<void> _onCheckPermission(
    CheckLocationPermission event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    final isGranted = await mapRepository.isPermissionGranted();
    if (isGranted) {
      emit(MapPermissionGranted());
    } else {
      emit(MapPermissionDenied());
    }
  }

  Future<void> _onRequestPermission(
    RequestLocationPermission event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    final isGranted = await mapRepository.requestPermission();
    if (isGranted) {
      emit(MapPermissionGranted());
    } else {
      emit(MapPermissionDenied());
    }
  }

  Future<void> _onGetLocation(
    GetCurrentLocation event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    try {
      final LatLng location = await mapRepository.getCurrentLocation();
      emit(MapLocationLoaded(location));
    } catch (e) {
      emit(MapError('Failed to get location: $e'));
    }
  }

  Future<void> _onDrawRoute(
    DrawRouteToNearestSede event,
    Emitter<MapState> emit,
  ) async {
    try {
      final routePoints = [event.userLocation, event.sedeLocation];
      emit(MapLocationLoaded(event.userLocation, routePoints: routePoints));
    } catch (e) {
      emit(MapError('Failed to draw route: $e'));
    }
  }

  Future<void> _onStartTrackingLocation(
    StartTrackingLocation event,
    Emitter<MapState> emit,
  ) async {
    await _positionSubscription?.cancel();

    _positionSubscription = mapRepository.getPositionStream().listen((
      position,
    ) {
      final userLocation = LatLng(position.latitude, position.longitude);
      emit(MapLocationLoaded(userLocation));
    });
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
