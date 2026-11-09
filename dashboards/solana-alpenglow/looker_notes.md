# Looker Studio notes (Dashboard 2)

Data sources (both uploaded CSVs):
1. solana_daily_oct21_27_v2.csv  -> tx_date = Date (YYYYMMDD)
2. solana_hourly_oct21.csv       -> tx_hour = Date Hour (YYYYMMDDHH)

Charts:
1. Daily transactions (bars, all seven days): metric daily_tx_count, sorted by tx_date ascending.
   Note beside the Oct 21 bar: "votes on-chain until about 15:00 UTC".
2. Hourly transactions, Oct 21: metric hourly_tx_count, with a note at the step-down hour.
3. Image: Solscan chart (independent evidence), cropped to the chart only.
4. Optional: daily fees (SOL). Add only after fees are validated against Solscan.

Remove the default "Record Count" metric from every chart.
No calculated fields are needed for this dashboard.
