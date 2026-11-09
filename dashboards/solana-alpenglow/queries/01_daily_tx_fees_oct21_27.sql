-- =============================================================================
-- Dashboard 2: Solana activity and the Alpenglow vote break
-- Query:       Daily transaction count, total fees and average fee per transaction
-- Source:      bigquery-public-data.crypto_solana_mainnet_us.Transactions
-- Window:      2026-10-21 to 2026-10-27 inclusive, UTC (hardcoded).
--              The upper bound below is exclusive, so 2026-10-28 is NOT included.
-- Units:       fee is stored in lamports; dividing by 1,000,000,000 gives SOL.
--              daily_tx_count    = number of transactions
--              daily_fees_sol    = total fees paid that day, in SOL
--              avg_fee_per_tx_sol = average fee per transaction, in SOL
-- Validated:   Fees NOT yet validated against Solscan (pending).
--              Do not publish the average-fee chart until the gap with Solscan's
--              live "Avg Fee" is explained.
-- Status:      Snapshot, not live. Output saved as solana_daily_oct21_27_v2.csv.
-- =============================================================================

SELECT
  DATE(block_timestamp)       AS tx_date,
  COUNT(*)                    AS daily_tx_count,
  SUM(fee) / 1000000000       AS daily_fees_sol,
  AVG(fee) / 1000000000       AS avg_fee_per_tx_sol
FROM `bigquery-public-data.crypto_solana_mainnet_us.Transactions`
WHERE block_timestamp >= TIMESTAMP("2026-10-21")
  AND block_timestamp <  TIMESTAMP("2026-10-28")  -- exclusive: last day included is 2026-10-27
GROUP BY tx_date
ORDER BY tx_date;
