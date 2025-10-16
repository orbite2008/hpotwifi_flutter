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

    if (response.statusCode != 200) {
      throw ApiException(
        'Erreur lors de la récupération des hotspots',
        statusCode: response.statusCode,
      );
    }

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

    if (body['success'] != true) {
      final message = body['message']?.toString() ?? 'Échec de récupération';
      throw ApiException(message, statusCode: response.statusCode);
    }

    final hotspotsList = body['hotspots'] as List<dynamic>?;

    if (hotspotsList == null) {
      throw ApiException(
        'Format de réponse invalide: champ "hotspots" manquant',
        statusCode: response.statusCode,
      );
    }

    if (hotspotsList.isEmpty) {
      return [];
    }

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

  /// Crée un nouveau hotspot
  Future<HotspotModel> createHotspot({
    required String hotspotwifiname,
    required String hotspotzonename,
    required String city,
    required String neighborhood,
  }) async {
    final body = {
      'hotspotwifiname': hotspotwifiname,
      'hotspotzonename': hotspotzonename,
      'city': city,
      'neighborhood': neighborhood,
    };

    final response = await _client.postJson(
      ApiPaths.createHotspot,
      body,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      try {
        final errorBody = jsonDecode(response.body);
        final message = errorBody['message']?.toString() ??
            'Erreur lors de la création du hotspot';
        throw ApiException(message, statusCode: response.statusCode);
      } catch (e) {
        throw ApiException(
          'Erreur lors de la création du hotspot',
          statusCode: response.statusCode,
        );
      }
    }

    final Map<String, dynamic> responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      throw ApiException(
        'Réponse JSON invalide',
        statusCode: response.statusCode,
      );
    }

    if (responseBody['success'] != true) {
      final message = responseBody['message']?.toString() ??
          'Échec de création du hotspot';
      throw ApiException(message, statusCode: response.statusCode);
    }

    final hotspotData = responseBody['hotspot'] as Map<String, dynamic>?;

    if (hotspotData == null) {
      throw ApiException(
        'Format de réponse invalide: champ "hotspot" manquant',
        statusCode: response.statusCode,
      );
    }

    try {
      return HotspotModel.fromJson(hotspotData);
    } catch (e) {
      throw ApiException(
        'Erreur de parsing du hotspot: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  /// Récupère les détails d'un hotspot par son ID
  Future<HotspotModel> fetchHotspotById(int id) async {
    final response = await _client.get(ApiPaths.getHotspotById(id));

    // Vérification statut HTTP
    if (response.statusCode != 200) {
      throw ApiException(
        'Erreur lors de la récupération du hotspot',
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

    // Extraction du hotspot
    final hotspotData = body['hotspot'] as Map<String, dynamic>?;

    if (hotspotData == null) {
      throw ApiException(
        'Format de réponse invalide: champ "hotspot" manquant',
        statusCode: response.statusCode,
      );
    }

    // Conversion en model
    try {
      return HotspotModel.fromJson(hotspotData);
    } catch (e) {
      throw ApiException(
        'Erreur de parsing du hotspot: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  /// ✅ NOUVEAU : Édite un hotspot existant
  Future<void> editHotspot({
    required int hotspotId,
    required String city,
    required bool enable,
  }) async {
    final body = {
      'city': city,
      'enable': enable,
    };

    final response = await _client.putJson(
      ApiPaths.editHotspot(hotspotId),
      body,
    );

    // Vérification statut HTTP
    if (response.statusCode != 200) {
      try {
        final errorBody = jsonDecode(response.body);
        final message = errorBody['message']?.toString() ??
            'Erreur lors de la modification du hotspot';
        throw ApiException(message, statusCode: response.statusCode);
      } catch (e) {
        throw ApiException(
          'Erreur lors de la modification du hotspot',
          statusCode: response.statusCode,
        );
      }
    }

    // Parsing JSON
    final Map<String, dynamic> responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      throw ApiException(
        'Réponse JSON invalide',
        statusCode: response.statusCode,
      );
    }

    // Vérification success
    if (responseBody['success'] != true) {
      final message = responseBody['message']?.toString() ??
          'Échec de modification du hotspot';
      throw ApiException(message, statusCode: response.statusCode);
    }

  }
}
