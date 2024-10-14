class NavigationModel {
  final String image;
  final String name;
  final int index;
  Function? onTap = () {};

  NavigationModel({
    required this.name,
    required this.image,
    required this.index,
    this.onTap,
  });
}
