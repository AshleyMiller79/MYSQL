

-- ============================== DELETE ===================================  

    -- DELETE FROM tablo_adı;  Tablonun tüm içerğini siler.
    -- Bu komut bir DML komutudur. Dolayısıyla devamında WHERE gibi cümlecikler
    -- kullanılabilir.
    
    
    -- DELETE FROM tablo_adı
    -- WHERE sutun_adi = veri;
    
    CREATE TABLE ogrenciler
    (
        id CHAR(3),
        isim VARCHAR(50),
        veli_isim VARCHAR(50),
        yazili_notu int       
    );
  
    INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
	INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
    
  
    -- savepoint sikintisi varsa -> SET autocommit=0; 
    -- ayarlar sql execution auto commit tiki kaldr
--    DELETE FROM ogrenciler;     -- Tüm verileri sil.
--    ROLLBACK TO  ABC;  -- Silinen Verileri geri getir.
--    SELECT * FROM ogrenciler;
    
/* =============================================================================
         Seçerek silmek için WHERE Anahtar kelimesi kullanılabilir. 
===============================================================================*/     

/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/ 
  
    delete from ogrenciler where id=124;
    
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan satırını siliniz.
 -----------------------------------------------------------------------------*/   
     
      delete from ogrenciler where isim='Kemal Yasa';
      
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
 -----------------------------------------------------------------------------*/        
 --  delete from ogrenciler where isim='Nesibe Yilmaz' or isim='Mustafa Bak';
   
   delete from ogrenciler where isim in('Nesibe Yilmaz', 'Mustafa Bak');
   
   select * from ogrenciler;
/* ----------------------------------------------------------------------------
  ORNEK4: İsmi Ali Can ve id'si 123 olan kaydı siliniz.
 -----------------------------------------------------------------------------*/    
    delete from ogrenciler where isim='Ali Can' and id=123;  
   
   
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kayıtları silelim.
 -----------------------------------------------------------------------------*/  
  delete from ogrenciler where id>126;
    
 
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 veya 126 olanları silelim.
 -----------------------------------------------------------------------------*/     
    delete from ogrenciler where id in('123','125','126');
    
    
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKİ TÜM KAYITLARI SİLELİM..
 -----------------------------------------------------------------------------*/     
   
    delete from ogrenciler;
    
    
-- *************************************************    
    
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz 
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir   

/* ======================== DELETE - TRUNCATE - DROP ============================   
  
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
    Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML değil DDL komutudur.*/ 
         TRUNCATE TABLE ogrenciler;  -- doğru yazım
       drop table ogrenciler;
       delete from ogrenciler;
    
   /* 2-) DELETE komutu beraberinde WHERE cümleciği kullanılabilir. TRUNCATE ile 
    kullanılmaz.
        TRUNCATE TABLE ogrenciler
        WHERE veli_isim='Hasan';  .....yanlış yazım
        
-- TRUNCATE komutu tablo yapısını değiştirmeden, 
-- tablo içinde yer alan tüm verileri tek komutla silmenizi sağlar.
        
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylıkla geri 
    alınabilir.
    
    4-) Truncate ile silinen veriler geri alınması daha zordur. Ancak
    Transaction yöntemi ile geri alınması mümkün olabilir.
    
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da 
    siler. 
==============================================================================*/ 
    -- INSERT veri girişinden sonra SAVEPOİNT ABC; ile verileri buraya sakla
    -- (yanlışlık yapma olasılığına karşın önlem gibi, AYNI İSİMDE BAŞKA TABLO VARSA)
    -- sonra istediğini sil (ister tümü ister bir kısmı)
    -- sonra savepoint yaptığın yerden alttaki gibi rollback ile verileri geri getir
   
   INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
	INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
    savepoint abc;
    
    select * from ogrenciler;
        
delete from ogrenciler;
 
 rollback to abc;
