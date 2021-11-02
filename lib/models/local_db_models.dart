class UserLoginModel {
  final String _colId = 'id';
  final String _colName = 'name';
  final String _colEmail = 'email';
  final String _colRole = 'role';
  final String _colLoginDate = 'logindate';
  final String _colIsLogin = 'islogin';
  final String _colPicture = 'picture';

  String id;
  String name;
  String email;
  String role;
  String isLogin;
  String loginDate;
  String picture;
  List loans;

  UserLoginModel();

  UserLoginModel.fromNap(Map<String, dynamic> map) {
    id = map[_colId];
    name = map[_colName];
    email = map[_colEmail];
    role = map[_colRole];
    isLogin = map[_colIsLogin];
    loginDate = map[_colLoginDate];
    picture = map[_colPicture];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      _colId: id,
      _colName: name,
      _colEmail: email,
      _colRole: role,
      _colIsLogin: isLogin,
      _colLoginDate: loginDate,
      _colPicture: picture
    };
    return map;
  }
}

class LoanRequestModel {
  final String _colId = 'id';
  final String _colRepaymentDays = 'repaymentdays';
  final String _colEmail = 'email';
  final String _colInterestRate = 'interestrate';
  final String _colReqAmt = 'requestedamount';
  final String _colRepAmt = 'repayamount';
  final String _colRepDate = 'repaydate';
  final String _colPromo = 'promocode';
  final String _colFirstName = 'firstname';
  final String _colLastName = 'lastname';
  final String _colGender = 'gender';
  final String _colDob = 'dateofbirth';
  final String _colIdn = 'idnumber';
  final String _colPass = 'password';
  final String _colPhone = 'phone';
  final String _colRegion = 'region';
  final String _colCity = 'city';
  final String _colStreet = 'street';
  final String _colHaddr = 'houseaddress';
  final String _colIdfront = 'idfront';
  final String _colIdback = 'idback';
  final String _colIdselfie = 'idselfie';

  String id,
      repaymentdays,
      interestrate,
      requestedamount,
      repayamount,
      repaydate,
      promocode,
      firstname,
      lastname,
      gender,
      dateofbirth,
      idnumber,
      password,
      email,
      phone,
      region,
      city,
      street,
      houseaddress,
      idfront,
      idback,
      idselfie;

  LoanRequestModel();

  LoanRequestModel.fromNap(Map<String, dynamic> map) {
    id = map[_colId];
    requestedamount = map[_colReqAmt];
    repaymentdays = map[_colRepaymentDays];
    interestrate = map[_colInterestRate];
    repayamount = map[_colRepAmt];
    repaydate = map[_colRepDate];
    promocode = map[_colPromo];
    firstname = map[_colFirstName];
    lastname = map[_colLastName];
    gender = map[_colGender];
    dateofbirth = map[_colDob];
    idnumber = map[_colIdn];
    password = map[_colPass];
    email = map[_colEmail];
    phone = map[_colPhone];
    region = map[_colRegion];
    city = map[_colCity];
    street = map[_colStreet];
    houseaddress = map[_colHaddr];
    idfront = map[_colIdfront];
    idback = map[_colIdback];
    idselfie = map[_colIdselfie];
  }

  Map<String, dynamic> lrqToMap() {
    var map = <String, dynamic>{
      _colId: id,
      _colReqAmt: requestedamount,
      _colRepaymentDays: repaymentdays,
      _colInterestRate: interestrate,
      _colRepAmt: repayamount,
      _colRepDate: repaydate,
      _colPromo: promocode
    };
    return map;
  }

  //loan request menu
  Map<String, dynamic> modelToMap() {
    var map = <String, dynamic>{
      _colId: id,
      _colReqAmt: requestedamount,
      _colRepaymentDays: repaymentdays,
      _colInterestRate: interestrate,
      _colRepAmt: repayamount,
      _colRepDate: repaydate,
      _colPromo: promocode,
      _colFirstName: firstname,
      _colLastName: lastname,
      _colGender: gender,
      _colDob: dateofbirth,
      _colIdn: idnumber,
      _colPass: password,
      _colPhone: phone,
      _colRegion: region,
      _colCity: city,
      _colStreet: street,
      _colHaddr: houseaddress,
      _colIdfront: idfront,
      _colIdback: idback,
      _colIdselfie: idselfie
    };
    return map;
  }

