#
# This file is part of Astarte.
#
# Copyright 2020 Ispirata Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule AstarteE2EWeb.Telemetry do
  use Supervisor
  import Telemetry.Metrics
  alias AstarteE2E.Config

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      {:telemetry_poller, measurements: periodic_measurements(), period: 10_000},
      {TelemetryMetricsPrometheus.Core, metrics: metrics()},
      {Plug.Cowboy, scheme: :http, plug: AstarteE2EWeb.Router, options: [port: Config.port!()]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    [
      # VM Metrics
      last_value("vm.memory.total"),
      last_value("vm.memory.processes_used"),
      last_value("vm.memory.processes"),
      last_value("vm.memory.system"),
      last_value("vm.memory.atom"),
      last_value("vm.memory.atom_used"),
      last_value("vm.memory.ets"),
      last_value("vm.memory.code"),
      last_value("vm.system_counts.process_count"),
      last_value("vm.system_counts.atom_count"),
      last_value("vm.system_counts.port_count"),
      last_value("vm.total_run_queue_lengths.total"),
      last_value("vm.total_run_queue_lengths.cpu"),
      last_value("vm.total_run_queue_lengths.io"),
      last_value("vm.refresh"),

      # Custom metrics
      counter("astarte_end_to_end.messages.sent.count",
        description: "Total number of messages sent through Astarte interfaces."
      ),
      counter("astarte_end_to_end.messages.received.count",
        description: "Total number of messages received through Astarte channels."
      ),
      counter("astarte_end_to_end.messages.failed.count",
        description: "Messages not sent because of client disconnections."
      ),
      last_value("astarte_end_to_end.messages.round_trip_time.duration_seconds",
        description: "Message round trip time (seconds)."
      ),
      last_value("astarte_end_to_end.astarte_platform.status",
        description: "Astarte platform status assessed by AstarteE2E application."
      )
    ]
  end

  defp periodic_measurements do
    [
      # A module, function and arguments to be invoked periodically.
      # This function must call :telemetry.execute/3 and a metric must be added above.
      # {MyApp, :count_users, []}
    ]
  end
end
