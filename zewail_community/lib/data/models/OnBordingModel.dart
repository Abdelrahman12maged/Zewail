class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/3.png",
    title: "مرحبًا بكم في مجتمع زويل",
    subTitle:
        "نحن في مركز زويل نعتقد أن التواصل الفعّال والمستمر هو أساس نجاح عملية التعلم .",
  ),
  Items(
    img: "assets/s1.png",
    title: "",
    subTitle:
        """برنامج تواصلنا هو أداة قوية تمكن الطلاب من التواصل وتبادل المعلومات
        . 
""",
  ),
  Items(
    img: "assets/5.png",
    title: "",
    subTitle:
        """نحن نؤمن بأهمية التواصل الجيد والشفاف لضمان تقدم الطلاب وتلبية احتياجاتهم التعليمية .

""",
  ),
];
