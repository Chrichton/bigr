defmodule BigrWeb.CountLive do
  use BigrWeb, :live_view

  alias Bigr.Counter

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:count, Counter.new())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl">Count: <%= Counter.show(@count) %></h1>
    <button
      phx-click="inc"
      class="rounded-lg bg-zinc-900 hover:bg-zinc-700
    py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80"
    >
      Inc
    </button>
    """
  end

  def handle_event("inc", _unsigned_params, socket) do
    socket =
      socket
      |> assign(:count, Counter.inc(socket.assigns.count))

    # or better
    # |> update(:count, &(&1 + 1))

    {:noreply, socket}
  end
end
