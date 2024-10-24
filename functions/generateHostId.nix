{hostName}: let
  # Function to generate a hostId of a specific length (8 characters).
  generateHostId = hostName: let
    # Generate a SHA256 hash and take the first 8 characters.
    hash = builtins.substring 0 8 (builtins.toString (builtins.hashString "sha256" hostName));
  in
    hash;
in
  generateHostId hostName
