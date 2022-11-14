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
class Authentication{
  Customer customer;
  Contact contact;
  Authentication(this.customer,this.contact,);
}
// login models
class Customer{
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id,this.name,this.numOfNotifications,);
}

class Contact{
  String phone;
  String email;
  String link;
  Contact(this.phone,this.email,this.link,);
}