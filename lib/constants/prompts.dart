class Prompts {
  static String character(String name, String background) {
    return "A centered photograph in the foreground of $name from Star Wars, background $background, disney pixar style";
  }

  static String planet(String terrain, String climate) {
    return "Background about horizon of planet with terrain $terrain and climate $climate";
  }
}
