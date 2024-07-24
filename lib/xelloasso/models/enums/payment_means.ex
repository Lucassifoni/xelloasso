defmodule Xelloasso.Models.Enums.PaymentMeans do
  use Xelloasso.Models.Enums.Enum, [
    "None",
    "Card",
    "Check",
    "Cash",
    "BankTransfer",
    "Other"
  ]
end
