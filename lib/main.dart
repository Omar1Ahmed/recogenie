import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/injection.dart';
import 'core/routing/app_routing.dart';
import 'core/routing/routs.dart';
import 'firebase_options.dart' show DefaultFirebaseOptions;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: 'https://kkllntsdctvnypiezmfz.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrbGxudHNkY3R2bnlwaWV6bWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM1NTYwMTQsImV4cCI6MjA2OTEzMjAxNH0.omWRI8KqG72LELRJkCu-QOr8C7QqpeN2qcUbiYk-3HI');
  await Firebase.initializeApp(
    name: 'Recogenie',
    options: DefaultFirebaseOptions.currentPlatform,
  );


  configureDependencies();


  runApp(MyApp(appRouter: AppRouts()));

}

class MyApp extends StatelessWidget {
  final AppRouts appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.authScreen,
      onGenerateRoute: appRouter.generateRoute,

    );
  }
}

