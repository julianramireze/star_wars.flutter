class Api {
  static const _server = "https://swapi.dev/";
  static const _serverGoogle = "https://www.google.com/";

  static get getServer => _server;
  static get getServerGoogle => _serverGoogle;

  static const baseUrl = "${_server}api/";
  static const baseUrlGoogleSearch = "${_serverGoogle}search";

  //endpoints for api
  static const endpointPeople = "people/";
}
