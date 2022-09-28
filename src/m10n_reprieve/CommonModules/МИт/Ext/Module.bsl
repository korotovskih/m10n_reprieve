﻿#Область ПрограммныйИнтерфейс

Функция ПодготовитьФорму(Объект, ОписаниеПодтверждения, ДопПараметры) Экспорт

	Строка = Обработки.МИтПодтверждение.Создать().КакCSV(ОписаниеПодтверждения, Неопределено);
	Данные = ПолучитьДвоичныеДанныеИзСтроки(Строка, КодировкаТекста.UTF8, Истина); // Образц был с БОМ
	
	КонтейнерФормы = Обработки.МИтХранилище.Создать().СоздатьКонтейнерФормыCSV(Данные); 
	КонтейнерПодписи = Обработки.МИтХранилище.Создать().СоздатьКонтейнерПодписиФормыCSV(Base64Значение("")); 	
	
	НачатьТранзакцию();

	ПредставлениеСостояния = "Подпишите документ";
	
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоДанныеПодтвержденияCSV(), КонтейнерФормы); 
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоДанныеПодписиПодтвержденияCSV(), КонтейнерПодписи);
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСтатусПодтверждения(), МИтКС.СтатусыПодтверждения().Создан); 
  	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСостояниеПодтверждения(), ПредставлениеСостояния);
	
	ЗафиксироватьТранзакцию();
	
КонецФункции

// 

Функция ОписаниеПодтвержденияПоСотруднику(Сотрудник) Экспорт
	
	ОписаниеПодтверждения = МИтКС.ОписаниеПодтверждения();	
	
	Обработки.МИтХранилище.Создать().ЗаполнитьОписаниеПодтверждения(ОписаниеПодтверждения, Сотрудник, Неопределено); 

	Возврат ОписаниеПодтверждения;
	
КонецФункции

Функция ОписаниеПодтвержденияПоФизЛицу(ФизЛицо, Организация = Неопределено) Экспорт

	Сотрудник = Новый Структура;
	Сотрудник.Вставить("Ссылка", Неопределено); 
	Сотрудник.Вставить("ГоловнаяОрганизация", Организация); 
	Сотрудник.Вставить("ФизическоеЛицо", ФизЛицо); 
	
	ОписаниеПодтверждения = МИтКС.ОписаниеПодтверждения();	
	
	Обработки.МИтХранилище.Создать().ЗаполнитьОписаниеПодтверждения(ОписаниеПодтверждения, Сотрудник, Неопределено); 

	Возврат ОписаниеПодтверждения;
		
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Свойства

Процедура ЗаписатьЗначениеСвойства(Объект, Свойство, Значение) Экспорт
	
	Обработки.МИтСвойства.Создать().УстановитьОбъект(Объект).Записать(Свойство, Значение);	
	
КонецПроцедуры

Функция ЗначениеСвойства(Объект, Свойство) Экспорт
	
	Возврат Обработки.МИтСвойства.Создать().УстановитьОбъект(Объект).Значение(Свойство);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//

#КонецОбласти