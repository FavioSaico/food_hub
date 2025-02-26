import 'package:firebase_remote_config/firebase_remote_config.dart';

class Environment {
  static final remoteConfig = FirebaseRemoteConfig.instance;
  
  static String apiKey = Environment.remoteConfig.getString('API_KEY_STACK_AI');
  static String orgId = Environment.remoteConfig.getString('ORG_ID_STACK_AI');
  static String tabId = Environment.remoteConfig.getString('TAB_ID_STACK_AI');
  static String backPort = Environment.remoteConfig.getString('BACKEND_EC2_PORT');

}

Future<void> setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  // Establecer valores predeterminados en caso de que la red falle
  await remoteConfig.setDefaults(<String, dynamic>{
    'API_KEY_STACK_AI': '',
    'ORG_ID_STACK_AI': '',
    'TAB_ID_STACK_AI': '',
    'BACKEND_EC2_PORT': 'http://10.0.2.2:3000'
  });

  // Configurar opciones de Remote Config
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 60), // Tiempo máximo de espera
    minimumFetchInterval: const Duration(minutes: 30), // Tiempo entre actualizaciones
  ));

  try {
    // Obtener y activar valores remotos
    await remoteConfig.fetchAndActivate();
  } catch (e) {
    print("Error cargando Remote Config: $e");
  }
}