﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Элементы.РедактироватьФормы.Пометка = Ложь;	
	
	Для Каждого Сотрудник Из Параметры.Сотрудники Цикл		
		Строка = ТаблицаСостояние.Добавить();
		Строка.Организация = Сотрудник.ГоловнаяОрганизация;
		Строка.ФизЛицо = Сотрудник.ФизическоеЛицо;
		Строка.Сотрудник = Сотрудник;		
	КонецЦикла;	

	Для Каждого Строка Из ТаблицаСостояние Цикл				
		Данные = _ДанныеСостояние(Строка.Сотрудник, Строка.ФизЛицо, Строка.Организация);		
		ЗаполнитьЗначенияСвойств(Строка, Данные);				
	КонецЦикла;	
	
	_ОбновитьФормуНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПодключитьОбработчикОжидания("_ПроверитьОбнолвениеНаКлиенте", 5, Истина);

КонецПроцедуры

&НаКлиенте
Процедура РедактироватьФормы(Команда)

	Элементы.РедактироватьФормы.Пометка = НЕ Элементы.РедактироватьФормы.Пометка;

	_ОбновитьФормуНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьФормы(Команда)

	ТекстСостояния = "Обновляем данные";
	
	Сч = 0;
	Всего = ТаблицаСостояние.Количество();
	Для Каждого Строка Из ТаблицаСостояние Цикл		
		
		Попытка	
			Данные = _ДанныеСостояние(Строка.Сотрудник, Строка.ФизЛицо, Строка.Организация);		
			ЗаполнитьЗначенияСвойств(Строка, Данные);			
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();	
			Строка.Состояние = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
		КонецПопытки;
		
		Сч = Сч + 1;
		Прогресс = Окр((Сч / Всего) * 100);
		Состояние(ТекстСостояния, Прогресс);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьФормы(Команда)

	ТекстСостояния = "Формируем документы";
	
	Сч = 0;
	Всего = ТаблицаСостояние.Количество();
	Для Каждого Строка Из ТаблицаСостояние Цикл		
		
		ОписаниеПодтверждения = МИтКС.ОписаниеПодтверждения();		
		ЗаполнитьЗначенияСвойств(ОписаниеПодтверждения, Строка); 
		
		Попытка	
			Данные = _СформироватьФормы(Строка.Сотрудник, МИтКС.ФиксированныеДанные(ОписаниеПодтверждения));		
			ЗаполнитьЗначенияСвойств(Строка, Данные);			
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();	
			Строка.Состояние = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
			Продолжить;
		КонецПопытки;
		
		Сч = Сч + 1;
		Прогресс = Окр((Сч / Всего) * 100);
		Состояние(ТекстСостояния, Прогресс);
		
	КонецЦикла;
		
КонецПроцедуры

&НаКлиенте
Процедура ПодписатьФормы(Команда)
	
	// TODO подписание на клиенте
	
	Оповещение = Новый ОписаниеОповещения("_СохранитьПодписи", ЭтаФорма);
		
	ВыполнитьОбработкуОповещения(Оповещение, Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФормы(Команда)
	
	ТекстСостояния = "Подготавливаем файлы";
	
	Сч = 0;
	Всего = ТаблицаСостояние.Количество();
	Файлы = Новый Массив;
	Для Каждого Строка Из ТаблицаСостояние Цикл		
		
		Попытка	
			Данные = _ПодготовитьФормыПодтверждениеПоСотруднику(Строка.Сотрудник, УникальныйИдентификатор);		
			ЗаполнитьЗначенияСвойств(Строка, Данные);			
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();	
			Строка.Состояние = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
			Продолжить;
		КонецПопытки;
		
		Для Каждого Элемент Из Данные.Файлы Цикл
			Файлы.Добавить(Элемент);	
		КонецЦикла;
		
		Сч = Сч + 1;
		Прогресс = Окр((Сч / Всего) * 100);
		Состояние(ТекстСостояния, Прогресс);
		
	КонецЦикла;	
	
	ФайловаяСистемаКлиент.СохранитьФайлы(Неопределено, Файлы); 
		
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФорму(Команда)

	ТекущиеДанные = Элементы.ТаблицаСостояние.ТекущиеДанные;	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Файлы = Новый Массив;
	Попытка	
		Данные = _ПодготовитьФормыПодтверждениеПоСотруднику(ТекущиеДанные.Сотрудник, УникальныйИдентификатор);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, Данные);			
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();	
		ТекущиеДанные.Состояние = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
		Возврат;
	КонецПопытки;	

	Для Каждого Элемент Из Данные.Файлы Цикл
		Файлы.Добавить(Элемент);	
	КонецЦикла;	

	ФайловаяСистемаКлиент.СохранитьФайлы(Неопределено, Файлы);
	
