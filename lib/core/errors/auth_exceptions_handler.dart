import 'exp_enum.dart';

abstract class ExceptionHandler {
  static handleException(error) {
    FirebaseExpTypes status;
    switch (error) {
      case "invalid-email":
        status = FirebaseExpTypes.invalidEmail;
        break;
      case "weak-password":
        status = FirebaseExpTypes.weekPassword;
        break;
      case "wrong-password":
        status = FirebaseExpTypes.wrongPassword;
        break;
      case "user-not-found":
        status = FirebaseExpTypes.userNotFound;
        break;
      case "user-disabled":
        status = FirebaseExpTypes.userDisabled;
        break;
      case "invalid-verification-code":
        status = FirebaseExpTypes.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = FirebaseExpTypes.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = FirebaseExpTypes.emailAlreadyExists;
        break;
      case "notValidUserInput":
        status = FirebaseExpTypes.notValidUserInput;
        break;
      case "auth/invalid-continue-uri":
        status = FirebaseExpTypes.authInvalidContinueUri;
        break;
      case "auth/unauthorized-continue-uri":
        status = FirebaseExpTypes.authUnauthorizedContinueUri;
        break;
      case "auth/missing-ios-bundle-id":
        status = FirebaseExpTypes.authMissingIosBundleId;
        break;
      case " auth/invalid-email":
        status = FirebaseExpTypes.authInvalidEmail;
        break;
      case 'unavailable':
        return FirebaseExpTypes.unavailable;
      case 'permission-denied':
        return FirebaseExpTypes.permissionDenied;
      case 'not-found':
        return FirebaseExpTypes.notFound;
      case 'already-exists':
        return FirebaseExpTypes.alreadyExists;
      case 'cancelled':
        return FirebaseExpTypes.cancelled;
      case 'deadline-exceeded':
        return FirebaseExpTypes.deadlineExceeded;
      case 'invalid-argument':
        return FirebaseExpTypes.invalidArgument;
      default:
        status = FirebaseExpTypes.undefined;
    }
    return status;
  }

  static String getExpMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case FirebaseExpTypes.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case FirebaseExpTypes.wrongPassword:
        errorMessage =
            "The password is invalid or the user does not have a password.";
        break;
      case FirebaseExpTypes.weekPassword:
        errorMessage =
            "The password is invalid or the user does not have a password.";
        break;
      case FirebaseExpTypes.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case FirebaseExpTypes.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case FirebaseExpTypes.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case FirebaseExpTypes.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case FirebaseExpTypes.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case FirebaseExpTypes.notValidUserInput:
        errorMessage =
            "please make sure you entered all info or correct wrong info...";
        break;
      case FirebaseExpTypes.authInvalidContinueUri:
        errorMessage = "The continue URL provided in the request is invalid.";
        break;
      case FirebaseExpTypes.authUnauthorizedContinueUri:
        errorMessage =
            "The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.";
        break;
      case FirebaseExpTypes.authMissingIosBundleId:
        errorMessage =
            "An iOS Bundle ID must be provided if an App Store ID is provided.";
        break;
      case FirebaseExpTypes.authInvalidEmail:
        errorMessage = "Thrown if the email address is not valid.";
        break;
      case FirebaseExpTypes.unavailable:
        return 'Service is currently unavailable. Please try again later.';
      case FirebaseExpTypes.permissionDenied:
        return 'You do not have permission to perform this action.';
      case FirebaseExpTypes.notFound:
        return 'The requested document or collection was not found.';
      case FirebaseExpTypes.alreadyExists:
        return 'The document already exists.';
      case FirebaseExpTypes.cancelled:
        return 'The operation was cancelled.';
      case FirebaseExpTypes.deadlineExceeded:
        return 'The operation took too long to complete. Please try again.';
      case FirebaseExpTypes.invalidArgument:
        return 'An invalid argument was provided.';
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
