import 'package:tut_app/app/constant.dart';
import 'package:tut_app/app/extensions.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id:this?.id.orEmpty() ?? "",
      name:this?.name.orEmpty() ?? "",
      numOfNotifications: this?.numOfNotifications.orZero() ?? 0,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(
      phone: this?.phone.orEmpty() ?? Constant.empty,
      email: this?.email.orEmpty() ?? Constant.empty,
      link: this?.link.orEmpty() ?? Constant.empty,
    );
  }
}
extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer.toDomain(),
      contact: this?.contacts.toDomain(),
    );
  }
}