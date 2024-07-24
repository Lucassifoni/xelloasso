defmodule Xelloasso.Models.Enums.OperationState do
  use Xelloasso.Models.Enums.Enum, [
    "Unknown",
    "Init",
    "Processing",
    "Processed",
    "Error",
    "InternalError",
    "Refused",
    "Aborted",
    "Canceled"
  ]
end
