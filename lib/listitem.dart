class listValue {
  final String image;
  final String title;
  final String description;

  listValue(
      {required this.image, required this.title, required this.description});
}

var listItems = [
  new listValue(
      image: "assets/imagex.svg",
      title: "A welcome from Hello",
      description:
          "HelloDesk secure messenger platform brings the next generation secure collaboration to enterprise class businesses."),
  new listValue(
      image: "assets/imagey.svg",
      title: "Communicate and Collaborate",
      description:
          "Hello messenger provides a single solution for all collaboration needs. Access your web meeting, chat, contacts directory and work apps in one single platform."),
  new listValue(
      image: "assets/imagez.svg",
      title: "Secure, reliable and built for Enterprise ",
      description:
          "Built for enterprise businesses, Hello provides lighting fast messaging, voice and video calls with end to end encryption and central administration for additional security."),
];
