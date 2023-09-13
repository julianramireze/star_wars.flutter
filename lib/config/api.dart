class Api {
  static const _server = "https://swapi.dev/";
  static const _serverGoogle = "https://www.google.com/";
  static const _serverJsonPlaceholder = "https://jsonplaceholder.typicode.com/";
  static const _serverStabilityAI = "https://api.stability.ai/";

  static get getServer => _server;
  static get getServerGoogle => _serverGoogle;
  static get getServerJsonPlaceholder => _serverJsonPlaceholder;
  static get getServerStabilityAI => _serverStabilityAI;

  static const baseUrl = "${_server}api/";
  static const baseUrlJsonPlaceholder = _serverJsonPlaceholder;
  static const baseUrlStabilityAI = "${_serverStabilityAI}v1/";

  //endpoints for api
  static const endpointPeople = "people/";
  static const endpointPlanets = "planets/";
  static const endpointStarShips = "starships/";
  static const endpointVehicles = "vehicles/";
  //endpoints for stability.ai
  static const endpointGenerationStabilityAI = "generation/";
}
