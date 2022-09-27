﻿// Свойства
&НаКлиенте
Перем Сценарии Экспорт;

#Область ВАдаптер

// Интерфейс VA
&НаКлиенте
Перем Ванесса, Контекст Экспорт, КонтекстСохраняемый Экспорт;

&НаКлиенте
Функция ПолучитьСписокТестов(Фреймворк) Экспорт
	
	Если Сценарии = Неопределено Тогда
		Сценарии = Сценарии(); 	
	КонецЕсли;
	
	Если Ванесса = Неопределено Тогда
		Ванесса = Фреймворк; 	
	КонецЕсли;	
	
	Тесты = Новый Массив;	
	Для Каждого Сценарий Из Сценарии Цикл
		Для Каждого Команда Из Сценарий.Команды Цикл
			Снипет = СтрРазделить(Сценарий.ИмяФормы, "."); 
			Снипет.Добавить(Команда.Действие);
			Снипет[0] = СтрЗаменить(Снипет[0], "Обработка", "DataProcessor"); 
			Снипет[2] = СтрЗаменить(Снипет[2], "Форма", "Form");	
			ИмяПоиска = СтрСоединить(Снипет) + "()";
			ИмяПолное = СтрСоединить(Снипет, ".");
			Фреймворк.ДобавитьШагВМассивТестов(Тесты, ИмяПоиска, "прокси", ИмяПолное, ИмяПолное, "Тесты");
		КонецЦикла;
	КонецЦикла;

	Возврат Тесты;
	
КонецФункции

&НаКлиенте
Функция Сценарии() Экспорт
	
	Сценарии = Новый Массив;
	Для Каждого Элемент Из Формы() Цикл
		Сценарий = ПолучитьФорму(Элемент);
		Сценарии.Добавить(Сценарий);
	КонецЦикла;
	
	Возврат Сценарии;	
	
КонецФункции

&НаКлиенте
Функция Сценарий(Имя) Экспорт
	
	ИмяПоиск = НРег(СокрЛП(Имя));	
	Сценарий = Неопределено;
	Для Каждого Элемент Из Сценарии Цикл
		Если Прав(НРег(Элемент.ИмяФормы), СтрДлина(ИмяПоиск)) = ИмяПоиск Тогда
			Сценарий = Элемент;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Сценарий;
	
КонецФункции

&НаСервере
Функция Формы() Экспорт
		
	Мета = РеквизитФормыВЗначение("Объект").Метаданные();	
	
	Формы = Новый Массив;
	Для Каждого Форма Из Мета.Формы Цикл
		
		Попустить = Форма.Имя = "Форма"
			Или Форма = Мета.ОсновнаяФорма
			Или Форма = Мета.ДополнительнаяФорма;
		
		Если Попустить Тогда
			Продолжить;	
		КонецЕсли;
		
		Массив = Новый Массив;
		Массив.Добавить("DataProcessor");
		Массив.Добавить(Мета.Имя);
		Массив.Добавить("Form");
		Массив.Добавить(Форма.Имя);
		
		Формы.Добавить(СтрСоединить(Массив, "."));	
		
	КонецЦикла;
	
	Возврат Формы;
	
КонецФункции

