import '../../domain/entities/hotspot_entity.dart';

/// Représentation Data Model du Hotspot (Data Layer)
class HotspotModel {
  final String id;
  final String name;
  final String wifiZone;
  final int dailySaleAmount;
  final int usersOnline;
  final HotspotRole role;
  final bool isActive;

  const HotspotModel({
    required this.id,
    required this.name,
    required this.wifiZone,
    required this.dailySaleAmount,
    required this.usersOnline,
    required this.role,
    required this.isActive,
  });

  factory HotspotModel.fromJson(Map<String, dynamic> json) => HotspotModel(
    id: json['id'] as String,
    name: json['name'] as String,
    wifiZone: json['wifiZone'] as String,
    dailySaleAmount: json['dailySaleAmount'] as int,
    usersOnline: json['usersOnline'] as int,
    role: HotspotRole.values.firstWhere(
          (e) => e.name == (json['role'] as String? ?? ''),
      orElse: () => HotspotRole.assistant,
    ),
    isActive: json['isActive'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'wifiZone': wifiZone,
    'dailySaleAmount': dailySaleAmount,
    'usersOnline': usersOnline,
    'role': role.name,
    'isActive': isActive,
  };

  HotspotEntity toEntity() => HotspotEntity(
    id: id,
    name: name,
    wifiZone: wifiZone,
    dailySaleAmount: dailySaleAmount,
    usersOnline: usersOnline,
    role: role,
    isActive: isActive,
  );

  factory HotspotModel.fromEntity(HotspotEntity entity) => HotspotModel(
    id: entity.id,
    name: entity.name,
    wifiZone: entity.wifiZone,
    dailySaleAmount: entity.dailySaleAmount,
    usersOnline: entity.usersOnline,
    role: entity.role,
    isActive: entity.isActive,
  );
}
