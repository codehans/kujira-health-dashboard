defmodule KujiraHealthWeb.DashboardLive do
  use KujiraHealthWeb, :live_view
  alias KujiraHealth.Node

  def mount(_params, _session, socket) do
    send(self(), :load)
    send(self(), :oracle)
    # Start by assigning an empty list of contracts
    {:ok,
     socket
     |> assign(:usk, %{})
     |> assign(:oracle, %{})
     |> assign(:channel, Node.channel())}
  end

  def handle_info(:load, socket) do
    {:ok, usk} = Kujira.Usk.list_markets(socket.assigns.channel)

    for market <- usk do
      send(self(), {:load, market})
    end

    usk = Enum.reduce(usk, %{}, &Map.put_new(&2, &1.address, nil))

    {:noreply, assign(socket, :usk, usk)}
  end

  def handle_info(:oracle, socket) do
    {:ok, rates} = Kujira.Oracle.load_prices(socket.assigns.channel)
    Process.send_after(self(), :oracle, 500)

    {:noreply, assign(socket, :oracle, rates)}
  end

  def handle_info({:load, market}, socket) do
    {:ok, summary} = Kujira.Usk.load_orca_market(socket.assigns.channel, market)
    {:noreply, assign(socket, :usk, Map.put(socket.assigns.usk, market.address, summary))}
  end
end
