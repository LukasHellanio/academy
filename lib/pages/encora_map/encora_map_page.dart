import 'package:encora_community/blocs/map/encora_map_bloc.dart';
import 'package:encora_community/blocs/map/encora_map_event.dart';
import 'package:encora_community/blocs/map/encora_map_state.dart';
import 'package:encora_community/data/models/encora_location.dart';
import 'package:encora_community/repositories/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final List<EncoraLocation> encoraLocations = [
  EncoraLocation(
    name: 'Encora Academy Recife',
    position: LatLng(-8.0500, -34.9000),
  ),
  EncoraLocation(
    name: 'Encora Academy Campinas',
    position: LatLng(-22.9099, -47.0626),
  ),
];

class EncoraMapPage extends StatelessWidget {
  const EncoraMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              MapBloc(mapRepository: MapRepository())
                ..add(CheckLocationPermission()),
      child: Scaffold(
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MapPermissionDenied) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MapBloc>().add(RequestLocationPermission());
                  },
                  child: const Text('Grant Location Permission'),
                ),
              );
            } else if (state is MapPermissionGranted) {
              final bloc = context.read<MapBloc>();
              bloc.add(GetCurrentLocation());
              bloc.add(StartTrackingLocation());
              return const Center(child: CircularProgressIndicator());
            } else if (state is MapLocationLoaded) {
              if (state.routePoints.isEmpty) {
                final nearestSede = _findNearestSede(state.userLocation);
                context.read<MapBloc>().add(
                  DrawRouteToNearestSede(
                    userLocation: state.userLocation,
                    sedeLocation: nearestSede.position,
                  ),
                );
              }

              return FlutterMap(
                options: MapOptions(
                  initialCenter: state.userLocation,
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: state.userLocation,
                        width: 30,
                        height: 30,
                        child: const Icon(
                          Icons.person_pin_circle,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      ...encoraLocations.map(
                        (location) => Marker(
                          point: location.position,
                          width: 30,
                          height: 30,
                          child: const Icon(
                            Icons.school,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state.routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.routePoints,
                          color: Colors.red,
                          strokeWidth: 4,
                        ),
                      ],
                    ),
                ],
              );
            } else if (state is MapError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  EncoraLocation _findNearestSede(LatLng userLocation) {
    final Distance distance = Distance();
    EncoraLocation nearest = encoraLocations.first;
    double minDist = double.infinity;

    for (var location in encoraLocations) {
      final double d = distance(userLocation, location.position);
      if (d < minDist) {
        minDist = d;
        nearest = location;
      }
    }
    return nearest;
  }
}
