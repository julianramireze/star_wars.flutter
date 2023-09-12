class Api {
  static const _server = "https://swapi.dev/";
  static const _serverGoogle = "https://www.google.com/";
  static const _serverJsonPlaceholder = "https://jsonplaceholder.typicode.com/";

  static get getServer => _server;
  static get getServerGoogle => _serverGoogle;
  static get getServerJsonPlaceholder => _serverJsonPlaceholder;

  static const baseUrl = "${_server}api/";
  static const baseUrlGoogleSearch = "${_serverGoogle}search/";
  static const baseUrlJsonPlaceholder = _serverJsonPlaceholder;

  //endpoints for api
  static const endpointPeople = "people/";
}
