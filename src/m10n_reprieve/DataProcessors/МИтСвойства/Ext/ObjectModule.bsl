#Область ОписаниеПеременных

// Служебные
Перем
Инициализация Экспорт;

// Служебные
Перем
_Объект Экспорт,
_МетаданныеХранилища Экспорт,
_МенеджерХранилища Экспорт,
_МетаданныеСвойств Экспорт,
_МенеджерНаборов Экспорт,
_МенеджерСвойств Экспорт;

#КонецОБласти

#Область ПрограммныйИнтерфейс

Функция Инициализировать(КоллекцияСвойств) Экспорт
	
	Инициализация = Истина;
	
	Если ТипЗнч(КоллекцияСвойств) = Тип("Массив") Тогда
		_ИнициализироватьПоМассиву(КоллекцияСвойств);
	Иначе
		_ИнициализироватьПоМенеджеру(КоллекцияСвойств);
	КонецЕсли;
	
	Инициализация = Ложь;
	
	Возврат ЭтотОбъект;
	
КонецФункции

Функция УстановитьОбъект(Объект) Экспорт
	
	_Объект = Объект;
	Возврат ЭтотОбъект;
	
КонецФункции

Функция Записать(Свойство, Значение) Экспорт
	
	Если _МетаданныеХранилища.Измерения.Свойство.Тип.СодержитТип(ТипЗнч(Свойство)) Тогда
		_Свойство = Свойство;
	Иначе
		_Свойство = Свойство(Свойство);
	КонецЕсли;
	
	_Записать(_Свойство, Значение);
	
	Возврат ЭтотОбъект;
	
КонецФункции

Функция Удалить(Свойство) Экспорт
	
	Если _МетаданныеХранилища.Измерения.Свойство.Тип.СодержитТип(ТипЗнч(Свойство)) Тогда
		_Свойство = Свойство;
	Иначе
		_Свойство = Свойство(Свойство);
	КонецЕсли;
	
	Возврат _Удалить(_Свойство);
	
КонецФункции

Функция Свойство(Свойство) Экспорт
	
	Если ТипЗнч(Свойство) = Тип("Строка") Тогда
		
		ДанныеЗаполнения = _ДанныеЗаполненияСвойства();
		ДанныеЗаполнения.Идентификатор = СокрЛП(Свойство);
		ДанныеЗаполнения.Наименование = ДанныеЗаполнения.Идентификатор;
		
	ИначеЕсли _ЭтоОпредление(Свойство) Тогда
		
		ДанныеЗаполнения = _ДанныеЗаполненияСвойства();
		ДанныеЗаполнения.Идентификатор = Свойство.Идентификатор;
		ДанныеЗаполнения.Наименование = Свойство.Наименование;
		ДанныеЗаполнения.ТипЗначения = Свойство.ТипЗначения;
		ДанныеЗаполнения.Наборы = Свойство.Наборы;
		
	ИначеЕсли _ЭтоПеречисление(Свойство) Тогда
		
		ОписаниеЗначения = _ОписаниеЗначенияПеречисления(Свойство);
		ДанныеЗаполнения = _ДанныеЗаполненияСвойства();
		ДанныеЗаполнения.Идентификатор = ОписаниеЗначения.ИмяПеречисления + ОписаниеЗначения.Имя;
		ДанныеЗаполнения.Наименование = ОписаниеЗначения.Синоним;
		ДанныеЗаполнения.Комментарий = ОписаниеЗначения.Комментарий;
		ДанныеЗаполнения.ТипЗначения = ОписаниеЗначения.ТипЗначения;
		
	Иначе
		ВызватьИсключение "Ошибка значения: " + Строка(Свойство);
	КонецЕсли;
	
	Возврат _Свойство(ДанныеЗаполнения);
	
КонецФункции

Функция Значение(Свойство) Экспорт
	
	Если _МетаданныеХранилища.Измерения.Свойство.Тип.СодержитТип(ТипЗнч(Свойство)) Тогда
		_Свойство = Свойство;
	Иначе
		_Свойство = Свойство(Свойство);
	КонецЕсли;
	
	Возврат _Значение(_Свойство);
	
КонецФункции

