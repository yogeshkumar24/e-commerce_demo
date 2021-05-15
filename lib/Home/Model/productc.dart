class Products {
  String imageUrl;
  String name;
  int price;
  int quantity;

  Products(this.imageUrl, this.name, this.price, this.quantity);
}

List<Products> getProductsList() {
  List<Products> productsList = List<Products>();
  Products myProd = Products("assets/images/drink.jpg", "Drink", 200, 1);
  productsList.add(myProd);
  Products myProd2 = Products("assets/images/shoes.jpg", "Bag", 799, 1);
  productsList.add(myProd2);
  Products myProd3 = Products("assets/images/handbag.jpg", "Handbag", 1299, 1);
  productsList.add(myProd3);
  Products myProd4 = Products("assets/images/camera.jpg", "Camera", 899, 1);
  productsList.add(myProd4);
  Products myProd5 = Products("assets/images/cycle.jpg", "Cycle", 500, 1);
  productsList.add(myProd5);
  Products myProd6 = Products("assets/images/shoes.jpg", "Shoes", 3999, 1);
  productsList.add(myProd6);
  Products myProd7 =
      Products("assets/images/headphone.jpg", "Headphone", 600, 1);
  productsList.add(myProd7);

  Products myProd8 = Products("assets/images/drink.jpg", "Drink", 200, 1);
  productsList.add(myProd8);
  Products myProd9 = Products("assets/images/camera.jpg", "Camera", 140000, 1);
  productsList.add(myProd9);

  Products myProd11 = Products("assets/images/cycle.jpg", "Cycle", 20000, 1);
  productsList.add(myProd11);
  Products myProd12 = Products("assets/images/drink.jpg", "Drink", 200, 1);
  productsList.add(myProd12);
  Products myProd13 = Products("assets/images/drink.jpg", "Drink", 200, 1);
  productsList.add(myProd13);
  Products myProd14 =
      Products("assets/images/headphone.jpg", "Headphone", 2000, 1);
  productsList.add(myProd14);
  Products myProd15 = Products("assets/images/cycle.jpg", "Cycle", 20000, 1);
  productsList.add(myProd15);

  return productsList;
}
