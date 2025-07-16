import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String LOGIN_ID_KEY = 'LOGIN_ID';
const String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());