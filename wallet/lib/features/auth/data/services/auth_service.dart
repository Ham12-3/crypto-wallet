import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // Safely get Supabase client (handles case when Supabase is not initialized)
  SupabaseClient? get _supabase {
    try {
      return Supabase.instance.client;
    } catch (e) {
      print('⚠️  AuthService: Supabase not initialized - $e');
      return null;
    }
  }

  // Get current user
  User? get currentUser {
    try {
      return _supabase?.auth.currentUser;
    } catch (e) {
      print('⚠️  AuthService: Cannot get current user - $e');
      return null;
    }
  }

  // Get auth state changes stream
  Stream<AuthState> get authStateChanges {
    if (_supabase == null) {
      throw Exception('Supabase is not initialized. Please check your internet connection.');
    }
    return _supabase!.auth.onAuthStateChange;
  }

  // Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    if (_supabase == null) {
      throw Exception('Cannot sign up: Supabase is not initialized. Please check your internet connection.');
    }

    try {
      final response = await _supabase!.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (_supabase == null) {
      throw Exception('Cannot sign in: Supabase is not initialized. Please check your internet connection.');
    }

    try {
      final response = await _supabase!.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Sign in with Google (Android)
  Future<bool> signInWithGoogle() async {
    if (_supabase == null) {
      throw Exception('Cannot sign in with Google: Supabase is not initialized. Please check your internet connection.');
    }

    try {
      // Load client IDs from environment variables
      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
      final androidClientId = dotenv.env['GOOGLE_ANDROID_CLIENT_ID'];

      if (webClientId == null || androidClientId == null) {
        throw Exception('Google client IDs not configured in .env file');
      }

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: androidClientId,
        serverClientId: webClientId,
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in was cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception('No Access Token found');
      }
      if (idToken == null) {
        throw Exception('No ID Token found');
      }

      final response = await _supabase!.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return response.user != null;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  // Alternative: Sign in with Google using web redirect (simpler for web/mobile)
  Future<bool> signInWithGoogleRedirect() async {
    if (_supabase == null) {
      throw Exception('Cannot sign in with Google: Supabase is not initialized. Please check your internet connection.');
    }

    try {
      await _supabase!.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutterdemo://login-callback/',
      );
      return true;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    if (_supabase == null) {
      throw Exception('Cannot sign out: Supabase is not initialized.');
    }

    try {
      await _supabase!.auth.signOut();
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    if (_supabase == null) {
      throw Exception('Cannot reset password: Supabase is not initialized. Please check your internet connection.');
    }

    try {
      await _supabase!.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  // Update user password
  Future<UserResponse> updatePassword(String newPassword) async {
    if (_supabase == null) {
      throw Exception('Cannot update password: Supabase is not initialized. Please check your internet connection.');
    }

    try {
      final response = await _supabase!.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Password update failed: $e');
    }
  }

  // Check if user is signed in
  bool isSignedIn() {
    try {
      return _supabase?.auth.currentUser != null;
    } catch (e) {
      print('⚠️  AuthService: Cannot check sign-in status - $e');
      return false;
    }
  }
}