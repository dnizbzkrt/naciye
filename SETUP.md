# Naciye - Kurulum Rehberi

## 1. Supabase Projesi Oluştur
1. https://supabase.com adresine git, ücretsiz hesap aç.
2. "New Project" ile yeni proje oluştur.
3. Proje açılınca sol menüden **SQL Editor**'e gir.
4. Repodaki `supabase-setup.sql` dosyasının tüm içeriğini yapıştır ve **Run** butonuna bas.
   - Bu, 3 tabloyu (ingredients, recipes, recipe_ingredients) ve güvenlik kurallarını (RLS) oluşturur.
   - Ayrıca 4 örnek yemeği (Mantı, Patates Salatası, Çilekli Tart, Mercimek Köftesi) ve güncel piyasa fiyatlarıyla malzemeleri otomatik ekler. Bunları istediğin zaman Master Tablo sayfasından değiştirebilirsin; hiç dokunmazsan bu varsayılanlar kullanılmaya devam eder.

## 2. Kullanıcı (Giriş Yapacak Kişi) Oluştur
1. Sol menüden **Authentication > Users** sekmesine git.
2. **Add user** ile Naciye ve kendin için birer e-posta/şifre oluştur.
3. "Auto Confirm User" seçeneğini işaretle ki e-posta onayı beklemesin.
4. Sadece buradan eklediğin kişiler giriş yapabilir; sitede kayıt ol ekranı yok.

## 3. API Bilgileri
`supabase-config.js` dosyasında Supabase URL ve anon key zaten dolu. Farklı bir Supabase projesi kullanacaksan Project Settings > API sayfasından kendi bilgilerinle değiştirebilirsin.

## 4. GitHub Pages'e Yükle
1. GitHub hesabında **naciye** adında bir repo oluştur.
2. Bu klasördeki tüm dosyaları repoya yükle.
3. Repo **Settings > Pages** sekmesinden Source: Deploy from a branch, branch: main, klasör: / (root) seç.
4. Birkaç dakika sonra site şu adreste yayında olacak:
   `https://kullaniciadin.github.io/naciye/`

## 5. Kullanım
1. Giriş yaptıktan sonra **Hesapla** sayfası açılır. Adım adım ilerler:
   - 1. Adım: Yemek seç (kartlara tıkla).
   - 2. Adım: O yemeğin malzemeleri gelir, kullandığın gerçek miktarları gir.
   - 3. Adım: Üretilen toplam miktar (kg) otomatik önerilir, istersen değiştir; "Hesapla" butonuna bas, toplam maliyet ve 1 kg fiyatı görünür.
   - "Geri" butonuyla önceki adıma dönebilirsin.
2. **Master Tablo** sayfasında iki sekme var: Malzemeler ve Yemekler. Buradan fiyatları güncelleyebilir, yeni yemek/malzeme ekleyebilir veya var olanları düzenleyip silebilirsin.

## Önemli Notlar
- Bir malzemenin fiyatını Master Tablo'dan güncellediğinde, sonraki tüm hesaplamalar otomatik yeni fiyatı kullanır.
- Site tamamen ücretsiz: GitHub Pages barındırma + Supabase ücretsiz plan.
- Şu an geçmiş hesaplamalar kaydedilmiyor, sadece anlık sonuç gösteriliyor. İstenirse ileride hesaplama geçmişi eklenebilir.
