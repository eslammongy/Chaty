import 'exp_enum.dart';

abstract class AuthExceptionHandler {
  static handleException(error) {
    AuthExceptionsTypes status;
    switch (error) {
      case "invalid-email":
        status = AuthExceptionsTypes.invalidEmail;
        break;
      case "weak-password":
        status = AuthExceptionsTypes.weekPassword;
        break;
      case "wrong-password":
        status = AuthExceptionsTypes.wrongPassword;
        break;
      case "user-not-found":
        status = AuthExceptionsTypes.userNotFound;
        break;
      case "user-disabled":
        status = AuthExceptionsTypes.userDisabled;
        break;
      case "invalid-verification-code":
        status = AuthExceptionsTypes.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = AuthExceptionsTypes.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = AuthExceptionsTypes.emailAlreadyExists;
        break;
      case "notValidUserInput":
        status = AuthExceptionsTypes.notValidUserInput;
        break;
      case "auth/invalid-continue-uri":
        status = AuthExceptionsTypes.authInvalidContinueUri;
        break;
      case "auth/unauthorized-continue-uri":
        status = AuthExceptionsTypes.authUnauthorizedContinueUri;
        break;
      case "auth/missing-ios-bundle-id":
        status = AuthExceptionsTypes.authMissingIosBundleId;
        break;
      case " auth/invalid-email":
        status = AuthExceptionsTypes.authInvalidEmail;
        break;
      case 'unavailable':
        return AuthExceptionsTypes.unavailable;
      case 'permission-denied':
        return AuthExceptionsTypes.permissionDenied;
      case 'not-found':
        return AuthExceptionsTypes.notFound;
      case 'already-exists':
        return AuthExceptionsTypes.alreadyExists;
      case 'cancelled':
        return AuthExceptionsTypes.cancelled;
      case 'deadline-exceeded':
        return AuthExceptionsTypes.deadlineExceeded;
      case 'invalid-argument':
        return AuthExceptionsTypes.invalidArgument;
      default:
        status = AuthExceptionsTypes.undefined;
    }
    return status;
  }

  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthExceptionsTypes.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthExceptionsTypes.wrongPassword:
        errorMessage =
            "The password is invalid or the user does not have a password.";
        break;
      case AuthExceptionsTypes.weekPassword:
        errorMessage =
            "The password is invalid or the user does not have a password.";
        break;
      case AuthExceptionsTypes.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthExceptionsTypes.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthExceptionsTypes.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthExceptionsTypes.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthExceptionsTypes.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case AuthExceptionsTypes.notValidUserInput:
        errorMessage =
            "please make sure you entered all info or correct wrong info...";
        break;
      case AuthExceptionsTypes.authInvalidContinueUri:
        errorMessage = "The continue URL provided in the request is invalid.";
        break;
      case AuthExceptionsTypes.authUnauthorizedContinueUri:
        errorMessage =
            "The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.";
        break;
      case AuthExceptionsTypes.authMissingIosBundleId:
        errorMessage =
            "An iOS Bundle ID must be provided if an App Store ID is provided.";
        break;
      case AuthExceptionsTypes.authInvalidEmail:
        errorMessage = "Thrown if the email address is not valid.";
        break;
      case AuthExceptionsTypes.unavailable:
        return 'Service is currently unavailable. Please try again later.';
      case AuthExceptionsTypes.permissionDenied:
        return 'You do not have permission to perform this action.';
      case AuthExceptionsTypes.notFound:
        return 'The requested document or collection was not found.';
      case AuthExceptionsTypes.alreadyExists:
        return 'The document already exists.';
      case AuthExceptionsTypes.cancelled:
        return 'The operation was cancelled.';
      case AuthExceptionsTypes.deadlineExceeded:
        return 'The operation took too long to complete. Please try again.';
      case AuthExceptionsTypes.invalidArgument:
        return 'An invalid argument was provided.';
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
