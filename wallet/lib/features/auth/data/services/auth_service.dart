import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/config/supabase_config.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  GoogleSignIn? _googleSignInInstance;

  GoogleSignIn get _googleSignIn {
    _googleSignInInstance ??= GoogleSignIn(
      serverClientId: SupabaseConfig.googleWebClientId,
      scopes: ['email', 'profile', 'openid'],
    );
    return _googleSignInInstance!;
  }

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sign in with Google using native Google Sign-In
  Future<bool> signInWithGoogle() async {
    try {
      // Debug: Check if client ID is loaded
      final clientId = SupabaseConfig.googleWebClientId;
      print('🔑 Google Web Client ID: ${clientId.isEmpty ? "EMPTY!" : clientId}');

      if (clientId.isEmpty) {
        throw Exception('Google Web Client ID is not configured in .env file');
      }

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Get the ID token
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw Exception('No ID Token found.');
      }

      // Sign in to Supabase with the Google ID token
      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return response.user != null;
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  /// Get current user
  User? get currentUser => _supabase.auth.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => _supabase.auth.currentUser != null;

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}
