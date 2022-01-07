/*==================== SET OPERATORLERI: UNION, UNION ALL======================
    
    UNION, UNION ALL, (oracleSql->INTERSECT, ve MINUS) gibi SET operatorleri yardimiyla  
    Çoklu Sorgular birlestirilebilirler.
    UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc 
    kumelerini birlesitirerek tek bir sonuc kumesi olusturur.    
   
    NOT:  Birlesik olan olan Sorgu ifadesinin veri türü diger sorgulardaki 
    ifadelerin veri türü ile uyumlu olmalidir.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT: UNION operatoru SADECE benzersiz degerleri alir. Benzerli verileri almak
    için UNION ALL kullanilir.
==============================================================================*/ 
CREATE TABLE personel 
    (
        id int  PRIMARY KEY, 
        isim VARCHAR(50), 
        sehir VARCHAR(50), 
        maas int, 
        sirket VARCHAR(20)
        
    );
   
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel VALUES(345678902, 'Mehmet Ozturk', 'istanbul', 3500, 'Honda'); 
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
    
    SELECT * FROM personel;
    
/* -----------------------------------------------------------------------------
  ORNEK1: Maasi 4000’den cok olan isci isimlerini + 5000 liradan fazla maas 
  alinan sehirleri gosteren sorguyu yaziniz
------------------------------------------------------------------------------*/
select isim as isim_sehir, maas
from personel
where maas>4000
union
select sehir,maas
from personel
where maas>5000;

/* -----------------------------------------------------------------------------
  ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki 
  personelin maaslarini yüksekten alçaga dogru siralayarak bir tabloda gosteren 
  sorguyu yaziniz.    
------------------------------------------------------------------------------*/  
select maas, isim as isim_sehir
from personel
where isim='Mehmet Ozturk'
union 
select maas, sehir
from personel
where sehir ='Istanbul'
order by maas desc;

/* -----------------------------------------------------------------------------
  ORNEK3: Honda,Ford ve Tofas’ta calisan  personelin ismini listeleyin
------------------------------------------------------------------------------*/  

select isim from personel
where sirket='Honda'
union all
select isim from personel
where sirket='Ford'
union all
select isim from personel
where sirket='Tofas';

-- tekrarlilar gelmesin istersek sadece union
select isim from personel
where sirket='Honda'
union 
select isim from personel
where sirket='Ford'
union 
select isim from personel
where sirket='Tofas';

/* -----------------------------------------------------------------------------
  ORNEK4: 5000’den az maas alanlarin bilgileri ile, arti Honda calisani olmayanlarin bilgilerini
 alt alta listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 

select isim, maas, sirket
from personel
where maas< 5000

union

select isim, maas,sirket
from personel
where sirket !='Honda';

/* -----------------------------------------------------------------------------
  ORNEK5: Ismi Mehmet Ozturk olanlarin sehirlerini + olarak Istanbul’da calismayanlarin isimlerini ve 
  sehirlerini listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/
select isim,sehir
from personel
where  isim='Mehmet Ozturk'
union
select isim,sehir
from personel
where sehir <> 'istanbul';


/*======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/   
    
    CREATE TABLE personel_bilgi 
    (
        id int, 
        tel char(10) UNIQUE , 
        cocuk_sayisi int
      
    ); 
   
    INSERT INTO personel_bilgi VALUES(123, '5302345678' , 5);
    INSERT INTO personel_bilgi VALUES(234, '5422345678', 4);
    INSERT INTO personel_bilgi VALUES(345, '5354561245', 3); 
    INSERT INTO personel_bilgi VALUES(478, '5411452659', 3);
    INSERT INTO personel_bilgi VALUES(789, '5551253698', 2);
    INSERT INTO personel_bilgi VALUES(344, '5524578574', 2);
    INSERT INTO personel_bilgi VALUES(125, '5537488585', 1);

/* -----------------------------------------------------------------------------
  ORNEK6: id’si 123456789 olan personelin Personel tablosundan sehir ve 
  maasini, personel_bilgi tablosundan da (id ilk 3 hanesiyle kaydolmuş=123)
  tel ve cocuk sayisini yazdirin  
------------------------------------------------------------------------------*/    

select sehir  as sehir_tel, maas as maas_cocukSayisi
from personel
where id=123456789
union
select tel, cocuk_sayisi
from personel_bilgi
where id=123;


/* -----------------------------------------------------------------------------
  ORNEK7: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini
 ve 
 Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.

------------------------------------------------------------------------------*/

select id from personel
where sehir in('istanbul','Ankara')
union
select id from personel_bilgi
where cocuk_sayisi in(2,3);


-- sirketlerden grupla sirketlerin çalisan isimlerini say
select sirket, count(isim)
from personel
group by sirket;
