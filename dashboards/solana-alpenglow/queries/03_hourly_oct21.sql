-- =============================================================================
-- Dashboard 2: Solana activity and the Alpenglow vote break
-- Query:       Hourly transaction count, fees and average fee, Oct 21
--              (used to find the hour the transaction count steps down)
-- Source:      bigquery-public-data.crypto_solana_mainnet_us.Transactions
-- Window:      2026-10-21 00:00 to 2026-10-21 23:59 UTC (hardcoded; upper bound exclusive)
-- Units:       fee is stored in lamports; dividing by 1,000,000,000 gives SOL.
--              hourly_tx_count    = number of transactions in the hour
--              hourly_fees_sol    = total fees paid in the hour, in SOL
--              avg_fee_per_tx_sol = average fee per transaction, in SOL
-- Notes:       NEW query, so it costs a scan. Check the validator's byte estimate
--              before running. Expected step-down is around 15:00 UTC; record the
--              actual hour from the results in the README.
-- Validated:   Fees NOT yet validated against Solscan (pending).
-- Status:      Snapshot, not live.
-- =============================================================================

SELECT
  TIMESTAMP_TRUNC(block_timestamp, HOUR)  AS tx_hour,
  COUNT(*)                                AS hourly_tx_count,
  SUM(fee) / 1000000000                   AS hourly_fees_sol,
  AVG(fee) / 1000000000                   AS avg_fee_per_tx_sol
FROM `bigquery-public-data.crypto_solana_mainnet_us.Transactions`
WHERE block_timestamp >= TIMESTAMP("2026-10-21")
  AND block_timestamp <  TIMESTAMP("2026-10-22")
GROUP BY tx_hour
ORDER BY tx_hour;
