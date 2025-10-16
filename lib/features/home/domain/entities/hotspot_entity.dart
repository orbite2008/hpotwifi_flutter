// lib/features/home/domain/entities/hotspot_entity.dart

enum HotspotRole {
  owner,      // Propriétaire
  assistant,  // Assistant
  vendor;     // Vendeur

  /// Parse une chaîne en HotspotRole
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

class HotspotEntity {
  // Données de l'API
  final int id;
  final String hotspotwifiname;      // Nom WiFi
  final String hotspotzonename;      // Nom de la zone
  final String city;                 // Ville
  final String neighborhood;         // Quartier
  final String servername;           // Nom du serveur
  final String routername;           // Nom du routeur
  final String routerportname;       // Nom du port routeur
  final HotspotRole role;            // Rôle utilisateur
  final bool enable;                 // Actif/Inactif
  final double latitude;             // GPS
  final double longitude;            // GPS

  // Données temporaires (seront récupérées d'une autre API plus tard)
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

  // Getters pour compatibilité avec l'ancien code
  String get name => hotspotwifiname;
  String get wifiZone => hotspotzonename;
  bool get isActive => enable;

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
