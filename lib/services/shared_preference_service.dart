import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// A high-performance service class for managing local data storage
/// using SharedPreferences with caching and type safety
class SharedPreferencesService {
  SharedPreferences? _prefs;
  final Map<String, dynamic> _cache = {};

  /// Initialize the service - call this once at app startup
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Ensure SharedPreferences is initialized
  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ==========================================================================
  // STRING OPERATIONS
  // ==========================================================================

  /// Save a string value
  Future<bool> setString(String key, String value) async {
    final prefs = await _preferences;
    _cache[key] = value;
    return prefs.setString(key, value);
  }

  /// Get a string value with optional default
  Future<String?> getString(String key, [String? defaultValue]) async {
    // Check cache first for performance
    if (_cache.containsKey(key)) {
      return _cache[key] as String?;
    }

    final prefs = await _preferences;
    final value = prefs.getString(key) ?? defaultValue;
    _cache[key] = value; // Cache the value
    return value;
  }

  // ==========================================================================
  // INTEGER OPERATIONS
  // ==========================================================================

  /// Save an integer value
  Future<bool> setInt(String key, int value) async {
    final prefs = await _preferences;
    _cache[key] = value;
    return prefs.setInt(key, value);
  }

  /// Get an integer value with optional default
  Future<int?> getInt(String key, [int? defaultValue]) async {
    if (_cache.containsKey(key)) {
      return _cache[key] as int?;
    }

    final prefs = await _preferences;
    final value = prefs.getInt(key) ?? defaultValue;
    _cache[key] = value;
    return value;
  }

  // ==========================================================================
  // DOUBLE OPERATIONS
  // ==========================================================================

  /// Save a double value
  Future<bool> setDouble(String key, double value) async {
    final prefs = await _preferences;
    _cache[key] = value;
    return prefs.setDouble(key, value);
  }

  /// Get a double value with optional default
  Future<double?> getDouble(String key, [double? defaultValue]) async {
    if (_cache.containsKey(key)) {
      return _cache[key] as double?;
    }

    final prefs = await _preferences;
    final value = prefs.getDouble(key) ?? defaultValue;
    _cache[key] = value;
    return value;
  }

  // ==========================================================================
  // BOOLEAN OPERATIONS
  // ==========================================================================

  /// Save a boolean value
  Future<bool> setBool(String key, bool value) async {
    final prefs = await _preferences;
    _cache[key] = value;
    return prefs.setBool(key, value);
  }

  /// Get a boolean value with optional default
  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    if (_cache.containsKey(key)) {
      return _cache[key] as bool;
    }

    final prefs = await _preferences;
    final value = prefs.getBool(key) ?? defaultValue;
    _cache[key] = value;
    return value;
  }

  // ==========================================================================
  // LIST OPERATIONS
  // ==========================================================================

  /// Save a list of strings
  Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await _preferences;
    _cache[key] = value;
    return prefs.setStringList(key, value);
  }

  /// Get a list of strings with optional default
  Future<List<String>?> getStringList(String key, [List<String>? defaultValue]) async {
    if (_cache.containsKey(key)) {
      return _cache[key] as List<String>?;
    }

    final prefs = await _preferences;
    final value = prefs.getStringList(key) ?? defaultValue;
    _cache[key] = value;
    return value;
  }

  // ==========================================================================
  // OBJECT OPERATIONS (JSON)
  // ==========================================================================

  /// Save an object as JSON string
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    return setString(key, jsonString);
  }

  /// Get an object from JSON string
  Future<Map<String, dynamic>?> getObject(String key) async {
    final jsonString = await getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // Log error or handle as needed
      return null;
    }
  }

  /// Save a list of objects as JSON string
  Future<bool> setObjectList(String key, List<Map<String, dynamic>> value) async {
    final jsonString = jsonEncode(value);
    return setString(key, jsonString);
  }

  /// Get a list of objects from JSON string
  Future<List<Map<String, dynamic>>?> getObjectList(String key) async {
    final jsonString = await getString(key);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      // Log error or handle as needed
      return null;
    }
  }

  // ==========================================================================
  // UTILITY OPERATIONS
  // ==========================================================================

  /// Check if a key exists
  Future<bool> containsKey(String key) async {
    if (_cache.containsKey(key)) return true;

    final prefs = await _preferences;
    return prefs.containsKey(key);
  }

  /// Remove a specific key
  Future<bool> remove(String key) async {
    final prefs = await _preferences;
    _cache.remove(key);
    return prefs.remove(key);
  }

  /// Clear all stored data
  Future<bool> clear() async {
    final prefs = await _preferences;
    _cache.clear();
    return prefs.clear();
  }

  /// Get all keys
  Future<Set<String>> getAllKeys() async {
    final prefs = await _preferences;
    return prefs.getKeys();
  }

  /// Reload preferences from disk (useful after external changes)
  Future<void> reload() async {
    final prefs = await _preferences;
    _cache.clear();
    await prefs.reload();
  }

  // ==========================================================================
  // BATCH OPERATIONS
  // ==========================================================================

  /// Set multiple values at once for better performance
  Future<List<bool>> setBatch(Map<String, dynamic> values) async {
    final results = <bool>[];

    for (final entry in values.entries) {
      final key = entry.key;
      final value = entry.value;

      bool result;
      if (value is String) {
        result = await setString(key, value);
      } else if (value is int) {
        result = await setInt(key, value);
      } else if (value is double) {
        result = await setDouble(key, value);
      } else if (value is bool) {
        result = await setBool(key, value);
      } else if (value is List<String>) {
        result = await setStringList(key, value);
      } else if (value is Map<String, dynamic>) {
        result = await setObject(key, value);
      } else {
        result = false;
      }

      results.add(result);
    }

    return results;
  }

  /// Get multiple values at once
  Future<Map<String, dynamic>> getBatch(List<String> keys) async {
    final result = <String, dynamic>{};

    for (final key in keys) {
      // Try to determine the type by checking what exists
      final prefs = await _preferences;
      if (prefs.containsKey(key)) {
        final value = prefs.get(key);
        result[key] = value;
        _cache[key] = value; // Cache it
      }
    }

    return result;
  }

  // ==========================================================================
  // CACHE MANAGEMENT
  // ==========================================================================

  /// Clear the in-memory cache
  void clearCache() {
    _cache.clear();
  }

  /// Get cache size for monitoring
  int get cacheSize => _cache.length;

  /// Preload frequently used keys into cache
  Future<void> preloadKeys(List<String> keys) async {
    await getBatch(keys);
  }
}
