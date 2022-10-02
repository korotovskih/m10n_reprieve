﻿#Область ПрограммныйИнтерфейс

Процедура ЗаполнитьОписаниеПодтверждения(ОписаниеПодтверждения, Объект, ДопПараметры) Экспорт
	
	Если ПравоДоступа("Administration", Метаданные) = Ложь
		И БезопасныйРежим() = Ложь
		И ПривилегированныйРежим() = Ложь Тогда
		УстановитьПривилегированныйРежим(Истина);
	КонецЕсли;
	
	_ЗаполнитьОписаниеПодтверждения(ОписаниеПодтверждения, Объект, ДопПараметры);
	
КонецПроцедуры

Процедура ЗаполнитьОписаниеПодтвержденияПоФизЛицу(ОписаниеПодтверждения, Объект, ДопПараметры) Экспорт
	
	// TODO
	
КонецПроцедуры

Функция ФормаCsvПоСотруднику(Сотрудник) Экспорт
	
	Возврат МИт.ЗначениеСвойства(Сотрудник, МИтКС.СвойствоДанныеПодтвержденияCSV());
	
КонецФункции

Функция ПодписьCsvПоСотруднику(Сотрудник) Экспорт
	
	Возврат МИт.ЗначениеСвойства(Сотрудник, МИтКС.СвойствоДанныеПодписиПодтвержденияCSV());
	
КонецФункции

Функция СоздатьКонтейнерФормыCSV(ДвоичныеДанные, ДопПараметры = Неопределено) Экспорт
	
	Если ПравоДоступа("Administration", Метаданные) = Ложь
		И БезопасныйРежим() = Ложь
		И ПривилегированныйРежим() = Ложь Тогда
		УстановитьПривилегированныйРежим(Истина);
	КонецЕсли;
	
	Если ДвоичныеДанные.Размер() = 0 Тогда
		Возврат Справочники.ЗначенияСвойствОбъектов.ПустаяСсылка();
	КонецЕсли;
	
	Объект = Справочники.ЗначенияСвойствОбъектов.СоздатьЭлемент();
	Объект.Наименование = Строка(Новый УникальныйИдентификатор);
	Объект.ПолноеНаименование = ПолучитьBase64СтрокуИзДвоичныхДанных(ДвоичныеДанные);
	Объект.Владелец = Обработки.МИтСвойства.Создать().Свойство(МИтКС.СвойствоДанныеПодтвержденияCSV());
	Объект.Записать();
	
	Возврат Объект.Ссылка;
	
КонецФункции

Функция СоздатьКонтейнерПодписиФормыCSV(ДвоичныеДанные, ДопПараметры = Неопределено) Экспорт
	
	Если ПравоДоступа("Administration", Метаданные) = Ложь
		И БезопасныйРежим() = Ложь
		И ПривилегированныйРежим() = Ложь Тогда
		УстановитьПривилегированныйРежим(Истина);
	КонецЕсли;
	
	Если ДвоичныеДанные.Размер() = 0 Тогда
		Возврат Справочники.ЗначенияСвойствОбъектов.ПустаяСсылка();
	КонецЕсли;
	
	Объект = Справочники.ЗначенияСвойствОбъектов.СоздатьЭлемент();
	Объект.Наименование = Строка(Новый УникальныйИдентификатор);
	Объект.ПолноеНаименование = ПолучитьBase64СтрокуИзДвоичныхДанных(ДвоичныеДанные);
	Объект.Владелец = Обработки.МИтСвойства.Создать().Свойство(МИтКС.СвойствоДанныеПодписиПодтвержденияCSV());
	Объект.Записать();
	
	Возврат Объект.Ссылка;
	
КонецФункции

Функция КонтейнерЗаполнен(Контейнер) Экспорт
	
	Возврат ЗначениеЗаполнено(Контейнер);
	
КонецФункции

Функция ПолучитьЗначение(Контейнер) Экспорт
	
	Возврат ПолучитьДвоичныеДанныеИзBase64Строки(Контейнер.ПолноеНаименование);
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

//

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция _ЗаполнитьОписаниеПодтверждения(ОписаниеПодтверждения, Сотрудник, ДопПараметры)
	
	ДанныеФл = _СформироватьДанныеФизЛица(Сотрудник.ФизическоеЛицо, ДопПараметры);
	ДанныеЮл = _СформироватьДанныеЮл(Сотрудник.ГоловнаяОрганизация, ДопПараметры);
	ДанныеРуководителя = _СформироватьДанныеФизЛица(ДанныеЮл.Руководитель, ДопПараметры);
	ДанныеКадровика = _СформироватьДанныеФизЛица(ДанныеЮл.Кадровик, ДопПараметры);
	
	_ЗаполнитьРуководителяПоНастройкам(ДанныеРуководителя, ДопПараметры);
	_ЗаполнитьКадровикаПоНастройкам(ДанныеКадровика, ДопПараметры);
	
	ОписаниеПодтверждения.СотрудникФио = ДанныеФл.Фио;
	ОписаниеПодтверждения.СотрудникСнилс = ДанныеФл.Снилс;
	ОписаниеПодтверждения.СотрудникНомерПаспорта = ДанныеФл.НомерПаспорта;
	ОписаниеПодтверждения.СотрудникСерияПаспорта = ДанныеФл.СерияПаспорта;
	
	ОписаниеПодтверждения.ОрганизацияНаименование = ДанныеЮл.Наименование;
	ОписаниеПодтверждения.ОрганизацияИНН = ДанныеЮл.ИНН;
	ОписаниеПодтверждения.ГенДирФИО = ДанныеРуководителя.ФИО;
	ОписаниеПодтверждения.ГенДирСНИЛС = ДанныеРуководителя.Снилс;
	ОписаниеПодтверждения.МобТелефонГенДирИлиИспОрган = ДанныеРуководителя.Телефон;
	ОписаниеПодтверждения.МобТелефонОтветсвенногоКадры = ДанныеКадровика.Телефон;
	
