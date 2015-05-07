defmodule Try do
  @type success :: term
  @type failure :: {:failure, String.t}
  @type try :: success | failure

  @spec apply(any) :: try
  defmacro apply(f) do
    quote do
      try do
        unquote f
      rescue
        ex -> {:failure, ex}
      end
    end
  end

  @spec apply(any, [any]) :: try
  defmacro apply(fun, args) do
    quote do
      try do
        unquote(fun) |> apply(unquote(args))
      rescue
        ex -> {:failure, ex}
      end
    end
  end
end
