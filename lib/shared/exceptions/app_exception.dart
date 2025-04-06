// Base exception class
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});

  @override
  String toString() =>
      'AppException: $message ${code != null ? '($code)' : ''} ${details != null ? '[Details: $details]' : ''}';
}

// Firebase Authentication Exceptions
class AuthException extends AppException {
  AuthException(String message, {String? code, dynamic details})
      : super(message, code: code, details: details);

  factory AuthException.fromFirebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return AuthException(
          'An account already exists with this email.',
          code: e.code,
          details: e.message,
        );
      case 'invalid-email':
        return AuthException(
          'The email address is invalid.',
          code: e.code,
          details: e.message,
        );
      case 'user-disabled':
        return AuthException(
          'This user account has been disabled.',
          code: e.code,
          details: e.message,
        );
      case 'user-not-found':
        return AuthException(
          'No user found with this email.',
          code: e.code,
          details: e.message,
        );
      case 'wrong-password':
        return AuthException(
          'Incorrect password.',
          code: e.code,
          details: e.message,
        );
      case 'weak-password':
        return AuthException(
          'The password provided is too weak.',
          code: e.code,
          details: e.message,
        );
      case 'operation-not-allowed':
        return AuthException(
          'This operation is not allowed.',
          code: e.code,
          details: e.message,
        );
      case 'account-exists-with-different-credential':
        return AuthException(
          'An account already exists with the same email but different sign-in credentials.',
          code: e.code,
          details: e.message,
        );
      case 'invalid-credential':
        return AuthException(
          'The credential is invalid.',
          code: e.code,
          details: e.message,
        );
      case 'invalid-verification-code':
        return AuthException(
          'The verification code is invalid.',
          code: e.code,
          details: e.message,
        );
      case 'invalid-verification-id':
        return AuthException(
          'The verification ID is invalid.',
          code: e.code,
          details: e.message,
        );
      default:
        return AuthException(
          'An authentication error occurred.',
          code: e.code,
          details: e.message,
        );
    }
  }
}

// Firestore Exceptions
class DatabaseException extends AppException {
  DatabaseException(String message, {String? code, dynamic details})
      : super(message, code: code, details: details);

  factory DatabaseException.fromFirestore(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return DatabaseException(
          'You don\'t have permission to access this resource.',
          code: e.code,
          details: e.message,
        );
      case 'not-found':
        return DatabaseException(
          'The requested document was not found.',
          code: e.code,
          details: e.message,
        );
      case 'already-exists':
        return DatabaseException(
          'The document already exists.',
          code: e.code,
          details: e.message,
        );
      case 'failed-precondition':
        return DatabaseException(
          'The operation was rejected due to the current system state.',
          code: e.code,
          details: e.message,
        );
      case 'aborted':
        return DatabaseException(
          'The operation was aborted.',
          code: e.code,
          details: e.message,
        );
      case 'out-of-range':
        return DatabaseException(
          'Operation was attempted past the valid range.',
          code: e.code,
          details: e.message,
        );
      case 'unimplemented':
        return DatabaseException(
          'Operation is not implemented or not supported.',
          code: e.code,
          details: e.message,
        );
      case 'resource-exhausted':
        return DatabaseException(
          'Resource has been exhausted (e.g., quota exceeded).',
          code: e.code,
          details: e.message,
        );
      default:
        return DatabaseException(
          'A database error occurred.',
          code: e.code,
          details: e.message,
        );
    }
  }
}

// Network Exceptions
class NetworkException extends AppException {
  NetworkException(String message, {String? code, dynamic details})
      : super(message, code: code, details: details);

  factory NetworkException.fromError(dynamic error) {
    if (error is TimeoutException) {
      return NetworkException(
        'Connection timeout. Please check your internet connection.',
        code: 'timeout',
        details: error.toString(),
      );
    } else if (error is SocketException) {
      return NetworkException(
        'No internet connection.',
        code: 'no_connection',
        details: error.toString(),
      );
    } else {
      return NetworkException(
        'A network error occurred.',
        details: error.toString(),
      );
    }
  }
}

// Validation Exceptions
class ValidationException extends AppException {
  ValidationException(String message, {String? code, dynamic details})
      : super(message, code: code, details: details);

  factory ValidationException.invalidEmail() {
    return ValidationException(
      'Please enter a valid email address.',
      code: 'invalid_email',
    );
  }

  factory ValidationException.invalidPassword() {
    return ValidationException(
      'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number.',
      code: 'invalid_password',
    );
  }

  factory ValidationException.emptyField(String fieldName) {
    return ValidationException(
      '$fieldName cannot be empty.',
      code: 'empty_field',
      details: {'field': fieldName},
    );
  }
}

// Cache Exceptions
class CacheException extends AppException {
  CacheException(String message, {String? code, dynamic details})
      : super(message, code: code, details: details);

  factory CacheException.readError(String key, dynamic error) {
    return CacheException(
      'Failed to read from cache.',
      code: 'cache_read_error',
      details: {'key': key, 'error': error.toString()},
    );
  }

  factory CacheException.writeError(String key, dynamic error) {
    return CacheException(
      'Failed to write to cache.',
      code: 'cache_write_error',
      details: {'key': key, 'error': error.toString()},
    );
  }
}

// Unknown Exceptions
class UnknownException extends AppException {
  UnknownException(dynamic error)
      : super(
          'An unexpected error occurred.',
          code: 'unknown_error',
          details: error.toString(),
        );
}
