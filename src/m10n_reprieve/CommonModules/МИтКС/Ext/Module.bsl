﻿#Область ПрограммныйИнтерфейс

// Стд

Функция Объединить(Структура1 = Неопределено, Структура2 = Неопределено) Экспорт
	
	МутабельныеТипы = Новый Массив;
	МутабельныеТипы.Добавить(Тип("Структура"));
	МутабельныеТипы.Добавить(Тип("Соответствие"));
	
	ИммутабельныеТипы = Новый Массив;
	ИммутабельныеТипы.Добавить(Тип("ФиксированнаяСтруктура"));
	ИммутабельныеТипы.Добавить(Тип("ФиксированноеСоответствие"));
	
	Тип1 = МутабельныеТипы.Найти(ТипЗнч(Структура1)) <> Неопределено;
	Тип2 = МутабельныеТипы.Найти(ТипЗнч(Структура2)) <> Неопределено
		ИЛИ ИммутабельныеТипы.Найти(ТипЗнч(Структура2)) <> Неопределено;
	
	Если НЕ Тип1 И НЕ Тип2 Тогда
		Результат = Новый Структура;
	ИначеЕсли Тип1 И НЕ Тип2 Тогда
		Результат = Структура1;
	ИначеЕсли НЕ Тип1 И Тип2 Тогда
		Результат = Структура2;
	Иначе
		Для Каждого Элемент Из Структура2 Цикл
			Структура1.Вставить(Элемент.Ключ, Элемент.Значение);
		КонецЦикла;
		Результат = Структура1;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ФиксированныеДанные(Данные) Экспорт
	
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		
		Массив = Новый Массив;
		Для Каждого Значение Из Данные Цикл
			Если ТипЗнч(Значение) = Тип("Структура")
				ИЛИ ТипЗнч(Значение) = Тип("Соответствие")
				ИЛИ ТипЗнч(Значение) = Тип("Массив") Тогда
				Массив.Добавить(ФиксированныеДанные(Значение));
			Иначе
				Массив.Добавить(Значение);
			КонецЕсли;
		КонецЦикла;
		
		Результат = Новый ФиксированныйМассив(Массив);
		
	ИначеЕсли ТипЗнч(Данные) = Тип("Структура") ИЛИ ТипЗнч(Данные) = Тип("Соответствие") Тогда
		
		Если ТипЗнч(Данные) = Тип("Структура") Тогда
			Коллекция = Новый Структура;
		Иначе
			Коллекция = Новый Соответствие;
		КонецЕсли;
		
		Для Каждого КлючИЗначение Из Данные Цикл
			Значение = КлючИЗначение.Значение;
			Если ТипЗнч(Значение) = Тип("Структура")
				ИЛИ ТипЗнч(Значение) = Тип("Соответствие")
				ИЛИ ТипЗнч(Значение) = Тип("Массив") Тогда
				Коллекция.Вставить(КлючИЗначение.Ключ, ФиксированныеДанные(Значение));
			Иначе
				Коллекция.Вставить(КлючИЗначение.Ключ, Значение);
			КонецЕсли;
			
		КонецЦикла;
		
		Если ТипЗнч(Данные) = Тип("Структура") Тогда
			Результат = Новый ФиксированнаяСтруктура(Коллекция);
		Иначе
			Результат = Новый ФиксированноеСоответствие(Коллекция);
		КонецЕсли;
		
	Иначе
		
		Результат = Данные;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Определения

Функция ОписаниеСвойства() Экспорт
	
	Модель = Новый Структура;
	Модель.Вставить("Идентификатор");
	Модель.Вставить("Наименование");
	Модель.Вставить("ТипЗначения");
	Модель.Вставить("Наборы", Новый Массив);
	
	Возврат Модель;
	
КонецФункции

