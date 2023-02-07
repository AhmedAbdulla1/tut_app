class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

class Authentication {
  Customer? customer;
  Contact? contact;

  Authentication({
    required this.customer,
    required this.contact,
  });
}

// login models
class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contact {
  String phone;
  String email;
  String link;

  Contact({
    required this.phone,
    required this.email,
    required this.link,
  });
}

//home models
class Home {
  Data? data;

  Home({
    required this.data,
  });
}

class Data {
  List<Service> services;
  List<Banner> banners;
  List<Stores> stores;

  Data({
    required this.services,
    required this.banners,
    required this.stores,
  });
}

class Service {
  int id;
  String title;
  String image;

  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class Banner {
  int id;
  String link;
  String title;
  String image;

  Banner({
    required this.id,
    required this.link,
    required this.title,
    required this.image,
  });
}

class Stores {
  int id;
  String title;
  String image;

  Stores({
    required this.id,
    required this.title,
    required this.image,
  });
}
