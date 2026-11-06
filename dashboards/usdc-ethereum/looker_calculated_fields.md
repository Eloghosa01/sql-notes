# Looker Studio calculated fields (Dashboard 1)

Add these under Resource > Manage added data sources > Edit > Add a field.
(Data source for the top-movers chart is the top-movers query; the others use the daily query.)

## address_label  (top-movers data source)
Replace the placeholders with the FULL lowercase addresses you verified on Etherscan.

    CASE
  WHEN address = "0xbbbbbbbbbb9cc5e90e3b3af64bdaf62c37eeffcb" THEN "Morpho"
  ELSE CONCAT(
    REGEXP_EXTRACT(address, "^(.{6})"),
    "...",
    REGEXP_EXTRACT(address, "(.{4})$")
  )
END

## avg_transfer_size_usdc  (daily data source)

    SUM(daily_usdc_transferred) / SUM(daily_transfer_count)

Type: Number. Use SUM/SUM (not an average of daily averages) so it stays correct
if you later change the date grain to week or month.
