-- =============================================================================
-- Dashboard 2: Solana activity and the Alpenglow vote break
-- Query:       Hourly transaction count, fees and average fee, Oct 25
-- Source:      bigquery-public-data.crypto_solana_mainnet_us.Transactions
-- Window:      2026-10-25 00:00 to 2026-10-25 23:59 UTC (hardcoded; upper bound exclusive)
-- Units:       fee is stored in lamports; dividing by 1,000,000,000 gives SOL.
--              hourly_tx_count    = number of transactions in the hour
--              hourly_fees_sol    = total fees paid in the hour, in SOL
--              avg_fee_per_tx_sol = average fee per transaction, in SOL
-- Notes:       Columns renamed from daily_* to hourly_* for accuracy. Values are
--              unchanged, so the query was not rerun (same byte estimate as before).
-- Validated:   Fees NOT yet validated against Solscan (pending).
--              Oct 25 daily total from the daily query: 4,284.6 SOL.
-- Status:      Snapshot, not live.
-- =============================================================================

SELECT
  TIMESTAMP_TRUNC(block_timestamp, HOUR)  AS tx_hour,
  COUNT(*)                                AS hourly_tx_count,
  SUM(fee) / 1000000000                   AS hourly_fees_sol,
  AVG(fee) / 1000000000                   AS avg_fee_per_tx_sol
FROM `bigquery-public-data.crypto_solana_mainnet_us.Transactions`
WHERE block_timestamp >= TIMESTAMP("2026-10-25")
  AND block_timestamp <  TIMESTAMP("2026-10-26")
GROUP BY tx_hour
ORDER BY tx_hour;