КонецПроцедуры

&НаКлиенте
Процедура РазослатьФормы(Команда)

	ТекстСостояния = "Отправляем файлы";
	
	Сч = 0;
	Всего = ТаблицаСостояние.Количество();
	Для Каждого Строка Из ТаблицаСостояние Цикл		
		
		Попытка	
			Данные = _ОтправитьФайлыСотруднику(Строка.Сотрудник, УникальныйИдентификатор);		
			ЗаполнитьЗначенияСвойств(Строка, Данные);			
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();	
			Строка.Состояние = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
			Продолжить;
		КонецПопытки;
		
		Сч = Сч + 1;
		Прогресс = Окр((Сч / Всего) * 100);
		Состояние(ТекстСостояния, Прогресс);
		
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьОбновление(Команда)
	
	ОткрытьФорму(
		"Обработка.МИтОбслуживание.Форма.Обновление", 
		Новый Структура("ПоследняяВерсия", Новый Структура(ПоследняяВерсия)));	
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуДокумента(Команда)
	
	ТекущиеДанные = Элементы.ТаблицаСостояние.ТекущиеДанные;	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Попытка	
		Данные = _ПодготовитьФормыПодтверждениеПоСотруднику(ТекущиеДанные.Сотрудник, УникальныйИдентификатор);		
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();	
		Возврат;
	КонецПопытки;	
	
	Если Данные.Файлы.Количество() = 0 Тогда
		ПоказатьПредупреждение(,"Сформируйте форму документа, перед ее открытием."); 
	КонецЕсли;
	
	Для Каждого Элемент Из Данные.Файлы Цикл
		Если Прав(Элемент.Имя,3)= "csv" Тогда
			
			ДвоичныеДанные = ПолучитьИзВременногоХранилища(Элемент.Хранение);
			
			Текст  = ПолучитьСтрокуИзДвоичныхДанных(ДвоичныеДанные, КодировкаТекста.UTF8);			
			ТекДок = Новый ТекстовыйДокумент;			
			ТекДок.УстановитьТекст(Текст);
			
			ТекДок.Показать(Элемент.Имя); 
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура _СохранитьПодписи(Результат, ДопПараметры = Неопределено) Экспорт

	// TODO Обработка результатов подписания
	
	ТекстСостояния = "Сохраняем подписи";
	
	Сч = 0;
	Всего = ТаблицаСостояние.Количество();
	Для Каждого Строка Из ТаблицаСостояние Цикл		
		
		Попытка	
			Данные = _СохранитьПодписьНаСервере(Строка.Сотрудник, Неопределено);		
			ЗаполнитьЗначенияСвойств(Строка, Данные);			
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();	
			Строка.Состояние = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
			Продолжить;
		КонецПопытки;
		
		Сч = Сч + 1;
		Прогресс = Окр((Сч / Всего) * 100);
		Состояние(ТекстСостояния, Прогресс);
		
	КонецЦикла;	
КонецПроцедуры

