# Kujira Health

A proof-of-concept dashboard to monitor the health of the Kujira Ecosystem, and help manage and place Orca bids accordingly

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Architecture

This tech demo utilizes Phoenix's [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html) - an over-the-wire realtime rendering engine.

This allows us to load each individual market's health in realtime for a user - just as with a "traditional" RPC - yet the result is
then cached and invalidated globally according to centrally defined rules, significantly improving the UX for all users.

For example, this allows the API server to listen to new transactions from the chain, and invalidate specific market's health response when a position is updated by an owner, or liquidated.

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
