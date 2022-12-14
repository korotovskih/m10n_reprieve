#Область ПрограммныйИнтерфейс

Процедура МИтПодготовкаПодтверждения(ПараметрКоманды, ПараметрыВыполненияКоманды) Экспорт
	
	ПараметрыПодготовки = Новый Структура;
	ПараметрыПодготовки.Вставить("Сотрудники", Новый Массив);
	ПараметрыПодготовки.Вставить("ФизическиеЛица", Новый Массив);
	
	Для Каждого Элемент Из ПараметрКоманды Цикл
		
		Если ТипЗнч(Элемент) = Тип("СправочникСсылка.Сотрудники") Тогда
			ПараметрыПодготовки.Сотрудники.Добавить(Элемент);
		ИначеЕсли ТипЗнч(Элемент) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
			ПараметрыПодготовки.ФизическиеЛица.Добавить(Элемент);
		Иначе
			Продолжить;
		КонецЕсли;
		
	КонецЦикла;
	
	ОткрытьФорму("Обработка.МИтПодготовкаПодтверждения.Форма.Форма", ПараметрыПодготовки);
	
КонецПроцедуры

Функция МИтПодписатьДвоичныеДанные(Данные, Сертификат, ОбработчикЗавершения) Экспорт
	
	ИмяФайла = "ОписаниеПодтверждения";
	
	ОписаниеДанных = Новый Структура;
	Если ТипЗнч(Данные) = Тип("ДвоичныеДанные") ИЛИ ТипЗнч(Данные) = Тип("Строка") Тогда
		ОписаниеДанных.Вставить("Данные", Данные);
		ОписаниеДанных.Вставить("СписокПредставлений", Новый СписокЗначений());
		ОписаниеДанных.СписокПредставлений.Добавить( , ИмяФайла);
	ИначеЕсли ТипЗнч(Данные) = Тип("Массив") Тогда
		ОписаниеДанных.Вставить("НаборДанных", Данные);
		ОписаниеДанных.Вставить("ПредставлениеНабора", "Описание подтверждения: " + Данные.Количество());
	Иначе
		ВызватьИсключение "Не предполагаемый тип параметра 1";
	КонецЕсли;
	
	ОписаниеДанных.Вставить("Операция", НСтр("ru = 'Подписание файла'"));
	ОписаниеДанных.Вставить("ЗаголовокДанных", НСтр("ru = 'Файл'"));
	ОписаниеДанных.Вставить("ОтборСертификатов", Новый Массив);
	ОписаниеДанных.Вставить("БезПодтверждения", Истина);
	ОписаниеДанных.Вставить("Представление", ИмяФайла);
	Если ЗначениеЗаполнено(Сертификат) Тогда
		ОписаниеДанных.ОтборСертификатов.Добавить(Сертификат);
	КонецЕсли;
	
	ЭлектроннаяПодписьКлиент.Подписать(ОписаниеДанных, , ОбработчикЗавершения);
	
КонецФункции

#КонецОбласти