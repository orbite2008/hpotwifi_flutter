// lib/features/home/data/sources/hotspot_remote_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_paths.dart';
import '../../../../core/services/api_client.dart';
import '../../../../core/services/api_exception.dart';
import '../models/hotspot_model.dart';

class HotspotRemoteSource {
  final ApiClient _client;

  HotspotRemoteSource(this._client);

  /// Récupère la liste des hotspots de l'utilisateur connecté
  Future<List<HotspotModel>> fetchUserHotspots() async {
    final response = await _client.get(ApiPaths.listHotspot);

    // Vérification statut HTTP
    if (response.statusCode != 200) {
      throw ApiException(
        'Erreur lors de la récupération des hotspots',
        statusCode: response.statusCode,
      );
    }

    // Parsing JSON
    final Map<String, dynamic> body;
    try {
      body = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body);
    } catch (e) {
      throw ApiException(
        'Réponse JSON invalide',
        statusCode: response.statusCode,
      );
    }

    // Vérification success
    if (body['success'] != true) {
      final message = body['message']?.toString() ?? 'Échec de récupération';
      throw ApiException(message, statusCode: response.statusCode);
    }

    // Extraction liste hotspots
    final hotspotsList = body['hotspots'] as List<dynamic>?;

    if (hotspotsList == null) {
      throw ApiException(
        'Format de réponse invalide: champ "hotspots" manquant',
        statusCode: response.statusCode,
      );
    }

    // Si liste vide, retourner liste vide (pas une erreur)
    if (hotspotsList.isEmpty) {
      return [];
    }

    // Conversion en models
    try {
      return hotspotsList
          .map((json) => HotspotModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ApiException(
        'Erreur de parsing des hotspots: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }
}
