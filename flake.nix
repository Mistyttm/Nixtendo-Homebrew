{
  description = "Nintendo Homebrew templates";
  outputs =
    {
      ...
    }:
    {
      # Export templates. Each template should live in `templates/<name>` so
      # this repository can be extended with more templates in the future.
      templates = {
        NDS = {
          path = ./templates/NDS;
          description = "NDS - Nintendo DS homebrew project template";
        };
      };
    };
}