Функция НайтиОбъект(Свойство, Значение, ТипОбъекта = Неопределено) Экспорт
	
	Если _МетаданныеХранилища.Измерения.Свойство.Тип.СодержитТип(ТипЗнч(Свойство)) Тогда
		_Свойство = Свойство;
	Иначе
		_Свойство = Свойство(Свойство);
	КонецЕсли;
	
	Возврат _НайтиОбъект(_Свойство, Значение, ТипОбъекта);
	
КонецФункции

Функция ВыбратьОбъект(Свойство, Значение, ТипОбъекта = Неопределено) Экспорт
	
	Если _МетаданныеХранилища.Измерения.Свойство.Тип.СодержитТип(ТипЗнч(Свойство)) Тогда
		_Свойство = Свойство;
	Иначе
		_Свойство = Свойство(Свойство);
	КонецЕсли;
	
	Возврат _ВыбратьОбъект(_Свойство, Значение, ТипОбъекта);
	
КонецФункции

#КонецОБласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура _Записать(Свойство, Значение)
	
	Запись = _МенеджерХранилища.СоздатьМенеджерЗаписи();
	Запись.Объект = _Объект.Ссылка;
	Запись.Свойство = Свойство.Ссылка;
	
	ПростойТип = Запись.Свойство.ТипЗначения.СодержитТип(Тип("Строка"))
		ИЛИ Запись.Свойство.ТипЗначения.СодержитТип(Тип("Число"))
		ИЛИ Запись.Свойство.ТипЗначения.СодержитТип(Тип("Булево"));
	
	Если ПростойТип Тогда
		Запись.Значение = Запись.Свойство.ТипЗначения.ПривестиЗначение(Значение);
	Иначе
		Запись.Значение = Значение;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Запись.Объект) Тогда
		ВызватьИсключение "Ошибка заполнения: Объект";
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Запись.Свойство) Тогда
		ВызватьИсключение "Ошибка заполнения: Свойство";
	КонецЕсли;
	
	Запись.Записать();
	
КонецПроцедуры

Функция _Свойство(Отбор) Экспорт
	
	Выборка = _ВыбратьСвойства(Отбор);
	Если Выборка.Следующий() Тогда
		Ссылка = Выборка.Ссылка;
	Иначе
		Ссылка = Неопределено;
	КонецЕсли;
	
	Если Ссылка = Неопределено Тогда
		Свойство = _МенеджерСвойств.СоздатьЭлемент();
	ИначеЕсли Ссылка <> Неопределено И Инициализация = Истина Тогда
		Свойство = Ссылка.ПолучитьОбъект();
	Иначе
		Возврат Ссылка;
	КонецЕсли;
	
	Свойство.ЭтоДополнительноеСведение = Истина;
	Свойство.Имя = Отбор.Идентификатор;
	
	Если Свойство.Имя <> Отбор.Идентификатор Тогда
		ВызватьИсключение "Ошибка значения: " + Строка(Отбор.Идентификатор);
	КонецЕсли;
	
	Свойство.Наименование = Отбор.Наименование;
	Свойство.Заголовок = Отбор.Наименование;
	Свойство.ЗаголовокФормыЗначения = Свойство.Заголовок;
	Свойство.ЗаголовокФормыВыбораЗначения = Свойство.Заголовок;
	
	Свойство.Виден = Истина;
	Свойство.Подсказка = Отбор.Комментарий;
	Свойство.Комментарий = Отбор.Комментарий;
	Свойство.ТипЗначения = Отбор.ТипЗначения;
	Свойство.ИдентификаторДляФормул = Отбор.Идентификатор;
	Свойство.Записать();
	
	Если Отбор.Свойство("Наборы") Тогда
		Для Каждого Набор Из Отбор.Наборы Цикл
			Попытка	
				НаборСсылка = _НайтиНабор(Набор);
			Исключение
				НаборСсылка = Неопределено;
			КонецПопытки;
			Если ЗначениеЗаполнено(НаборСсылка) Тогда
				_ВключитьВНабор(НаборСсылка, Свойство.Ссылка);	
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Свойство.Ссылка;
	
КонецФункции

Функция _Значение(Свойство) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Объект", _Объект.Ссылка);
	Запрос.УстановитьПараметр("Свойство", Свойство.Ссылка);
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	ДополнительныеСведения.Объект КАК Объект,
		|	ДополнительныеСведения.Свойство КАК Свойство,
		|	ДополнительныеСведения.Значение КАК Значение
		|ИЗ
		|	РегистрСведений.ДополнительныеСведения КАК ДополнительныеСведения
		|ГДЕ
		|	ДополнительныеСведения.Объект = &Объект
		|	И ДополнительныеСведения.Свойство = &Свойство";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Значение;
	
