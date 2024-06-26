  bool   isValidEmail(email)   {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    print(emailRegExp.hasMatch(email));
    return emailRegExp.hasMatch(email);
  }

  bool  isValidName(name){
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    print(nameRegExp.hasMatch(name));

    return nameRegExp.hasMatch(name);
  }

  bool  isValidPassword(pass){
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(pass);
  }


  bool  isValidPhone(phone){
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(phone);
  }

