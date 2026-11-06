-- =============================================================================
-- Dashboard 1: USDC token activity (Ethereum)
-- Query:       Daily USDC transferred and daily transfer count
-- Source:      bigquery-public-data.crypto_ethereum.token_transfers
-- Token:       USDC, 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48
-- Window:      2026-07-13 to 2026-10-11 inclusive (hardcoded).
--              The upper bound below is exclusive, so 2026-10-12 is NOT included.
-- Units:       daily_usdc_transferred = USDC (raw value / 10^6, USDC has 6 decimals)
--              daily_transfer_count   = number of Transfer events
-- Notes:       Includes mints and burns (transfers from/to the zero address).
-- Validated:   2026-10-08 daily total matched Etherscan exactly.
-- Status:      Snapshot, not live.
-- =============================================================================

SELECT
  DATE(block_timestamp)                              AS tx_date,
  SUM(SAFE_CAST(value AS FLOAT64) / POW(10, 6))      AS daily_usdc_transferred,
  COUNT(*)                                           AS daily_transfer_count
FROM `bigquery-public-data.crypto_ethereum.token_transfers`
WHERE token_address = "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"  -- USDC
  AND block_timestamp >= TIMESTAMP("2026-07-13")
  AND block_timestamp <  TIMESTAMP("2026-10-12")  -- exclusive: last day included is 2026-10-11
GROUP BY tx_date
ORDER BY tx_date ASC;
