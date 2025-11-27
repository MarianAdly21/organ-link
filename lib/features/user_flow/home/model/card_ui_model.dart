class CardUiModel {
  final String icon;
  final String title;
  final String subTitle;
  final void Function() onTap;

  CardUiModel({required this.icon, required this.title, required this.subTitle, required this.onTap});

}
