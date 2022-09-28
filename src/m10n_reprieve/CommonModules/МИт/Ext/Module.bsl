﻿#Область ПрограммныйИнтерфейс

Функция УстановитьСтатусОтправлен(Объект) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Состояние", "Документ отправлен сотруднику");	
 	Результат.Вставить("Статус", МИтКС.СтатусыПодтверждения().Отправлено);
	
	НачатьТранзакцию();
	
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСтатусПодтверждения(), Результат.Статус); 
  	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСостояниеПодтверждения(), Результат.Состояние);
	
	ЗафиксироватьТранзакцию();
	
	Возврат Результат;
	
КонецФункции

Функция ПодготовитьФорму(Объект, ОписаниеПодтверждения, ДопПараметры) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Состояние", "Подпишите документ");	
 	Результат.Вставить("Статус", МИтКС.СтатусыПодтверждения().Создан);	
	
	Строка = Обработки.МИтПодтверждение.Создать().КакCSV(ОписаниеПодтверждения, Неопределено);
	Данные = ПолучитьДвоичныеДанныеИзСтроки(Строка, КодировкаТекста.UTF8, Истина); // Образц был с БОМ
	
	КонтейнерФормы = Обработки.МИтХранилище.Создать().СоздатьКонтейнерФормыCSV(Данные); 
	КонтейнерПодписи = Обработки.МИтХранилище.Создать().СоздатьКонтейнерПодписиФормыCSV(Base64Значение("")); 	
	
	НачатьТранзакцию();
	
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоДанныеПодтвержденияCSV(), КонтейнерФормы); 
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоДанныеПодписиПодтвержденияCSV(), КонтейнерПодписи);
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСтатусПодтверждения(), Результат.Статус); 
  	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСостояниеПодтверждения(), Результат.Состояние);
	
	ЗафиксироватьТранзакцию();

	Возврат Результат; 
	
КонецФункции

Функция ПодписатьФорму(Объект, ДанныеПодписи, ДопПараметры) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Состояние", "Отправьте документ");	
 	Результат.Вставить("Статус", МИтКС.СтатусыПодтверждения().Подписан);	
	
	КонтейнерПодписи = Обработки.МИтХранилище.Создать().СоздатьКонтейнерПодписиФормыCSV(ДанныеПодписи); 	
	
	НачатьТранзакцию();
	
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоДанныеПодписиПодтвержденияCSV(), КонтейнерПодписи);
	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСтатусПодтверждения(), Результат.Статус); 
  	МИт.ЗаписатьЗначениеСвойства(Объект, МИтКС.СвойствоСостояниеПодтверждения(), Результат.Состояние);
	
	ЗафиксироватьТранзакцию();

	Возврат Результат; 
	
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