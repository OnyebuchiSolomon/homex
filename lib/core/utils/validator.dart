class Validator {
  static String? validate(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Required.';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (value!.isEmpty) {
      return 'Required.';
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email.';
    } else {
      return null;
    }
  }

  static String? validatePhone(String? value, [String? countryCode]) {
    //Nigeria number validator
    /*Pattern pattern =
        r'(\+234|234|0)(701|702|703|704|705|706|707|708|709|802|803|804|805|806|807|808|809|810|811|812|813|814|815|816|817|818|819|909|908|901|902|903|904|905|906|907)([0-9]{7})$';*/
    Pattern pattern = r'(\+[0-9]|0)([0-9]{6,14})$';
    RegExp regex = RegExp(pattern as String);
    if (value!.isEmpty) {
      return 'Required.';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid mobile number.';
    } else if (countryCode != null && countryCode.isEmpty) {
      return 'Country code is required';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password,
      [bool confirm = false, String? pass]) {
    if (confirm) {
      if (password == null || password.isEmpty) {
        return 'Required.';
      }
      if (password != pass) {
        return 'Password Mismatch.';
      }
      return null;
    }
    if (password == null || password.isEmpty) {
      return 'Required.';
    }
    if (password.length < 6) {
      return 'Password too short.';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase.';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase.';
    }
    if (!password.contains(RegExp(r'\d'))) {
      return 'Password must contain at least one digit.';
    }
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character.';
   // }
    else {
      return null;
    }
  }

  static String? validateDropdown(dynamic value) {
    if (value == null) {
      return 'Required.';
    } else {
      return null;
    }
  }

  static String? validatePin(dynamic value, {int length=6}) {
    if (value == null || value.isEmpty) {
      return 'Required.';
    }
    if (value.length < length) {
      return 'Pin must be at least $length digits.';
    } else {
      return null;
    }
  }
}
