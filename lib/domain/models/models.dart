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
