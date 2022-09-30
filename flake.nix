{
  description = "Flake Templates";

  outputs = _: {
    templates = {
      golang = { path = ./golang; };
    };
  };
}
