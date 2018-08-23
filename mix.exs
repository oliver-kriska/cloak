defmodule Cloak.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cloak,
      version: "0.7.0-alpha.2",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      source_url: "https://github.com/danielberkompas/cloak",
      description: "Encrypted fields for Ecto.",
      package: package(),
      deps: deps(),
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, ">= 1.0.0"},
      {:flow, "~> 0.13.0"},
      {:pbkdf2, "~> 2.0", optional: true},
      {:poison, ">= 1.5.0", optional: true},
      {:excoveralls, "~> 0.8", only: :test},
      {:postgrex, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  defp docs do
    [
      main: "README",
      extras: [
        "README.md",
        "guides/how_to/install.md": [title: "Install Cloak"],
        "guides/how_to/generate_keys.md": [title: "Generate Encryption Keys"],
        "guides/how_to/encrypt_existing_data.md": [title: "Encrypt Existing Data"],
        "guides/how_to/rotate_keys.md": [title: "Rotate Keys"],
        "guides/upgrading/0.6.x_to_0.7.x.md": [title: "0.6.x to 0.7.x"]
      ],
      extra_section: "GUIDES",
      groups_for_extras: [
        "How To": ~r/how_to/,
        Upgrading: ~r/upgrading/
      ],
      groups_for_modules: [
        Behaviours: [
          Cloak.Cipher,
          Cloak.Vault
        ],
        Ciphers: ~r/Ciphers.AES/,
        "Deprecated Ciphers": ~r/Ciphers.Deprecated/,
        "Ecto Types": ~r/Fields/
      ]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE"],
      maintainers: ["Daniel Berkompas"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/danielberkompas/cloak"
      }
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
