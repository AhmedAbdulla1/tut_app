import 'package:tut_app/app/constant.dart';
import 'package:tut_app/app/extensions.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id.orEmpty() ?? "",
      name: this?.name.orEmpty() ?? "",
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

extension ServicesResponseMapper on ServicesResponse? {
  Service toDomain() {
    return Service(
      id: this?.id.orZero() ?? Constant.zero,
      title: this?.title.orEmpty() ?? Constant.empty,
      image: this?.image.orEmpty() ?? Constant.image,
    );
  }
}

extension StoresResponseMapper on StoresResponse? {
  Stores toDomain() {
    return Stores(
      id: this?.id.orZero() ?? Constant.zero,
      title: this?.title.orEmpty() ?? Constant.empty,
      image: this?.image.orEmpty() ?? Constant.image,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  Banners toDomain() {
    return Banners(
      id: this?.id.orZero() ?? Constant.zero,
      link: this?.link.orEmpty() ?? Constant.empty,
      title: this?.title.orEmpty() ?? Constant.empty,
      image: this?.image.orEmpty() ?? Constant.image,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();
    List<Stores> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Stores>()
        .toList();
    List<Banners> banners = (this
                ?.data
                ?.banners
                ?.map((bannerResponse) => bannerResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Banners>()
        .toList();
    Data? data = Data(services: services, banners: banners, stores: stores);
    return Home(data: data);
  }
}

extension StoresDetailsResponseMapper on StoresDetailsResponse? {
  StoresDetails toDomain() {
    return StoresDetails(
        id: this?.id.orZero() ?? Constant.zero,
        image: this?.image.orEmpty() ?? Constant.image,
        title: this?.title.orEmpty() ?? Constant.empty,
        details: this?.details.orEmpty() ?? Constant.empty,
        service: this?.services.orEmpty() ?? Constant.empty,
        about: this?.about.orEmpty() ?? Constant.empty);
  }
}
