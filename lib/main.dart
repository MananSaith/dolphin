import 'package:dolphin/shared/app_imports/app_imports.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'config/dependency_injection/dependency_injections.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AuthBinding().dependencies();
  runApp(const MyApp());
}
