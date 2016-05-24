# Phoenix Ratchet

[![Build Status][travis-img]][travis] [![Hex Version][hex-img]][hex]

[travis-img]: https://travis-ci.org/iamvery/phoenix_ratchet.svg?branch=master
[travis]: https://travis-ci.org/iamvery/phoenix_ratchet
[hex-img]: https://img.shields.io/hexpm/v/phoenix_ratchet.svg
[hex]: https://hex.pm/packages/phoenix_ratchet

A [Phoenix][phoenix] template engine for [Ratchet][ratchet].

## Usage

1. Install with [Hex][hex]:

   ```elixir
   def deps do
     [{:ratchet, "~> 0.1.0"}]
   end
   ```

1. Configure Phoenix in `config/config.exs` to use the Ratchet engine:

   ```elixir
   config :phoenix, :template_engines,
     ratchet: Ratchet.Phoenix.Engine
   ```

An example project can be found at [iamvery/example-ratchet-app][example].


[phoenix]: http://www.phoenixframework.org/
[ratchet]: https://github.com/iamvery/ratchet
[hex]: https://hex.pm/
[example]: https://github.com/iamvery/example-ratchet-app
