defmodule KujiraHealthWeb.DashboardLive do
  use KujiraHealthWeb, :live_view
  alias KujiraHealth.Node

  def mount(_params, _session, socket) do
    send(self(), :load)
    # Start by assigning an empty list of contracts
    {:ok,
     socket
     |> assign(:usk, %{})
     |> assign(:channel, Node.channel())}
  end

  def handle_info(:load, socket) do
    {:ok, usk} = Kujira.Usk.list_markets(socket.assigns.channel)

    for market <- usk do
      send(self(), {:load, market})
    end

    {:noreply, assign(socket, :usk, Enum.reduce(usk, %{}, &Map.put_new(&2, &1.address, nil)))}
  end

  def handle_info({:load, market}, socket) do
    {:ok, summary} = Kujira.Usk.load_orca_market(socket.assigns.channel, market)
    {:noreply, assign(socket, :usk, Map.put(socket.assigns.usk, market.address, summary))}
  end
end