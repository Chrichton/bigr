defmodule BigrWeb.CountLive.Counter do
  use Phoenix.LiveComponent

  alias Bigr.Counter

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(count: Counter.new())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-sm rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-xl mb-2">Table <%= @table_number %></div>
        <p class="text-2xl">Score: <%= Counter.show(@count) %></p>
      </div>
      <div class="px-6 pt-4 pb-2">
        <.count_button click="change" by={1} myself={@myself}>Inc</.count_button>
        <.count_button click="change" by={-1} myself={@myself}>Dec</.count_button>
      </div>
    </div>
    """
  end

  attr :by, :integer, default: 1
  attr :myself, :any, required: true
  attr :click, :string
  slot :inner_block

  def count_button(assigns) do
    ~H"""
    <span
      class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"
      phx-click={@click}
      phx-target={@myself}
      phx-value-by={@by}
    >
      <%= render_slot(@inner_block) %>
    </span>
    """
  end

  def handle_event("change", %{"by" => count_by}, socket) do
    by = String.to_integer(count_by)

    socket =
      socket
      |> assign(:count, Counter.change(socket.assigns.count, by))

    {:noreply, socket}
  end
end