КонецФункции

Функция _Удалить(Свойство) Экспорт
	
	Запись = _МенеджерХранилища.СоздатьМенеджерЗаписи();
	Запись.Объект = _Объект.Ссылка;
	Запись.Свойство = Свойство.Ссылка;
	
	Если НЕ ЗначениеЗаполнено(Запись.Объект) Тогда
		ВызватьИсключение "Ошибка заполнения: Объект";
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Запись.Свойство) Тогда
		ВызватьИсключение "Ошибка заполнения: Свойство";
	КонецЕсли;
	
	Запись.Удалить();
	
	Возврат ЭтотОбъект;
	
КонецФункции

Функция _НайтиОбъект(Свойство, Значение, ТипОбъекта) Экспорт
	
	Отбор = Новый Структура;
	Отбор.Вставить("Свойство", Свойство);
	Отбор.Вставить("Значение", Значение);
	Если ТипОбъекта <> Неопределено Тогда
		Отбор.Вставить("ТипОбъекта", ТипОбъекта);
	КонецЕсли;
	
	Выборка = _ВыбратьОбъекты(Отбор, 1);
	Если Выборка.Следующий() Тогда
		Объект = Выборка.Объект;
	Иначе
		Объект = Неопределено;
	КонецЕсли;
	
	Возврат Объект;
	
КонецФункции

Функция _ВыбратьОбъект(Свойство, Значение, ТипОбъекта) Экспорт
	
	Отбор = Новый Структура;
	Отбор.Вставить("Свойство", Свойство);
	Отбор.Вставить("Значение", Значение);
	Если ТипОбъекта <> Неопределено Тогда
		Отбор.Вставить("ТипОбъекта", ТипОбъекта);
	КонецЕсли;
	
	Возврат _ВыбратьОбъекты(Отбор);
	
КонецФункции

#КонецОБласти

#Область СлужебныеПроцедурыИФункции

Процедура _ИнициализироватьПоМенеджеру(Менеджер) Экспорт
	
	Для Сч = 0 По Менеджер.Количество() - 1 Цикл
		Значение = Менеджер.Получить(Сч);
		Свойство = Свойство(Значение);
		Для Каждого Набор Из Менеджер.Наборы(Значение) Цикл
			_ВключитьВНабор(Набор, Свойство);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

Процедура _ИнициализироватьПоМассиву(Массив) Экспорт
	
	Для Каждого Элемент Из Массив Цикл
		Свойство = Свойство(Элемент);
		Для Каждого Набор Из Элемент.Наборы Цикл
			Ссылка = _НайтиНабор(Набор);
			_ВключитьВНабор(Ссылка, Свойство);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

Процедура _ВключитьВНабор(Набор, Свойство) Экспорт
	
	Строка = Набор.ДополнительныеСведения.Найти(Свойство);
	Если Строка = Неопределено Тогда
		Объект = Набор.ПолучитьОбъект();
		Строка = Объект.ДополнительныеСведения.Добавить();
		Строка.Свойство = Свойство;
		Объект.Записать();
	КонецЕсли;
	
КонецПроцедуры

Функция _ЭтоПеречисление(Значение) Экспорт
	
	Попытка
		Результат = Значение.Метаданные() <> Неопределено;
	Исключение
		Результат = Ложь;
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

Функция _ЭтоОпредление(Значение) Экспорт
	
	Возврат ТипЗнч(Значение) = Тип("Структура")
		ИЛИ ТипЗнч(Значение) = Тип("ФиксированнаяСтруктура");
	
КонецФункции

Функция _ОписаниеЗначенияПеречисления(Значение) Экспорт
	
	МетаданныеПеречисления = Значение.Метаданные();
	МенеджерПеречисления = Перечисления[МетаданныеПеречисления.Имя];
	МетаданныеЗначения = МетаданныеПеречисления.ЗначенияПеречисления[МенеджерПеречисления.Индекс(Значение)];
	
	Результат = Новый Структура;
	Результат.Вставить("ИмяПеречисления", МетаданныеПеречисления.Имя);
	Результат.Вставить("Имя", МетаданныеЗначения.Имя);
	Результат.Вставить("Комментарий", МетаданныеЗначения.Комментарий);
	Результат.Вставить("Синоним", МетаданныеЗначения.Синоним);
	Результат.Вставить("ТипЗначения", МенеджерПеречисления.ТипЗначения(Значение));
	
	Возврат Результат;
	
