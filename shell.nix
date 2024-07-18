{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;

mkShell rec {
  name = "hanoidb";
  packages = with pkgs; [
    bashInteractive
    gigalixir
    inotify-tools
    libnotify
  ];
  buildInputs = [
    # basics
    curl
    git
    openssh
    ripgrep
    shellcheck

    erlang
    erlang-ls
    rebar3
    erlfmt

    # BEAM support
    #beam.interpreters.erlangR26
    #rebar3
    #beam.packages.erlangR26.elixir_1_15
    #nodejs-18_x

    # elixir-typst support
    #pkgs.iconv

    # rust support
    #cargo
  ];
  shellHook =
    let
      icon = "f121";
    in
    ''
      export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
      alias gitc="git -c user.email=greg@burd.me commit --gpg-sign=22931AF7895E82DF ."

      # allows mix to work on the local directory
      mkdir -p .nix-mix
      mkdir -p .nix-hex
      export MIX_HOME=$PWD/.nix-mix
      export HEX_HOME=$PWD/.nix-hex
      export PATH=$MIX_HOME/bin:$PATH
      export PATH=$HEX_HOME/bin:$PATH
      export LANG=en_US.UTF-8
      export ERL_AFLAGS="-kernel shell_history enabled"
    '';
}

# NOTES:
# * https://github.com/fbettag/nixos-erlang-flake/blob/main/flake.nix
# * https://discourse.nixos.org/t/installing-different-versions-of-elixir-and-erlang/35765/5
#   * https://github.com/fbettag/nixos-erlang-flake/blob/main/flake.nix
