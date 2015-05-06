defmodule Maybe do
  @type some :: {:ok, term}
  @type maybe :: some | nil

  @spec apply(term) :: maybe
  defmacro apply(maybe) do
    quote do
      case unquote(maybe) do
        nil  -> nil
        some -> {:ok, some}
      end
    end
  end

  @spec get_or_else(maybe, term) :: term
  defmacro get_or_else(maybe, default) do
    quote do
      case unquote(maybe) do
        nil         -> unquote(default)
        {:ok, some} -> some
      end
    end
  end
end
