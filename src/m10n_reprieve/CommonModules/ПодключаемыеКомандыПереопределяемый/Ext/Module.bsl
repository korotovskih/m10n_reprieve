&После ("ПриОпределенииВидовПодключаемыхКоманд")
Процедура МИтПриОпределенииВидовПодключаемыхКоманд(ВидыПодключаемыхКоманд)
	
	//
	
КонецПроцедуры

&После ("ПриОпределенииКомандПодключенныхКОбъекту")
Процедура МИтПриОпределенииКомандПодключенныхКОбъекту(НастройкиФормы, Источники, ПодключенныеОтчетыИОбработки, Команды)
	
	Типы = Новый Массив;
	Типы.Добавить(Тип("СправочникСсылка.Сотрудники"));
	
	ТипПараметра = Новый ОписаниеТипов(Типы);
	
	Команда = Команды.Добавить();
	Команда.Вид = "Печать";
	Команда.Идентификатор = "МИтПодготовкаПодтверждения";
	Команда.Представление = НСтр("ru = 'Подготовка подтверждения (m10n reprieve)'");
	Команда.Важность = "СмТакже";
	Команда.ОтображениеКнопки = ОтображениеКнопки.Текст;
	Команда.ТипПараметра = ТипПараметра;
	Команда.МножественныйВыбор = Истина;
	Команда.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаСотрудников";
	Команда.РежимЗаписи = "Записывать";
	Команда.Обработчик = "МИтКлиент.МИтПодготовкаПодтверждения";
	
КонецПроцедуры