import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/config/supabase_config.dart';
import 'core/services/onboarding_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('⚠️  Warning: Failed to load .env file: $e');
    print('   App will continue but backend features may not work');
  }

  // Initialize Supabase with error handling
  try {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
    print('✅ Supabase initialized successfully');
  } catch (e) {
    print('⚠️  Warning: Failed to initialize Supabase: $e');
    print('   This is likely due to:');
    print('   - No internet connection');
    print('   - Invalid Supabase URL or credentials');
    print('   - Network/firewall restrictions');
    print('   App will continue but authentication features may not work');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: OnboardingService.isOnboardingComplete(),
      builder: (context, snapshot) {
        // Show loading screen while checking onboarding status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ),
          );
        }

        // Handle errors - default to showing onboarding
        if (snapshot.hasError) {
          print('⚠️  Error checking onboarding status: ${snapshot.error}');
          print('   Defaulting to show onboarding screen');
        }

        // Determine initial route based on onboarding status
        // Default to onboarding if there's an error or data is null
        final isOnboardingComplete = snapshot.data ?? false;
        final initialRoute = isOnboardingComplete
            ? AppRoutes.login
            : AppRoutes.onboarding;

        return MaterialApp(
          title: 'CryptoWallet',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: initialRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}