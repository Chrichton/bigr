defmodule BigrWeb.CountLive do
  use BigrWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:count, 0)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl">Count: <%= @count %></h1>
    <button class="rounded-1g bg-zinc-980 hover:bg-zinc-700
    py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80">
      Inc
    </button>
    """
  end

  def handle_event("increment", _unsigned_params, socket) do
    socket =
      socket
      |> assign(:count, socket.assigns.count + 1)

    # or better
    # |> update(:count, &(&1 + 1))

    {:noreply, socket}
  end
end