Функция ОписаниеПодтверждения() Экспорт
	
	Модель = Новый Структура;
	
	Модель.Вставить("ОрганизацияНаименование");
	Модель.Вставить("ОрганизацияИНН");
	
	Модель.Вставить("МобТелефонОтветсвенногоКадры");
	Модель.Вставить("МобТелефонГенДирИлиИспОрган");
	
	Модель.Вставить("ГенДирФИО");
	Модель.Вставить("ГенДирСНИЛС");
	
	Модель.Вставить("СотрудникФИО");
	Модель.Вставить("СотрудникСерияПаспорта");
	Модель.Вставить("СотрудникНомерПаспорта");
	Модель.Вставить("СотрудникСНИЛС");
	
	Модель.Вставить("ТекстПодтверждение");
	Модель.Вставить("ТекстПредоставлениеПрава");
	
	Модель.Вставить("ТекстПредупреждениеОбОтветсвенности");
	Модель.Вставить("ТекстПредупредилОбОтветсвенностиСотрудника");
	Модель.Вставить("ТексПодписиГенДирИлиИспОрган");
	
	Возврат Модель;
	
КонецФункции

Функция СтатусыПодтверждения() Экспорт
	
	Модель = Новый Структура;
	Модель.Вставить("Пусто", 0);
	Модель.Вставить("Создан", 10);
	Модель.Вставить("Подписан", 20);
	Модель.Вставить("Отправлено", 100);
	Модель.Вставить("Успех", 200);
	Модель.Вставить("Отказ", 400);
	Модель.Вставить("Ошибка", 500);
	
	Возврат Модель;
	
КонецФункции

// Определения доп. свойств

Функция СвойствоСтатусПодтверждения() Экспорт
	
	Число3 = Новый КвалификаторыЧисла(3, 0, ДопустимыйЗнак.Неотрицательный);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтСтатусПодтверждения";
	Свойство.Наименование = "Статус подтверждения (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Число", , , Число3);
	Свойство.Наборы.Добавить("Справочник_Сотрудники");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоТелефонКадровика() Экспорт
	
	Строка99 = Новый КвалификаторыСтроки(99, ДопустимаяДлина.Переменная);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтМобТелефонОтветсвенногоКадры";
	Свойство.Наименование = "Телефон кадровика (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Строка", , , , Строка99);
	Свойство.Наборы.Добавить("Справочник_Организации");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоТелефонДиректора() Экспорт
	
	Строка99 = Новый КвалификаторыСтроки(99, ДопустимаяДлина.Переменная);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтМобТелефонГенДирИлиИспОрган";
	Свойство.Наименование = "Телефон директора (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Строка", , , , Строка99);
	Свойство.Наборы.Добавить("Справочник_Организации");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоСертификатДиректора() Экспорт
	
	Строка99 = Новый КвалификаторыСтроки(99, ДопустимаяДлина.Переменная);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтСертификатДиректора";
	Свойство.Наименование = "Сертификат директора (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Строка", , , , Строка99);
	Свойство.Наборы.Добавить("Справочник_Организации");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоФиоДиректора() Экспорт
	
	Строка1000 = Новый КвалификаторыСтроки(1000, ДопустимаяДлина.Переменная);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтГенДирФИО";
	Свойство.Наименование = "ФИО директора (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Строка", , , , Строка1000);
	Свойство.Наборы.Добавить("Справочник_Организации");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоСнилсДиректора() Экспорт
	
	Строка14 = Новый КвалификаторыСтроки(14, ДопустимаяДлина.Переменная);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтГенДирСНИЛС";
	Свойство.Наименование = "СНИЛС директора (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Строка", , , , Строка14);
	Свойство.Наборы.Добавить("Справочник_Организации");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоСостояниеПодтверждения() Экспорт
	
	Строка1024 = Новый КвалификаторыСтроки(1000, ДопустимаяДлина.Переменная);
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтСостояниеПодтверждения";
	Свойство.Наименование = "Состояние подтверждения (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("Строка", , , , Строка1024);
	Свойство.Наборы.Добавить("Справочник_Сотрудники");
	
	Возврат Свойство;
	
КонецФункции

Функция СвойствоДанныеПодтвержденияCSV() Экспорт
	
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтДанныеПодтвержденияCSV";
	Свойство.Наименование = "Данные подтверждения csv (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ЗначенияСвойствОбъектов");
	Свойство.Наборы.Добавить("Справочник_Сотрудники");
	
	Возврат Свойство;
	
	
КонецФункции

Функция СвойствоДанныеПодписиПодтвержденияCSV() Экспорт
	
	Свойство = ОписаниеСвойства();
	Свойство.Идентификатор = "МИтДанныеПодписиПодтвержденияCSV";
	Свойство.Наименование = "Данные подписи подтверждения csv (m10n reprieve)";
	Свойство.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ЗначенияСвойствОбъектов");
	Свойство.Наборы.Добавить("Справочник_Сотрудники");
	
	Возврат Свойство;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныйПрограммныйИнтерфейс

// Проверка параметров

Процедура ПроверитьПараметры(Параметр1 = Неопределено, Параметр2 = Неопределено, Параметр3 = Неопределено,
		Параметр4 = Неопределено, Параметр5 = Неопределено, Параметр6 = Неопределено, Параметр7 = Неопределено) Экспорт
	
	Ошибка = ОшибкаПараметра(Параметр1, Параметр2, Параметр3, Параметр4, Параметр5, Параметр6, Параметр7);
	Если Ошибка <> Неопределено Тогда
		ВызватьИсключение Ошибка.Описание;
	КонецЕсли;
	
КонецПроцедуры // ПроверитьПараметры

Функция НесоответствиеТипов(Значение, ОписаниеТипов, ЗначениеПоУмолчанию = "!?I?*H") Экспорт
	
	ОписаниеТиповСтрокой = ТипЗнч(ОписаниеТипов) = Тип("Строка");
	
	// Проверка умолчания
	
	Если ЗначениеПоУмолчанию = "!?I?*H"
		И ОписаниеТиповСтрокой
		И СтрНайти(ОписаниеТиповСтрокой, "Неопределено") Тогда
		ЗначениеПоУмолчанию_ = Неопределено;
	Иначе
		ЗначениеПоУмолчанию_ = ЗначениеПоУмолчанию;
	КонецЕсли;
	
	Если ЗначениеПоУмолчанию <> "!?I?*H"
		И Значение = ЗначениеПоУмолчанию Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	// Проверка типа
	
	Если ТипЗнч(ОписаниеТипов) = Тип("Строка") Тогда
		ОписаниеТипов_ = Новый ОписаниеТипов(ОписаниеТипов);
	Иначе
		ОписаниеТипов_ = ОписаниеТипов;
	КонецЕсли;
	
	Если НЕ ОписаниеТипов_.СодержитТип(ТипЗнч(Значение)) Тогда
		Ошибка = ОшибкаТипа();
	Иначе
		Ошибка = Неопределено;
	КонецЕсли;
	
	Возврат Ошибка;
	
КонецФункции // НесоответствиеТипов

Функция НеЗаполнено(Значение) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Значение) Тогда
		Ошибка = ОшибкаЗначения();
	Иначе
		Ошибка = Неопределено;
	КонецЕсли;
	
	Возврат Ошибка;
	
КонецФункции

// Ошибки

Функция Ошибка() Экспорт
	
	Возврат Новый Структура("Описание");
	
КонецФункции // Ошибка

Функция ОшибкаТипа() Экспорт
	
	Ошибка = Ошибка();
	Ошибка.Описание = НСтр("ru = 'Несоответствие типов'");
	
	Возврат Ошибка;
	
КонецФункции // ОшибкаТипа

Функция ОшибкаЗначения() Экспорт
	
	Ошибка = Ошибка();
	Ошибка.Описание = НСтр("ru = 'Недопустимое значение параметра'");
	
	Возврат Ошибка;
	
КонецФункции // ОшибкаЗначения

Функция ОшибкаПараметра(Параметр1 = Неопределено, Параметр2 = Неопределено, Параметр3 = Неопределено,
		Параметр4 = Неопределено, Параметр5 = Неопределено, Параметр6 = Неопределено, Параметр7 = Неопределено) Экспорт
	
	Параметры = Новый Массив;
	Параметры.Добавить(Параметр1);
	Параметры.Добавить(Параметр2);
	Параметры.Добавить(Параметр3);
	Параметры.Добавить(Параметр4);
	Параметры.Добавить(Параметр5);
	Параметры.Добавить(Параметр6);
	Параметры.Добавить(Параметр7);
	
	Шаблон = "ru = ' (параметр номер %1)'";
	
	Для Сч = 0 По Параметры.ВГраница() Цикл
		
		Параметр = Параметры[0];
		Если Параметр = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Параметр.Описание = Параметр.Описание + НСтр(СтрШаблон(Шаблон, Сч + 1));
		
		Возврат Параметр;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции // ОшибкаПараметра

#КонецОбласти // СлужебныйПрограммныйИнтерфейс