  //personal info menu
  Map<String, dynamic> psfToMap() {
    var map = <String, dynamic>{
      _colFirstName: firstname,
      _colLastName: lastname,
      _colGender: gender,
      _colDob: dateofbirth,
      _colIdn: idnumber,
      _colPass: password,
      _colPhone: phone
    };
    return map;
  }

  //address info menu
  Map<String, dynamic> addrToMap() {
    var map = <String, dynamic>{
      _colRegion: region,
      _colCity: city,
      _colStreet: street,
      _colHaddr: houseaddress
    };
    return map;
  }

  //id verification menu
  Map<String, dynamic> idvToMap() {
    var map = <String, dynamic>{
      _colIdfront: idfront,
      _colIdback: idback,
      _colIdselfie: idselfie
    };
    return map;
  }
}

class LoanModel {
  final String _colId = 'id';
  final String _colRepaymentDays = 'repaymentdays';
  final String _colEmail = 'email';
  final String _colInterestRate = 'interestrate';
  final String _colReqAmt = 'requestedamount';
  final String _colRepAmt = 'repayamount';
  final String _colRepDate = 'repaydate';
  final String _colPromo = 'promocode';
  final String _colFirstName = 'firstname';
  final String _colLastName = 'lastname';
  final String _colGender = 'gender';
  final String _colDob = 'dateofbirth';
  final String _colIdn = 'idnumber';
  final String _colPass = 'password';
  final String _colPhone = 'phone';
  final String _colRegion = 'region';
  final String _colCity = 'city';
  final String _colStreet = 'street';
  final String _colHaddr = 'houseaddress';
  final String _colIdfront = 'idfront';
  final String _colIdback = 'idback';
  final String _colIdselfie = 'idselfie';
  final String _colStatus = 'status';
  final String _colStamp = 'stamp';

  String id,
      repaymentdays,
      interestrate,
      requestedamount,
      repayamount,
      repaydate,
      promocode,
      firstname,
      lastname,
      gender,
      dateofbirth,
      idnumber,
      password,
      email,
      phone,
      region,
      city,
      street,
      houseaddress,
      idfront,
      idback,
      idselfie,
      status,
      stamp;

  LoanModel();

  LoanModel.fromNap(Map<String, dynamic> map) {
    id = map[_colId];
    requestedamount = map[_colReqAmt];
    repaymentdays = map[_colRepaymentDays];
    interestrate = map[_colInterestRate];
    repayamount = map[_colRepAmt];
    repaydate = map[_colRepDate];
    promocode = map[_colPromo];
    firstname = map[_colFirstName];
    lastname = map[_colLastName];
    gender = map[_colGender];
    dateofbirth = map[_colDob];
    idnumber = map[_colIdn];
    password = map[_colPass];
    email = map[_colEmail];
    phone = map[_colPhone];
    region = map[_colRegion];
    city = map[_colCity];
    street = map[_colStreet];
    houseaddress = map[_colHaddr];
    idfront = map[_colIdfront];
    idback = map[_colIdback];
    idselfie = map[_colIdselfie];
    status = map[_colStatus];
    stamp = map[_colStamp];
  }

  //loan request menu
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      _colId: id,
      _colReqAmt: requestedamount,
      _colRepaymentDays: repaymentdays,
      _colInterestRate: interestrate,
      _colRepAmt: repayamount,
      _colRepDate: repaydate,
      _colPromo: promocode,
      _colFirstName: firstname,
      _colLastName: lastname,
      _colGender: gender,
      _colDob: dateofbirth,
      _colIdn: idnumber,
      _colPass: password,
      _colEmail: email,
      _colPhone: phone,
      _colRegion: region,
      _colCity: city,
      _colStreet: street,
      _colHaddr: houseaddress,
      _colIdfront: idfront,
      _colIdback: idback,
      _colIdselfie: idselfie,
      _colStatus: status,
      _colStamp: stamp
    };
    return map;
  }
}
