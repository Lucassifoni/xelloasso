defmodule Xelloasso.Models.Enums.TierType do
  use Xelloasso.Models.Enums.Enum, [
    "Donation",
    "Payment",
    "Registration",
    "Membership",
    "MonthlyDonation",
    "MonthlyPayment",
    "OfflineDonation",
    "Contribution",
    "Bonus",
    "Product"
  ]
end