КонецФункции

Функция _ДанныеЗаполненияСвойства() Экспорт
	
	Модель = Новый Структура;
	Модель.Вставить("Идентификатор");
	Модель.Вставить("Наименование");
	Модель.Вставить("Комментарий");
	Модель.Вставить("ТипЗначения");
	Модель.Вставить("Наборы");
	
	Возврат Модель;
	
КонецФункции

Функция _ВыбратьСвойства(Отбор) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Имя", Отбор.Идентификатор);
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДополнительныеРеквизитыИСведения.Ссылка КАК Ссылка
		|ИЗ
		|	ПланВидовХарактеристик.ДополнительныеРеквизитыИСведения КАК ДополнительныеРеквизитыИСведения
		|ГДЕ
		|	ДополнительныеРеквизитыИСведения.Имя = &Имя";
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

Функция _ВыбратьОбъекты(Отбор, Первые = Неопределено) Экспорт
	
	ТекстЗапроса =
		"ВЫБРАТЬ
		|	ДополнительныеСведения.Объект КАК Объект
		|ИЗ
		|	РегистрСведений.ДополнительныеСведения КАК ДополнительныеСведения
		|ГДЕ
		|	ДополнительныеСведения.Свойство = &Свойство
		|	И ДополнительныеСведения.Значение = &Значение
		|	И &УсловиеТип";
	
	Если Отбор.Свойство("ТипОбъекта") Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&УсловиеТип", "ДополнительныеСведения.Объект ССЫЛКА " + Отбор.ТипОбъекта);
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&УсловиеТип", "Истина");
	КонецЕсли;
	
	Если Первые <> Неопределено Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ВЫБРАТЬ", "ВЫБРАТЬ ПЕРВЫЕ " + Формат(Число(Первые), "ЧДЦ=0; ЧН=0; ЧГ=0"));
	КонецЕсли;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Свойство", Отбор.Свойство);
	Запрос.УстановитьПараметр("Значение", Отбор.Значение);
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

Функция _НайтиНабор(ИмяПредопределенногоНабора) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ИмяПредопределенногоНабора", ИмяПредопределенногоНабора);
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	НаборыДополнительныхРеквизитовИСведений.Ссылка КАК Ссылка,
		|	НаборыДополнительныхРеквизитовИСведений.ИмяПредопределенногоНабора КАК ИмяПредопределенногоНабора
		|ИЗ
		|	Справочник.НаборыДополнительныхРеквизитовИСведений КАК НаборыДополнительныхРеквизитовИСведений
		|ГДЕ
		|	НаборыДополнительныхРеквизитовИСведений.ПометкаУдаления = ЛОЖЬ
		|	И НаборыДополнительныхРеквизитовИСведений.ИмяПредопределенногоНабора = &ИмяПредопределенногоНабора";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат _НайтиПредопределенныйНабор(ИмяПредопределенногоНабора);
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Ссылка;
	
КонецФункции

Функция _НайтиПредопределенныйНабор(ИмяПредопределенногоНабора) Экспорт

    ИменаПредопределенных = Метаданные.Справочники.НаборыДополнительныхРеквизитовИСведений.ПолучитьИменаПредопределенных();
	Если ИменаПредопределенных.Найти(ИмяПредопределенногоНабора) = Неопределено Тогда
		Возврат Неопределено;	
	КонецЕсли;
	
	Результат = Справочники.НаборыДополнительныхРеквизитовИСведений[ИмяПредопределенногоНабора];	
	Возврат Результат;	
	
КонецФункции

#КонецОБласти

#Область Инициализация

Инициализация = Ложь;

_МетаданныеХранилища = Метаданные.РегистрыСведений.ДополнительныеСведения;
_МенеджерХранилища = РегистрыСведений.ДополнительныеСведения;

_МетаданныеСвойств = Метаданные.ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения;
_МенеджерСвойств = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения;
_МенеджерНаборов = Справочники.НаборыДополнительныхРеквизитовИСведений;

#КонецОБласти