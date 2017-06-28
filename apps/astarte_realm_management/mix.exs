defmodule RealmManagement.Mixfile do
  use Mix.Project

  def project do
    [app: :realm_management,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

   defp deps do
     [
       {:astarte_core, in_umbrella: true},
       {:amqp, "~> 0.2.2"},
       {:cqex, "~> 0.2.0"},
       {:cqerl, github: "matehat/cqerl"},
       {:re2, git: "https://github.com/tuncer/re2.git", tag: "v1.7.2", override: true},
       {:exprotobuf, "~> 1.2.7"},
       {:distillery, "~> 1.4"},
       {:excoveralls, "~> 0.6", only: :test}
     ]
  end
end
