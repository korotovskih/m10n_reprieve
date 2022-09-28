﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КартаСвойств_ = Новый Соответствие;
	КартаСвойств_.Вставить(Элементы.ГенДирСНИЛС.Имя, МИтКС.СвойствоСнилсДиректора());
	КартаСвойств_.Вставить(Элементы.ГенДирФИО.Имя, МИтКС.СвойствоФиоДиректора());
	КартаСвойств_.Вставить(Элементы.МобТелефонГенДирИлиИспОрган.Имя, МИтКС.СвойствоТелефонДиректора());
	КартаСвойств_.Вставить(Элементы.МобТелефонОтветсвенногоКадры.Имя, МИтКС.СвойствоТелефонКадровика());
	КартаСвойств_.Вставить(Элементы.ОтпечатокСертификата.Имя, МИтКС.СвойствоСертификатДиректора());
	
	КартаСвойств = Новый ФиксированноеСоответствие(КартаСвойств_);
	
	_ОбновитьФормуНаСервере();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	_ОбновитьФормуНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаПриИзменении(Элемент)
	
	_НастройкаПриИзмененииНаСервере(Элемент.Имя)
	
КонецПроцедуры

&НаКлиенте
Процедура ОтпечатокСертификатаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОткрытьФорму("Справочник.СертификатыКлючейЭлектроннойПодписиИШифрования.ФормаВыбора", , Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтпечатокСертификатаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОтпечатокСертификата = _ОтпечатокСертификата(ВыбранноеЗначение);
	
	НастройкаПриИзменении(Элемент);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура _НастройкаПриИзмененииНаСервере(ИмяЭлемента)
	
	Свойство = КартаСвойств.Получить(ИмяЭлемента);
	
	МИт.ЗаписатьЗначениеСвойства(Организация, Свойство, ЭтаФорма[ИмяЭлемента]);
	
	_ОбновитьФормуНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура _ПеречитатьНастройкиНаСервере()
	
	Если ЗначениеЗаполнено(Организация) Тогда
		ГенДирФИО = МИт.ЗначениеСвойства(Организация, КартаСвойств["ГенДирФИО"]);
		МобТелефонГенДирИлиИспОрган = МИт.ЗначениеСвойства(Организация, КартаСвойств["МобТелефонГенДирИлиИспОрган"]);
		МобТелефонОтветсвенногоКадры = МИт.ЗначениеСвойства(Организация, КартаСвойств["МобТелефонОтветсвенногоКадры"]);
		ГенДирСНИЛС = МИт.ЗначениеСвойства(Организация, КартаСвойств["ГенДирСНИЛС"]);
		ОтпечатокСертификата = МИт.ЗначениеСвойства(Организация, КартаСвойств["ОтпечатокСертификата"]);
	Иначе
		ГенДирФИО = "";
		МобТелефонГенДирИлиИспОрган = "";
		МобТелефонОтветсвенногоКадры = "";
		ГенДирСНИЛС = "";
		ОтпечатокСертификата = "";
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура _ОбновитьФормуНаСервере()
	
	_ПеречитатьНастройкиНаСервере();
	
	СостояниеФормы = _СостояниеФормы();
	СостояниеФормы.Организация = Организация;
	
	_ОбновитьФорму(ЭтаФорма, СостояниеФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура _ОбновитьФормуНаКлиенте()
	
	СостояниеФормы = _СостояниеФормы();
	СостояниеФормы.Организация = Организация;
	
	_ОбновитьФорму(ЭтаФорма, СостояниеФормы);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура _ОбновитьФорму(Форма, СостояниеФормы)
	
	Если ЗначениеЗаполнено(СостояниеФормы.Организация) Тогда
		ТекущийЭкран = Форма.Элементы.ЭкранНастройки;
	Иначе
		ТекущийЭкран = Форма.Элементы.ЭкранВыборОрганизации;
	КонецЕсли;
	
	Форма.Элементы.ЭкраныФормы.ТекущаяСтраница = ТекущийЭкран;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция _СостояниеФормы() Экспорт
	
	Модель = Новый Структура;
	Модель.Вставить("Организация", Ложь);
	
	Возврат Модель;
	
КонецФункции

&НаСервереБезКонтекста
Функция _ОтпечатокСертификата(Сертификат) Экспорт
	
	Возврат Сертификат.Отпечаток;
	
КонецФункции

#КонецОбласти // СлужебныеПроцедурыИФункции