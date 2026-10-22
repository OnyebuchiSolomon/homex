enum RouteStyle { material, cupertino, fadeIn, slideIn, slideUp }

enum ImageType { svg, network, networkCached, asset, file }

enum ToastType { success, error, info }

enum DropdownType { form, button, menu }
enum MessageType { success, error, info }
enum ViewState { idle, loading, processing, success, failed }
enum ErrorMessage { insufficient, network, password ,other}

enum CommissionType {
  percentage, amount;

  static CommissionType? fromString(String? value) {
    switch (value) {
      case 'percentage':
        return CommissionType.percentage;
      case 'amount':
        return CommissionType.amount;
      default:
        return null;
    }
  }
}

enum AccountType {
  admin, staff;

  static AccountType? fromString(String? value) {
    switch (value) {
      case 'admin':
        return AccountType.admin;
      case 'staff':
        return AccountType.staff;
      default:
        return null;
    }
  }
}