// lib/features/home/domain/entities/hotspot_entity.dart

/// Rôle de l'utilisateur pour un hotspot
enum HotspotRole {
  owner,
  assistant,
  vendor;

  /// Parse une chaîne en HotspotRole avec support multilingue
  static HotspotRole fromString(String value) {
    final lower = value.toLowerCase().trim();
    switch (lower) {
      case 'owner':
      case 'propriétaire':
      case 'proprietaire':
        return HotspotRole.owner;
      case 'assistant':
        return HotspotRole.assistant;
      case 'vendor':
      case 'vendeur':
        return HotspotRole.vendor;
      default:
        return HotspotRole.assistant; // Fallback sécurisé
    }
  }
}

/// Entité représentant un hotspot WiFi dans le domain layer
class HotspotEntity {
  // ═══════════════════════════════════════════════════════════════
  // DONNÉES DE L'API (persistantes)
  // ═══════════════════════════════════════════════════════════════

  final int id;
  final String hotspotwifiname;
  final String hotspotzonename;
  final String city;
  final String neighborhood;
  final String servername;
  final String routername;
  final String routerportname;
  final HotspotRole role;
  final bool enable;
  final double latitude;
  final double longitude;

  // ═══════════════════════════════════════════════════════════════
  // DONNÉES TEMPORAIRES (seront récupérées d'une API dédiée plus tard)
  // ═══════════════════════════════════════════════════════════════

  final int dailySaleAmount;
  final int usersOnline;

  const HotspotEntity({
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
    this.dailySaleAmount = 0,
    this.usersOnline = 0,
  });

  // ═══════════════════════════════════════════════════════════════
  // GETTERS DE COMPATIBILITÉ (pour l'ancien code)
  // ═══════════════════════════════════════════════════════════════

  /// Alias pour hotspotwifiname
  String get name => hotspotwifiname;

  /// Alias pour hotspotzonename
  String get wifiZone => hotspotzonename;

  /// Alias pour enable
  bool get isActive => enable;

  // ═══════════════════════════════════════════════════════════════
  // MÉTHODE COPYWITH (pour l'immutabilité)
  // ═══════════════════════════════════════════════════════════════

  HotspotEntity copyWith({
    int? id,
    String? hotspotwifiname,
    String? hotspotzonename,
    String? city,
    String? neighborhood,
    String? servername,
    String? routername,
    String? routerportname,
    HotspotRole? role,
    bool? enable,
    double? latitude,
    double? longitude,
    int? dailySaleAmount,
    int? usersOnline,
  }) {
    return HotspotEntity(
      id: id ?? this.id,
      hotspotwifiname: hotspotwifiname ?? this.hotspotwifiname,
      hotspotzonename: hotspotzonename ?? this.hotspotzonename,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      servername: servername ?? this.servername,
      routername: routername ?? this.routername,
      routerportname: routerportname ?? this.routerportname,
      role: role ?? this.role,
      enable: enable ?? this.enable,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      dailySaleAmount: dailySaleAmount ?? this.dailySaleAmount,
      usersOnline: usersOnline ?? this.usersOnline,
    );
  }
}
