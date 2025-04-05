import requests
import pandas as pd

# ===== Fungsi utama Ambil Data =====
def get_universities_by_country(country):
    url = "http://universities.hipolabs.com/search"
    params = {"country": country}

    try:
        response = requests.get(url, params=params, timeout=10)
        response.raise_for_status()  # akan raise error kalau status bukan 200
        data = response.json()
    except requests.exceptions.RequestException as e:
        print(f"❌ HTTP error: {e}")
        return None
    except ValueError:
        print("❌ Gagal decode JSON. Mungkin response-nya rusak atau bukan JSON.")
        print(f"Isi response: {response.text[:300]}...")  # hanya tampilkan sebagian
        return None

    # Buat DataFrame
    df = pd.DataFrame(data)[['name', 'web_pages', 'country', 'domains', 'state-province']]
    df.columns = ['Name', 'Web pages', 'Country', 'Domains', 'State Province']

    # Filter yang ada state province
    df_filtered = df[df['State Province'].notna()]

    return df_filtered



# ===== Main Program =====
if __name__ == "__main__":
    # Ganti negara di sini sesuai kebutuhan
    country_input = input("Masukkan nama negara (contoh: United States): ")
    
    result = get_universities_by_country(country_input)

    if result is not None:
        print("\n📄 Data universitas dengan State Province:")
        print(result.head(10))  # tampilkan 10 data pertama
        result.to_csv("filtered_universities.csv", index=False)
        print("\n✅ Data berhasil disimpan di 'filtered_universities.csv'")
