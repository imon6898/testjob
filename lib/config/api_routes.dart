class ApiRoutes {

  static const baseUrl = "https://peanut.ifxdb.com";
  static const adminApiBetaBaseUrl = "https://adminapibeta.applegadgetsbd.com";
  // static const String prefix = "$baseUrl/api";
  static const String prefix = "$adminApiBetaBaseUrl/api";

  static const isAccountCredentialsCorrect = '/ClientCabinetBasic/IsAccountCredentialsCorrect';
  static const getLastFourNumbersPhone = '/ClientCabinetBasic/GetLastFourNumbersPhone';
  static const getLastFourNumbersPhoneAsync = '/ClientCabinetBasic/GetLastFourNumbersPhoneAsync';
  static const getAccountInformation = '/ClientCabinetBasic/GetAccountInformation';
  static const getAccountInformationAsync = '/ClientCabinetBasic/GetAccountInformationAsync';
  static const getOpenTrades = '/ClientCabinetBasic/GetOpenTrades';
  static const userLogin = '/user/login';
  static const userMe = '/user/me';


  static String getAllDistributorsByLocation(double lat, double lon) => "/get-all-distributors?lat=$lat&long=$lon";
  static String updateOutletDetails(int id) => "/update-one-outlet/$id";
  static const postWorkingRecord = "/working_record";
}