import 'exp_enum.dart';

abstract class ExceptionHandler {
  static ExceptionsType handleException(error) {
    ExceptionsType status;
    switch (error) {
      case "invalid-email":
        status = ExceptionsType.invalidEmail;
        break;
      case "weak-password":
        status = ExceptionsType.weekPassword;
        break;
      case "wrong-password":
        status = ExceptionsType.wrongPassword;
        break;
      case "user-not-found":
        status = ExceptionsType.userNotFound;
        break;
      case "user-disabled":
        status = ExceptionsType.userDisabled;
        break;
      case "invalid-verification-code":
        status = ExceptionsType.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = ExceptionsType.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = ExceptionsType.emailAlreadyExists;
        break;
      case "notValidUserInput":
        status = ExceptionsType.notValidUserInput;
        break;
      case "auth/invalid-continue-uri":
        status = ExceptionsType.authInvalidContinueUri;
        break;
      case "auth/unauthorized-continue-uri":
        status = ExceptionsType.authUnauthorizedContinueUri;
        break;
      case "auth/missing-ios-bundle-id":
        status = ExceptionsType.authMissingIosBundleId;
        break;
      case " auth/invalid-email":
        status = ExceptionsType.authInvalidEmail;
        break;
      case 'unavailable':
        return ExceptionsType.unavailable;
      case 'permission-denied':
        return ExceptionsType.permissionDenied;
      case 'not-found':
        return ExceptionsType.notFound;
      case 'already-exists':
        return ExceptionsType.alreadyExists;
      case 'cancelled':
        return ExceptionsType.cancelled;
      case 'deadline-exceeded':
        return ExceptionsType.deadlineExceeded;
      case 'invalid-argument':
        return ExceptionsType.invalidArgument;
      default:
        status = ExceptionsType.undefined;
    }
    return status;
  }

  static String getExpMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case ExceptionsType.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case ExceptionsType.wrongPassword:
        errorMessage =
            "The password is invalid or the user does not have a password.";
        break;
      case ExceptionsType.weekPassword:
        errorMessage =
            "The password is invalid or the user does not have a password.";
        break;
      case ExceptionsType.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case ExceptionsType.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case ExceptionsType.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case ExceptionsType.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case ExceptionsType.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case ExceptionsType.notValidUserInput:
        errorMessage =
            "please make sure you entered all info or correct wrong info...";
        break;
      case ExceptionsType.authInvalidContinueUri:
        errorMessage = "The continue URL provided in the request is invalid.";
        break;
      case ExceptionsType.authUnauthorizedContinueUri:
        errorMessage =
            "The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.";
        break;
      case ExceptionsType.authMissingIosBundleId:
        errorMessage =
            "An iOS Bundle ID must be provided if an App Store ID is provided.";
        break;
      case ExceptionsType.authInvalidEmail:
        errorMessage = "Thrown if the email address is not valid.";
        break;
      case ExceptionsType.unavailable:
        return 'Service is currently unavailable. Please try again later.';
      case ExceptionsType.permissionDenied:
        return 'You do not have permission to perform this action.';
      case ExceptionsType.notFound:
        return 'The requested document or collection was not found.';
      case ExceptionsType.alreadyExists:
        return 'The document already exists.';
      case ExceptionsType.cancelled:
        return 'The operation was cancelled.';
      case ExceptionsType.deadlineExceeded:
        return 'The operation took too long to complete. Please try again.';
      case ExceptionsType.invalidArgument:
        return 'An invalid argument was provided.';
      default:
        errorMessage = "An undefined Error happened, please try again later.";
    }

    return errorMessage;
  }
}
