class Hotspot {
  final String id;
  final String name;
  final String wifiZone;
  final int price;
  final bool isDailySale;
  final int usersOnline;
  final HotspotRole role;
  final bool isActive;

  const Hotspot({
    required this.id,
    required this.name,
    required this.wifiZone,
    required this.price,
    this.isDailySale = false,
    required this.usersOnline,
    required this.role,
    this.isActive = true,
  });
}

enum HotspotRole {
  owner,
  assistant,
}
