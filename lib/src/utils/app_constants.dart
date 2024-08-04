class AppConstants {
  AppConstants._();
  static const String introDone = "InterScreen";
  static const String imageGenerator = "imageGenerator";
  static const String backgroundremover = "backgroundremover";
  static const num monthlyImageGenerators = 100;
  static const num yearlyImageGenerators = 300;
  static const num yearlyBGRemover = 60;
  static const num monthlyBGRemover = 30;
}

enum ToolName {
  imageGenrator,
  backgroundRemover,
  restorPurchase,
  rateUs,
  shareUs,
  feedback,
  privacyPolicy,
  termsOfUse,
  premiumScreen,
  none
}

enum StyleSelection {
  imagination,
  portait,
  art,
  oildPainting,
  avatar,
  none,
  artSecond
}

enum PictureSizes {
  onebyone,
  twobyThree,
  threebytwo,
  threebyfour,
  fourbyThree,
  none
}
