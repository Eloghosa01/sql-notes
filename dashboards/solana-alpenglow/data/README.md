# Data files (Looker Studio uploads)

The dashboard reads uploaded CSVs, not a live BigQuery connection. Each CSV is the saved
output of one query in `../queries/`.

| File | Query | Date field format in Looker Studio |
|------|-------|------------------------------------|
| `solana_daily_oct21_27_v2.csv` | `01_daily_tx_fees_oct21_27.sql` | `tx_date` = Date (YYYYMMDD) |
| `solana_hourly_oct21.csv` (to add) | `03_hourly_oct21.sql` | `tx_hour` = Date Hour (YYYYMMDDHH), e.g. `2026102115` |

Hourly CSV header:

    tx_hour,hourly_tx_count,hourly_fees_sol,avg_fee_per_tx_sol

Copy the CSV files you used into this folder before committing.