&НаКлиенте
Функция Прокси(Знач Параметр1 = Null, 
	Знач Параметр2 = Null, 
	Знач Параметр3 = Null, 
	Знач Параметр4 = Null, 
	Знач Параметр5 = Null, 
	Знач Параметр6 = Null) Экспорт
	
	Состояние = Ванесса.ПолучитьСостояниеVanessaAutomation();	
	Структура = СтрРазделить(Состояние.ТекущийШаг.Имя, ".");	
	Сценарий = Сценарий(Структура[3]);
	Команда = Сценарий.Команды.Найти(СокрЛП(Структура[4]));	
			
	Если Параметр6 <> Null Тогда
		Аргументы = "Параметр1, Параметр2, Параметр3, Параметр4, Параметр5, Параметр6";
	ИначеЕсли Параметр5 <> Null Тогда
		Аргументы = "Параметр1, Параметр2, Параметр3, Параметр4, Параметр5";
	ИначеЕсли Параметр4 <> Null Тогда
		Аргументы = "Параметр1, Параметр2, Параметр3, Параметр4";
	ИначеЕсли Параметр3 <> Null Тогда
		Аргументы = "Параметр1, Параметр2, Параметр3";		
	ИначеЕсли Параметр2 <> Null Тогда
		Аргументы = "Параметр1, Параметр2";
	ИначеЕсли Параметр1 <> Null Тогда
		Аргументы = "Параметр1";
	Иначе
		Аргументы = "";
	КонецЕсли;	
		
	Выражение = СтрШаблон("Сценарий.%1(%2)", Команда.Действие, Аргументы);
	Выполнить(Выражение);
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Область Форма

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

    КомандаФормы = Команды.Добавить("ВыполнитьСценарий");
    КомандаФормы.Действие = КомандаФормы.Имя;
    КомандаФормы.Заголовок = "Выполнить";	
	
	Кнопка = Элементы.Добавить(КомандаФормы.Имя, Тип("КнопкаФормы"), Элементы.ФормаКоманднаяПанель);
	Кнопка.Вид = ВидКнопкиФормы.КнопкаКоманднойПанели;
	Кнопка.ИмяКоманды = КомандаФормы.Имя;
	Кнопка.КнопкаПоУмолчанию = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	Сценарии = Сценарии();
	Для Каждого Сценарий Из Сценарии Цикл
		
		СценарииСтроки = КоллекцияТестов.ПолучитьЭлементы();	
		СценарийСтрока = СценарииСтроки.Добавить();
		СценарийСтрока.Тип = ТипЗнч(Сценарий);
		СценарийСтрока.Значение = СтрРазделить(Сценарий.ИмяФормы, ".").Получить(3);	
		СценарийСтроки = СценарийСтрока.ПолучитьЭлементы();
		
		Для Каждого Команда Из Сценарий.Команды Цикл
			ТестСтрока = СценарийСтроки.Добавить();
			ТестСтрока.Тип = ТипЗнч(Команда);
			ТестСтрока.Значение = Команда.Действие;		
		КонецЦикла;
		
	КонецЦикла;
		
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьСценарий(Команда)

	ТекущиеДанные = Элементы.КоллекцияТестов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Если ТекущиеДанные.Тип = Тип("ФормаКлиентскогоПриложения") Тогда
		Сценарий = ТекущиеДанные;
		Тесты = ТекущиеДанные.ПолучитьЭлементы();	
	ИначеЕсли ТекущиеДанные.Тип = Тип("КомандаФормы") Тогда
		Сценарий = ТекущиеДанные.ПолучитьРодителя();
		Тесты = Новый Массив;
	    Тесты.Добавить(ТекущиеДанные);
	Иначе
		ВызватьИсключение "ValueError: " + Строка(ТекущиеДанные.Тип);
	КонецЕсли;
	
	Для Каждого Элемент Из Тесты Цикл
		ВыполнитьТест(Сценарий, Элемент);	
	КонецЦикла;
	
	Сценарий.Статус = 0;
	Для Каждого Элемент Из Сценарий.ПолучитьЭлементы() Цикл
		Если Элемент.Статус > Сценарий.Статус Тогда
			Сценарий.Статус = Элемент.Статус;	
		КонецЕсли;		
	КонецЦикла;	
	
КонецПроцедуры

#КонецОбласти

#Область Служебные

&НаКлиенте
Процедура ВыполнитьТест(ЭлементСценарий, ЭлементТест)
	
	Сценарий = Сценарий(ЭлементСценарий.Значение);	
	Попытка
		Выражение = СтрШаблон("Сценарий.%1(%2)", ЭлементТест.Значение, "");
		Выполнить(Выражение);
		ЭлементТест.Статус = 200;
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		Сообщить(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
		ЭлементТест.Статус = 400;	
	КонецПопытки;	
	
КонецПроцедуры

#КонецОбласти