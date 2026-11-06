-- =============================================================================
-- Dashboard 1: USDC token activity (Ethereum)
-- Query:       Top 5 addresses by USDC received (top movers)
-- Source:      bigquery-public-data.crypto_ethereum.token_transfers
-- Token:       USDC, 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48
-- Window:      2026-07-13 to 2026-10-11 inclusive (hardcoded; upper bound exclusive)
-- Units:       total_usdc_received = USDC (raw value / 10^6)
-- Notes:       Zero address excluded in the OUTER query (see comment below).
--              To rank senders instead, change to_address to from_address in the CTE.
--              Address names (Morpho, Circle) are applied in Looker Studio via a
--              CASE calculated field, not here.
-- Validated:   Address labels checked on Etherscan (see README).
-- Status:      Snapshot, not live.
-- =============================================================================

WITH transfers AS (
  SELECT
    to_address                                     AS address,
    SUM(SAFE_CAST(value AS FLOAT64) / POW(10, 6))  AS total_usdc_received,
    COUNT(*)                                       AS transfer_count
  FROM `bigquery-public-data.crypto_ethereum.token_transfers`
  WHERE token_address = "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"  -- USDC
    AND block_timestamp >= TIMESTAMP("2026-07-13")
    AND block_timestamp <  TIMESTAMP("2026-10-12")
  GROUP BY address
)

SELECT
  address,
  total_usdc_received,
  transfer_count
FROM transfers
-- Exclude the zero address: transfers to it are token burns, not a real counterparty,
-- and it would otherwise dominate the ranking.
WHERE address != "0x0000000000000000000000000000000000000000"
ORDER BY total_usdc_received DESC
LIMIT 5;
