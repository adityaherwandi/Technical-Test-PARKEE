import pandas as pd

# 1. Gabungkan semua file CSV
files = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']
df = pd.concat([pd.read_csv(file) for file in files], ignore_index=True)

# 2. Hapus baris dengan NaN di kolom transaction_id, date, dan customer_id
df_cleaned = df.dropna(subset=['transaction_id', 'date', 'customer_id'])

# 3. Ubah kolom 'date' menjadi datetime
df_cleaned['date'] = pd.to_datetime(df_cleaned['date'])

# 4. Hilangkan duplikat berdasarkan transaction_id, ambil yang paling terbaru (berdasarkan date)
df_deduped = df_cleaned.sort_values('date', ascending=False).drop_duplicates(subset='transaction_id', keep='first')

# 5. Hitung total penjualan per branch
df_deduped['total'] = df_deduped['quantity'] * df_deduped['price']
total_sales = df_deduped.groupby('branch')['total'].sum().reset_index()

# 6. Simpan ke CSV
total_sales.to_csv('total_sales_per_branch.csv', index=False)

print("✅ Data berhasil diproses dan disimpan di 'total_sales_per_branch.csv'")
