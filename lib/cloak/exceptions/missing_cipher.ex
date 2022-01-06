defmodule Cloak.MissingCipher do
  @moduledoc "Indicates that no cipher was found to encrypt/decrypt a given text."
  defexception [:message, :vault, :label, :ciphertext]

  def exception(opts) do
    msg = Enum.map_join(opts, ", ", fn {key, val} -> "#{key}: #{inspect(val)}" end)

    __MODULE__
    |> struct(opts)
    |> Map.put(:message, "No cipher found for #{msg}")
  end
end
