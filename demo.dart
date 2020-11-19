void main() {
  var c = new C();
  c.printInfo();
}

class A {
  String info = "this is A info";

  void printInfo() {
    print('this is A');
  }
}

class B {}

mixin B1 on A {
  @override
  void printInfo() {
    print('this is B1');
  }
}

class C extends A with B1 {}
