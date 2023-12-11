class UserFields {
  static final List<String> values = [
    // all fields
    country,fullname,email,password, 
  ];

  static String country = 'country';
  static String fullname = 'fullname';
  static String surname = 'surname';
  static String password = 'password';
  static String email = 'email';
}

class User {
  String country,fullname,email,password;

  User({
    required this.country,
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        country: map['country'],
        fullname: map['fullname'],
        email: map['email'],
        password: map['password'],
      );

  setName(String name1) {
    fullname = name1;
  }

  setCountry(String country){
    country = country;
  }

  setPassword(String password1) {
    password = password1;
  }

  setEmail(String email1) {
    email = email1;
  }

  String getfullName() {
    return this.fullname;
  }

  String getCountry(){
    return this.country;
  }

  String getPassword() {
    return this.password;
  }

  String getEmail() {
    return this.email;
  }

  Map<String, Object> toMap() {
    return {
      'country': country,
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }
}
