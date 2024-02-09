defmodule KujiraHealth.Node do
  @moduledoc """
  Stores a gRPC connection to chain core node
  """

  use Agent

  def start_link(_opts) do
    config = Application.get_env(:kujira_health, __MODULE__)

    {:ok, channel} =
      GRPC.Stub.connect(config[:host], config[:port],
        interceptors: [{GRPC.Logger.Client, level: :debug}]
      )

    Agent.start_link(fn -> channel end, name: __MODULE__)
  end

  def channel() do
    Agent.get(__MODULE__, & &1)
  end
end
