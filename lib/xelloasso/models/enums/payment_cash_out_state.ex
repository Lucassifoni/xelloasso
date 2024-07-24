defmodule Xelloasso.Models.Enums.PaymentCashOutState do
  use Xelloasso.Models.Enums.Enum, [
    "MoneyIn",
    "CantTransferReceiverFull",
    "Transfered",
    "Refunded",
    "Refunding",
    "WaitingForCashOutConfirmation",
    "CashedOut",
    "Unknown",
    "Contested",
    "TransferInProgress"
  ]
end
