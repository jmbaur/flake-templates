{
  description = "Flake Templates";

  outputs = _: {
    templates = {
      golang = {
        description = "golang";
        path = ./golang;
      };
    };
  };
}
