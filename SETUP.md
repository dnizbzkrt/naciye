# Naciye - Kurulum Rehberi

## 1. Supabase Projesi Oluştur
1. https://supabase.com adresine git, ücretsiz hesap aç.
2. "New Project" ile yeni proje oluştur (şifre belirle, bölge olarak Frankfurt/EU seçebilirsin).
3. Proje açılınca sol menüden **SQL Editor**'e gir.
4. Repodaki `supabase-setup.sql` dosyasının tüm içeriğini yapıştır ve **Run** butonuna bas.
   - Bu, 3 tabloyu (ingredients, recipes, recipe_ingredients) ve güvenlik kurallarını (RLS) oluşturur.

## 2. Kullanıcı (Giriş Yapacak Kişi) Oluştur
1. Sol menüden **Authentication > Users** sekmesine git.
2. **Add user** ile Naciye ve kendin için birer e-posta/şifre oluştur.
   - Örn: naciye@example.com / güçlü bir şifre
   - "Auto Confirm User" seçeneğini işaretle ki e-posta onayı beklemesin.
3. Sadece buradan eklediğin kişiler giriş yapabilir; sitede kayıt ol ekranı yok, bu bilinçli bir tercih (yetkisiz erişimi engellemek için).

## 3. API Bilgilerini Al
1. Sol menüden **Project Settings > API** sekmesine git.
2. **Project URL** ve **anon public key** değerlerini kopyala.
3. `supabase-config.js` dosyasını aç, en üstteki iki satırı kendi bilgilerinle değiştir:

```js
const SUPABASE_URL = "https://xxxxxxx.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOi...";
```

> Not: "anon key" herkese açık olsa da sorun değil; gerçek güvenlik Authentication + Row Level Security ile sağlanıyor. Sadece giriş yapmış kullanıcılar veriye erişebiliyor.

## 4. GitHub Pages'e Yükle
1. GitHub hesabında yeni bir repo oluştur, örneğin adı **naciye** olsun.
2. Bu klasördeki tüm dosyaları (`index.html`, `ingredients.html`, `recipes.html`, `calculate.html`, `style.css`, `supabase-config.js`) repoya yükle.
   - `supabase-setup.sql` ve bu `SETUP.md` dosyalarını da isteğe bağlı ekleyebilirsin, siteyi etkilemezler.
3. Repo **Settings > Pages** sekmesine git.
4. "Source" olarak **Deploy from a branch** seç, branch: `main`, klasör: `/ (root)`.
5. Birkaç dakika sonra site şu adreste yayında olacak:
   `https://kullaniciadin.github.io/naciye/`

## 5. Kullanım Sırası
1. Önce **Malzemeler** sayfasından temel malzemeleri (kıyma, un, yumurta vb.) fiyatlarıyla ekle.
2. Sonra **Yemekler** sayfasından bir yemek oluştur (örn. Mantı) ve standart tarifini gir (bu referans amaçlıdır).
3. **Hesapla** sayfasında yemeği seç, o gün üretilen gerçek miktarı (kg) ve kullanılan gerçek malzeme miktarlarını gir; sistem anlık malzeme fiyatlarıyla toplam maliyeti ve kg başı maliyeti otomatik hesaplar.

## Önemli Notlar
- Malzeme fiyatını **Malzemeler** sayfasından güncellediğinde, sonraki tüm hesaplamalar otomatik yeni fiyatı kullanır (fiyatlar veritabanından canlı çekiliyor).
- Site tamamen ücretsiz: GitHub Pages barındırma, Supabase ücretsiz plan (500MB veritabanı, sınırsız API isteği - küçük ölçekli kullanım için fazlasıyla yeterli).
- Şu an geçmiş hesaplamalar kaydedilmiyor, sadece anlık sonuç gösteriliyor. İstersen ileride "hesaplama geçmişi" tablosu ekleyip kayıt tutmasını da sağlayabiliriz.
