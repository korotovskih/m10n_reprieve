﻿#Область Тесты

&НаСервере
Процедура ЗаполнитьОписаниеПодтверждения() Экспорт
	
	ОписаниеПодтверждения = Вычислить("МИтКС").ОписаниеПодтверждения();	
	ДопПараметры = Неопределено;	
	ФизЛицо = Справочники.Сотрудники.НайтиПоКоду("0000-00030");
	
	Обработки.МИтТест.Хранилище().ЗаполнитьОписаниеПодтверждения(ОписаниеПодтверждения, ФизЛицо, ДопПараметры);
	
	Если ОписаниеПодтверждения.ОрганизацияИНН <> "9937548836" Тогда 
		ВызватьИсключение "Ошибка формирования: неверный ИНН организации";
	КонецЕсли;
	
	Если ОписаниеПодтверждения.СотрудникФИО <> "Бажова Светлана Нурисламовна" Тогда 
		ВызватьИсключение "Ошибка формирования: неверный ФМО объекта";
	КонецЕсли;
	
	Если ОписаниеПодтверждения.СотрудникСНИЛС <> "145-434-285 57" Тогда 
		ВызватьИсключение "Ошибка формирования: неверный СНИЛС сотрудника";
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПодписаниеДД() Экспорт
	
	Сертификат = _СертификатНаСервере();
	ДД = ПолучитьДвоичныеДанныеИзСтроки("Privet, mir!");  
	ДанныеПодписейФайла = Новый Массив;
	
	ОбработчикЗавершения = Новый ОписаниеОповещения("ПодписатьФайлЗавершение", ЭтотОбъект); 
	
	НаборДанных = Новый Массив;
	
	Для Сч = 0 По 10 Цикл     
		
		Набор = Новый Структура;
		Набор.Вставить("Данные", ДД);
		Набор.Вставить("ПараметрыCMS", ЭлектроннаяПодписьКлиент.ПараметрыCMS());
		НаборДанных.Добавить(Набор);
		
	КонецЦикла;
		
	МИтКлиентМодуль = Вычислить("МИтКлиент");
	МИтКлиентМодуль.МИтПодписатьДвоичныеДанные(НаборДанных, Сертификат, ОбработчикЗавершения);
	
КонецПроцедуры

#КонецОбласти 

#Область Служебные

Функция _СертификатНаСервере()
	
	Возврат Справочники.СертификатыКлючейЭлектроннойПодписиИШифрования.НайтиПоНаименованию("Платонов Егор, до 12.2023");
	
КонецФункции 

&НаКлиенте
Процедура ПодписатьФайлЗавершение(Результат, ДопПараметр) Экспорт

	Если Результат.Успех <> Истина Тогда
		ВызватьИсключение "Что то пошло не так";
	КонецЕсли;   
	
КонецПроцедуры

#КонецОбласти