КонецФункции

Процедура _ЗаполнитьРуководителяПоНастройкам(Объект, ДопПараметры)

	Если ТипЗнч(ДопПараметры) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Если ДопПараметры.Свойство("ГенДирФИО") Тогда
		Объект.Фио = ДопПараметры.ГенДирФИО;
	КонецЕсли;
	
	Если ДопПараметры.Свойство("ГенДирСНИЛС") Тогда
		Объект.Снилс = ДопПараметры.ГенДирСНИЛС;
	КонецЕсли;
	
	Если ДопПараметры.Свойство("МобТелефонГенДирИлиИспОрган") Тогда
		Объект.Телефон = ДопПараметры.МобТелефонГенДирИлиИспОрган;
	КонецЕсли;
	
КонецПроцедуры

Процедура _ЗаполнитьКадровикаПоНастройкам(Объект, ДопПараметры)

	Если ТипЗнч(ДопПараметры) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Если ДопПараметры.Свойство("МобТелефонОтветсвенногоКадры") Тогда
		Объект.Телефон = ДопПараметры.МобТелефонОтветсвенногоКадры;
	КонецЕсли;
	
КонецПроцедуры

Функция _СформироватьДанныеФизЛица(ФизЛицо, ДопПараметры)
	
	Результат = _ОпределениеФизЛица();
	
	Если ДопПараметры <> Неопределено И ДопПараметры.Свойство("Дата") Тогда
		Период = ДопПараметры.Дата;
	Иначе
		Период = ТекущаяДатаСеанса();
	КонецЕсли;
	
	ФизическиеЛицаМассив = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ФизЛицо);
	ИменаПолей = "ФИОПолные, ДокументВид, ДокументСерия, ДокументНомер, 
		| ТелефонРабочийПредставление, ТелефонМобильныйПредставление, СтраховойНомерПФР";
	ДанныеФизЛица = КадровыйУчет.КадровыеДанныеФизическихЛиц(Истина, ФизическиеЛицаМассив, ИменаПолей, Период);
	
	Для Каждого Элемент Из ДанныеФизЛица Цикл
		
		Результат.ФИО = Элемент.ФИОПолные;
		Результат.Снилс = Элемент.СтраховойНомерПФР;
		Результат.НомерПаспорта = Элемент.ДокументНомер;
		Результат.СерияПаспорта = Элемент.ДокументСерия;
		
		Если ЗначениеЗаполнено(Элемент.ТелефонРабочийПредставление) Тогда
			Результат.Телефон = Элемент.ТелефонРабочийПредставление;
		ИначеЕсли ЗначениеЗаполнено(Элемент.ТелефонМобильныйПредставление) Тогда
			Результат.Телефон = Элемент.ТелефонМобильныйПредставление;
		Иначе
			Результат.Телефон = "";
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция _СформироватьДанныеЮл(Организация, ДопПараметры)
	
	Результат = _ОпределениеЮл();
	
	Если ДопПараметры <> Неопределено И ДопПараметры.Свойство("Дата") Тогда
		Период = ДопПараметры.Дата;
	Иначе
		Период = ТекущаяДатаСеанса();
	КонецЕсли;
	
	ИменаПолей = "Руководитель, РуководительКадровойСлужбы, ГлавныйБухгалтер";
	
	Если Метаданные.ОбщиеМодули.Найти("СведенияОбОтветственныхЛицах") <> Неопределено Тогда
		ОтветственныеЛица = Вычислить("СведенияОбОтветственныхЛицах").ОтветственныеЛицаОрганизации(Организация, ИменаПолей, Период);
	ИначеЕсли Метаданные.ОбщиеМодули.Найти("ОтветственныеЛицаБП") <> Неопределено Тогда
		ОтветственныеЛица = Вычислить("ОтветственныеЛицаБП").ОтветственныеЛица(Организация, Период);
	Иначе
		Возврат Результат;
	КонецЕсли;
	
	Результат.Наименование = Организация.НаименованиеПолное;
	Результат.ИНН = Организация.ИНН;
	Результат.Руководитель = ОтветственныеЛица.Руководитель;
	Если ОтветственныеЛица.Свойство("РуководительКадровойСлужбы")
		И ЗначениеЗаполнено(ОтветственныеЛица.РуководительКадровойСлужбы) Тогда
		Результат.Кадровик = ОтветственныеЛица.РуководительКадровойСлужбы;
	Иначе
		Результат.Кадровик = ОтветственныеЛица.Руководитель;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция _ОпределениеФизЛица()
	
	Результат = Новый Структура;
	Результат.Вставить("ФИО");
	Результат.Вставить("СерияПаспорта");
	Результат.Вставить("НомерПаспорта");
	Результат.Вставить("Снилс");
	Результат.Вставить("Телефон");
	
	Возврат Результат;
	
КонецФункции

Функция _ОпределениеЮл()
	
	Результат = Новый Структура;
	Результат.Вставить("Наименование");
	Результат.Вставить("ИНН");
	Результат.Вставить("Руководитель");
	Результат.Вставить("Кадровик");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти