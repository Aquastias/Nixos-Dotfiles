let
  # For fields that require JSON value at import.
  toJSONFieldConversion = target: let
    # Convert to JSON and then in reverse.
    result = builtins.fromJSON (builtins.toString (builtins.toJSON target));
  in
    result;
in
  toJSONFieldConversion
