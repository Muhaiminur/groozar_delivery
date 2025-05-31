enum Flavor { prod, dev }

class AppFlavor {
  String appName = "";
  String baseUrl = "";
  String Mixpanel = "";
  Flavor flavor = Flavor.prod;

  static AppFlavor shared = AppFlavor.create();

  factory AppFlavor.create({
    String appName = "",
    String baseUrl = "",
    String Mixpanel = "",
    Flavor flavor = Flavor.prod,
  }) {
    return shared = AppFlavor(appName, baseUrl, Mixpanel, flavor);
  }

  AppFlavor(this.appName, this.baseUrl, this.Mixpanel, this.flavor);
}
