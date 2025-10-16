// lib/features/home/data/models/hotspot_model.dart

import '../../domain/entities/hotspot_entity.dart';

class HotspotModel {
  final int id;
  final String hotspotwifiname;
  final String hotspotzonename;
  final String city;
  final String neighborhood;
  final String servername;
  final String routername;
  final String routerportname;
  final String role;
  final bool enable;
  final double latitude;
  final double longitude;

  const HotspotModel({
    required this.id,
    required this.hotspotwifiname,
    required this.hotspotzonename,
    required this.city,
    required this.neighborhood,
    required this.servername,
    required this.routername,
    required this.routerportname,
    required this.role,
    required this.enable,
    required this.latitude,
    required this.longitude,
  });

  /// Parse depuis JSON API
  factory HotspotModel.fromJson(Map<String, dynamic> json) {
    return HotspotModel(
      id: json['id'] as int,
      hotspotwifiname: json['hotspotwifiname'] as String? ?? '',
      hotspotzonename: json['hotspotzonename'] as String? ?? '',
      city: json['city'] as String? ?? '',
      neighborhood: json['neighborhood'] as String? ?? '',
      servername: json['servername'] as String? ?? '',
      routername: json['routername'] as String? ?? '',
      routerportname: json['routerportname'] as String? ?? '',
      role: json['role'] as String? ?? 'assistant',
      enable: json['enable'] as bool? ?? true,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Convertit vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotspotwifiname': hotspotwifiname,
      'hotspotzonename': hotspotzonename,
      'city': city,
      'neighborhood': neighborhood,
      'servername': servername,
      'routername': routername,
      'routerportname': routerportname,
      'role': role,
      'enable': enable,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Convertit vers Entity (Domain)
  HotspotEntity toEntity() {
    return HotspotEntity(
      id: id,
      hotspotwifiname: hotspotwifiname,
      hotspotzonename: hotspotzonename,
      city: city,
      neighborhood: neighborhood,
      servername: servername,
      routername: routername,
      routerportname: routerportname,
      role: HotspotRole.fromString(role),
      enable: enable,
      latitude: latitude,
      longitude: longitude,
      dailySaleAmount: 0,  // Valeur par défaut
      usersOnline: 0,      // Valeur par défaut
    );
  }

  /// Convertit depuis Entity
  factory HotspotModel.fromEntity(HotspotEntity entity) {
    return HotspotModel(
      id: entity.id,
      hotspotwifiname: entity.hotspotwifiname,
      hotspotzonename: entity.hotspotzonename,
      city: entity.city,
      neighborhood: entity.neighborhood,
      servername: entity.servername,
      routername: entity.routername,
      routerportname: entity.routerportname,
      role: entity.role.name,
      enable: entity.enable,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
