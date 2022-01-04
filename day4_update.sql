use sys;
/* ============================== UPDATE SET ===================================    
    
    
==============================================================================*/  
 
   CREATE TABLE tedarikciler -- parent
    (
        vergi_no int PRIMARY KEY,
        firma_ismi VARCHAR(50),
        irtibat_ismi VARCHAR(50)
       ); 
    
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
    INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
    INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
    
    CREATE TABLE urunler -- child
    (
        ted_vergino int, 
        urun_id int, 
        urun_isim VARCHAR(50), 
        musteri_isim VARCHAR(50),
        CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
        on delete cascade
    );    
    
    INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
    INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
    
    SELECT * FROM tedarikciler;
    SELECT * FROM urunler;
    
    -- SYNTAX
    -- --------
    -- UPDATE tablo_adı
    -- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
    -- WHERE koşul;
   --   select * from tedarikciler , urunler where tedarikciler.vergi_no = urunler.ted_vergino;
/* -----------------------------------------------------------------------------
  ORNEK1: vergi_no’su 102 olan tedarikcinin (firma) ismini 'Vestel' olarak güncelleyeniz. 
 -----------------------------------------------------------------------------*/ 
 update tedarikciler
 set firma_ismi='VESTEL'
 where vergi_no=102;
   select * from urunler;
/* -----------------------------------------------------------------------------
  ORNEK2: Tedarikciler tablosundaki tüm firma isimlerini 'CASPER' olarak 
  güncelleyeniz. 
 -----------------------------------------------------------------------------*/ 
   
   update tedarikciler
   set firma_ismi='CASPER';
   
    
    
/* -----------------------------------------------------------------------------
  ORNEK3: vergi_no’su 101 olan tedarikcinin ismini 'casper' ve irtibat_ismi’ni 
  'Ali Veli' olarak güncelleyiniz. 
 -----------------------------------------------------------------------------*/ 
    update tedarikciler
    set firma_ismi='casper', irtibat_ismi='Ali Veli'
    where vergi_no=101;
    
/* -----------------------------------------------------------------------------
  ORNEK4: firma_ismi casper olan tedarikcinin irtibat_ismini 'İpek Bilgin' 
  olarak güncelleyiniz.
 -----------------------------------------------------------------------------*/ 
   update tedarikciler
   set irtibat_ismi='İpek Bilgin'
   where firma_ismi='casper';
   
   
/* -----------------------------------------------------------------------------
  ORNEK5: urunler tablosundaki 'Phone' değerlerini Telefon olarak güncelleyiniz.
 -----------------------------------------------------------------------------*/
   update urunler
    set urun_isim='Telefon'
    where urun_isim='Phone';
 
/* -----------------------------------------------------------------------------
  ORNEK6: urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id
  değerlerini bir arttırınız
 -----------------------------------------------------------------------------*/ 
    update urunler
  set urun_id=urun_id+1
  where urun_id>1004;
 /* ----------------------------------------------------------------------------
  ORNEK7: urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino 
  sutun değerleri ile toplayarak güncelleyiniz.
 -----------------------------------------------------------------------------*/  
   update urunler
   set urun_id = ted_vergino + urun_id;
    
    select * from urunler;
/*-----------------------------------------------------------------------------
 ORNEK8: urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci 
 tablosunda irtibat_ismi 'Adam Eve' olan firmanın ismi (firma_ismi) ile 
 degistiriniz.
 -----------------------------------------------------------------------------*/
-- üstteki 8. soruyu çözmeden önce, ilk sorularla bozulan tabloyu, 
  -- alttaki işlemleri yaparak eski haline getirelim
   delete from tedarikciler; -- 1. işlem (tedarikciler in verilerini silince (parent old için),
   -- child  olan ürünlerin verileri de silindi, bu yüzden hem parent  
   -- hem child  alttaki 2. ve 3. işlemlerle tekrar dolduruyoruz
   
   -- tedarikciler in insert lerini tekrar yapiyoruz. 2. işlem
   -- urunler in insert lerini tekrar yapiyoruz. 3.işlem
   update urunler
   set urun_isim= (select firma_ismi from tedarikciler where irtibat_ismi ='Adam Eve')
  where musteri_isim='Ali Bak';
  select * from urunler;
/*------------------------------------------------------------------------------
 ORNEK9: Laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile 
 degistirin
 -----------------------------------------------------------------------------*/
update urunler
set musteri_isim= (select irtibat_ismi  from tedarikciler where firma_ismi='Apple')
where urun_isim='Laptop';
    