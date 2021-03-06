#
# This file is part of Astarte.
#
# Copyright 2018 Ispirata Srl
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

defmodule Astarte.Housekeeping.API.Config do
  @moduledoc """
  This module contains functions to access the configuration
  """

  @doc """
  Returns true if the authentication is disabled
  """
  def jwt_public_key_pem do
    Application.get_env(:astarte_housekeeping_api, :jwt_public_key_pem)
  end

  @doc """
  Returns true if the authentication is disabled
  """
  def authentication_disabled? do
    Application.get_env(:astarte_housekeeping_api, :disable_authentication, false)
  end

  @doc """
  Returns the RPC client module
  """
  def rpc_client do
    Application.get_env(:astarte_housekeeping_api, :rpc_client, Astarte.RPC.AMQP.Client)
  end
end