&НаСервереБезКонтекста
Функция _СохранитьПодписьНаСервере(Сотрудник, ДопПараметры) Экспорт
	
	// TODO Обработка результатов подписания
	
	ДД = ПолучитьДвоичныеДанныеИзСтроки("Привет мир");

	Возврат МИт.ПодписатьФорму(Сотрудник, ДД, ДопПараметры);  
	
КонецФункции

&НаСервере
Процедура _ОбновитьФормуНаСервере()

	СостояниеФормы = _СостояниеФормы();
    СостояниеФормы.РедактироватьФормы = Элементы.РедактироватьФормы.Пометка;
	СостояниеФормы.ЕстьОбновление = ПоследняяВерсия <> Неопределено;
	
	_ОбновитьФорму(ЭтаФорма, СостояниеФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура _ОбновитьФормуНаКлиенте()
	
	СостояниеФормы = _СостояниеФормы();
    СостояниеФормы.РедактироватьФормы = Элементы.РедактироватьФормы.Пометка;
	СостояниеФормы.ЕстьОбновление = ПоследняяВерсия <> Неопределено;
	
	_ОбновитьФорму(ЭтаФорма, СостояниеФормы);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура _ОбновитьФорму(Форма, СостояниеФормы)
	
	Если СостояниеФормы.ЕстьОбновление = Истина Тогда
		Форма.Элементы.ПанелиКнопок.ТекущаяСтраница = Форма.Элементы.ГруппаЕстьОбновление;	
	Иначе
		Форма.Элементы.ПанелиКнопок.ТекущаяСтраница = Форма.Элементы.ГруппаНет;	
	КонецЕсли;
	
	Форма.Элементы.ТаблицаСостояниеФорма.Видимость = СостояниеФормы.РедактироватьФормы;
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция _ДанныеСостояние(Сотрудник, ФизЛицо, Организация)

	Если ЗначениеЗаполнено(Сотрудник) Тогда
		Результат = МИт.ОписаниеПодтвержденияПоСотруднику(Сотрудник);	
	ИначеЕсли ЗначениеЗаполнено(ФизЛицо) Тогда
		Результат = МИт.ОписаниеПодтвержденияПоФизЛицу(ФизЛицо, Организация);	
	Иначе
		ВызватьИсключение "Ошибка";	
	КонецЕсли;
		
	Состояние = _СостояниеФормыПодтверждениеПоСотруднику(Сотрудник);
	Результат = МИтКС.Объединить(Результат, Состояние);
		
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция _СформироватьФормы(Сотрудник, ОписаниеПодтверждения) Экспорт
	
	МИт.ПодготовитьФорму(Сотрудник, ОписаниеПодтверждения, Неопределено);

	Возврат _СостояниеФормыПодтверждениеПоСотруднику(Сотрудник);	
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция _СостояниеФормы() Экспорт

	Модель = Новый Структура;
	Модель.Вставить("РедактироватьФормы", Ложь);	
    Модель.Вставить("ЕстьОбновление", Ложь);
	
	Возврат Модель;
	
КонецФункции

&НаСервереБезКонтекста
Функция _СостояниеФормыПодтверждениеПоСотруднику(Сотрудник) Экспорт

	Результат = Новый Структура;
	Результат.Вставить("Состояние", МИт.ЗначениеСвойства(Сотрудник, МИтКС.СвойствоСостояниеПодтверждения()));	
 	Результат.Вставить("Статус", МИт.ЗначениеСвойства(Сотрудник, МИтКС.СвойствоСтатусПодтверждения()));
	
	Возврат Результат;	
	
КонецФункции

&НаСервереБезКонтекста
Функция _ПодготовитьФормыПодтверждениеПоСотруднику(Сотрудник, УникальныйИдентификатор) Экспорт 
	
	Результат = _СостояниеФормыПодтверждениеПоСотруднику(Сотрудник); 
	Результат.Вставить("Файлы", Новый Массив);
		
    Хранилище = Обработки.МИтХранилище.Создать();
	
	ИмяФайла = СтрШаблон("%1 %2", Сотрудник.Код, Сотрудник.Наименование);	
	Документ = Хранилище.ФормаCsvПоСотруднику(Сотрудник);		
    Если Хранилище.КонтейнерЗаполнен(Документ) Тогда 
		Данные = Хранилище.ПолучитьЗначение(Документ);
		Адрес = ПоместитьВоВременноеХранилище(Данные, УникальныйИдентификатор);
		Файл = Новый ОписаниеПередаваемогоФайла(ИмяФайла + ".csv", Адрес);
		Результат.Файлы.Добавить(Файл);
	Иначе
		Возврат Результат; 
	КонецЕсли;

  	Подпись = Хранилище.ПодписьCsvПоСотруднику(Сотрудник);
	Если Хранилище.КонтейнерЗаполнен(Подпись) Тогда 
		Данные = Хранилище.ПолучитьЗначение(Подпись);
		Адрес = ПоместитьВоВременноеХранилище(Данные, УникальныйИдентификатор);
		Файл = Новый ОписаниеПередаваемогоФайла(ИмяФайла + ".csv.sig", Адрес);
		Результат.Файлы.Добавить(Файл)
	КонецЕсли;	

	Возврат Результат; 
	
КонецФункции

&НаСервереБезКонтекста
Функция _ОтправитьФайлыСотруднику(Сотрудник, УникальныйИдентификатор) Экспорт

	Результат = _ПодготовитьФормыПодтверждениеПоСотруднику(Сотрудник, УникальныйИдентификатор);	
	Если НЕ Результат.Файлы.Количество() = 2 Тогда
		Возврат Результат;	
	КонецЕсли;
	
	Попытка
		
		НачатьТранзакцию();	
		
		ОтборКИ = УправлениеКонтактнойИнформацией.ОтборКонтактнойИнформации();
		ОтборКИ.ТипыКонтактнойИнформации = Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты;
		
		КИ = УправлениеКонтактнойИнформацией.КонтактнаяИнформация(Сотрудник.ФизическоеЛицо, ОтборКИ); 
		Если НЕ КИ.Количество() Тогда
			Возврат Результат;	
		КонецЕсли;
		
		Ящик = РаботаСПочтовымиСообщениями.СистемнаяУчетнаяЗапись();
		
		Письмо = Новый ИнтернетПочтовоеСообщение;	
		Для Каждого Элемент Из КИ Цикл
			Письмо.Получатели.Добавить(УправлениеКонтактнойИнформацией.АдресЭлектроннойПочты(КИ[0].Значение));	
		КонецЦикла;	
		Письмо.Отправитель = Ящик.АдресЭлектроннойПочты; 
		Письмо.Тема = "Подтверждение заявления на предоставление отсрочки от мобилизации";
		Письмо.Тексты.Добавить("см. вложения", ТипТекстаПочтовогоСообщения.ПростойТекст);	
		Для Каждого Элемент Из Результат.Файлы Цикл
			Письмо.Вложения.Добавить(ПолучитьИзВременногоХранилища(Элемент.Хранение), Элемент.Имя);	
		КонецЦикла;		
		
		РаботаСПочтовымиСообщениями.ОтправитьПисьмо(Ящик, Письмо);
		
		Результат = МИт.УстановитьСтатусОтправлен(Сотрудник);
		
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;	
	КонецПопытки;
		
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура _ПроверитьОбнолвениеНаКлиенте() Экспорт

	Попытка
		ПоследняяВерсия = Новый ФиксированнаяСтруктура(_ПроверитьОбнолвениеНаСервере());	
	Исключение
		ПоследняяВерсия = Неопределено;
		Возврат;	
	КонецПопытки;

	_ОбновитьФормуНаКлиенте();
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция _ПроверитьОбнолвениеНаСервере() Экспорт

	Возврат Обработки.МИтОбслуживание.Создать().Обновление();	
	
КонецФункции

#КонецОбласти // СлужебныеПроцедурыИФункции
