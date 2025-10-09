enum HotspotRole { owner, assistant /* , vendor */ }

class HotspotEntity {
  final String id;
  final String name;
  final String wifiZone;
  final int dailySaleAmount;
  final int usersOnline;
  final HotspotRole role;
  final bool isActive;

  const HotspotEntity({
    required this.id,
    required this.name,
    required this.wifiZone,
    required this.dailySaleAmount,
    required this.usersOnline,
    required this.role,
    required this.isActive,
  });

  HotspotEntity copyWith({
    String? id,
    String? name,
    String? wifiZone,
    int? dailySaleAmount,
    int? usersOnline,
    HotspotRole? role,
    bool? isActive,
  }) {
    return HotspotEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      wifiZone: wifiZone ?? this.wifiZone,
      dailySaleAmount: dailySaleAmount ?? this.dailySaleAmount,
      usersOnline: usersOnline ?? this.usersOnline,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }
}

