defmodule Xelloasso.Models.Enums.PaymentState do
  use Xelloasso.Models.Enums.Enum, [
    "Pending",
    "Authorized",
    "Refused",
    "Unknown",
    "Registered",
    "Refunded",
    "Refunding",
    "Contested"
  ]
end
