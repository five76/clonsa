Agent monitoring
===================

Операционный пакет Google Cloud предоставляет следующие агенты для сбора показателей на экземплярах виртуальных машин Linux и Windows.

**Агент Ops**: основной и предпочтительный агент для сбора телеметрии с экземпляров вашего вычислительного ядра. Этот агент объединяет ведение журнала и показатели в единый агент, предоставляя конфигурации на основе YAML для сбора ваших журналов и показателей, а также обеспечивает ведение журнала с высокой пропускной способностью.
**Устаревший агент мониторинга**: собирает системные и прикладные показатели с экземпляров виртуальных машин и отправляет их в Облачный мониторинг. По умолчанию устаревший агент мониторинга собирает показатели диска, процессора, сети и процесса. Вы можете настроить агента для мониторинга сторонних приложений, чтобы получить полный список показателей агента.

Ops Agent
~~~~~~~~~~~~

Агент Ops является основным агентом для сбора телеметрии с экземпляров Compute Engine. Объединяя ведение журнала и метрики в одном агенте, агент Ops использует для журналов Fluent Bit, который поддерживает ведение журнала с высокой пропускной способностью, и сборщик OpenTelemetry для метрик.

Настройка агент Ops для поддержки анализа файлов журналов из сторонних приложений.
https://cloud.google.com/monitoring/agent/ops-agent/configuration#logging-config


Установка агента Ops: https://cloud.google.com/monitoring/agent/ops-agent/install-index

Особенности агента Ops
"""""""""""""""""""""""""""

Общие характеристики:

* Один процесс загрузки и установки / обновления.
* Простая, унифицированная конфигурация на основе YAML.
* Поддержка стандартных дистрибутивов Linux и Windows.

Функции ведения журнала включают в себя:

* Стандартные системные журналы (/var/журнал/системный журнал и /var/журнал/сообщения для Linux, журнал событий Windows), собранные без настройки.
* Высокая пропускная способность, в полной мере использующая преимущества многоядерной архитектуры.
* Эффективное управление ресурсами (например, памятью, процессором).
* Пользовательские файлы журналов.
* Журналы JSON.
* Журналы с простым текстом.
* Синтаксический анализ на основе регулярных выражений.
* Синтаксический анализ на основе JSON.

Агент Ops напрямую не поддерживает автоматический анализ журналов для сторонних приложений, но вы можете настроить агент Ops для анализа этих файлов. Дополнительные сведения см. в разделе Конфигурации ведения журнала.

Функции мониторинга включают в себя:

* Системные показатели, собранные без настройки.

* Собранные показатели включают:
- показатели процессора
- показатели диска
- показатели iis (только для Windows)
- показатели интерфейса
- показатели памяти
- показатели mssql (только для Windows)
- показатели файлов подкачки (только для Windows)
- показатели обмена
- сетевые показатели
- показатели процессов

Более подробно: https://cloud.google.com/monitoring/agent/ops-agent

Использование показателей процесса
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


По умолчанию агент Ops и устаревший агент мониторинга настроены для сбора показателей, которые собирают информацию о процессах, запущенных на виртуальных машинах (виртуальных машинах) вычислительного ядра. Вы также можете собирать эти показатели на виртуальных машинах Amazon Elastic Compute Cloud (EC2) с помощью агента мониторинга. Этот набор показателей, называемый показателями процесса, идентифицируется по префиксу agent.googleapis.com/processes . Эти показатели не собираются в Google Kubernetes Engine (GKE).

С 6 августа 2021 года для этих показателей будет введена плата, как описано в разделе Платные показатели. Набор показателей процесса классифицируется как платный, но плата никогда не взималась.

В этом документе описываются инструменты для визуализации показателей процесса, как определить объем данных, которые вы получаете из этих показателей, и как минимизировать связанные с этим расходы.

Настройка оповещений
~~~~~~~~~~~~~~~~~~~~~~~~

Оповещение своевременно информирует о проблемах в ваших облачных приложениях, чтобы вы могли быстро их решить.

В облачном мониторинге политика оповещения описывает обстоятельства, при которых вы хотите получать оповещения, и способ получения уведомлений.

Политики оповещения, используемые для отслеживания данных показателей, собранных с помощью облачного мониторинга, называются политиками оповещения на основе показателей. В большинстве документации по облачному мониторингу о политиках оповещения предполагается, что вы используете политики оповещения на основе показателей

Если вы создадите политику предупреждений, то сможете получать уведомления, когда один временной ряд удовлетворяет определенному условию или когда этому условию удовлетворяют несколько временных рядов. Политики оповещения могут быть простыми или сложными — например:

Уведомить, если какая-либо проверка работоспособности домена example.com сбой длится не менее 3 минут.

Сообщите дежурной группе, если 90% ответов HTTP 200 от 3 или более веб-серверов в 2 разных местоположениях Google Cloud превышает задержку ответа в 100 мс, если на сервере менее 15 QPS.

Сообщите, если загрузка ЦП каких-либо экземпляров виртуальных машин в моем облачном проекте Google превышает пороговое значение 0,6. На следующем снимке экрана показана эта политика оповещения:

Политики оповещения можно создавать с помощью API облачного мониторинга и с помощью облачной консоли Google. В обоих случаях можно управлять своими политиками и просматривать их в облачной консоли Google с помощью страницы предупреждений.

**Условия** являются основным компонентом политики оповещения. Условие описывает потенциальную проблему с системой, за которой необходимо следить с помощью облачного мониторинга. Например, вы можете описать такие условия:

* Любая проверка работоспособности домена example.com терпит неудачу не менее трех минут.
* Свободное пространство любого отслеживаемого экземпляра виртуальной машины составляет менее 10%.

В политику оповещения можно включить несколько каналов уведомлений, описывающие, кого следует уведомлять, когда требуются действия. Облачный мониторинг поддерживает общие каналы уведомлений, а также облачные мобильные приложения и Pub / Sub. Полный список поддерживаемых каналов и сведения о настройке этих каналов см. в разделе Параметры уведомлений.

Например, вы можете настроить политику оповещения по электронной почте my-support-team@example.com и опубликовать слабое сообщение на канале #my-support-team.

Документация, которую вы хотите включить в уведомление. Поле документация поддерживает обычный текст, уценку и переменные.

Например, вы можете включить в свою политику оповещения следующую документацию:

::

	## HTTP latency responses

	This alert originated from the project ${project}, using
	the variable $${project}.

После настройки политики оповещения на основе показателей Мониторинг непрерывно отслеживает условия этой политики. Нельзя настроить условия, которые будут отслеживаться только в течение определенных периодов времени. Когда условия этой политики выполняются, то есть когда состояние ресурсов требует от вас принятия мер, Мониторинг создает **инцидент** и отправляет уведомление о создании инцидента. 

* Инцидент - это постоянная запись, в которой хранится информация о отслеживаемых ресурсах на момент выполнения условия. Когда условие перестает выполняться, инцидент автоматически закрывается.

Это уведомление содержит сводную информацию об инциденте, ссылку на страницу сведений о политике, чтобы вы могли расследовать инцидент, и любую указанную вами документацию.

Если инцидент открыт и Мониторинг определяет, что условия политики на основе показателей больше не выполняются, то Мониторинг автоматически закрывает инцидент и отправляет уведомление о закрытии.
Если выполняются условия политики оповещения, например, если каждая проверка работоспособности домена example.com сбой в течение трех минут, затем Облачный мониторинг открывает инцидент и выдает уведомления:

* Инцидент - это постоянная запись, в которой хранится информация о отслеживаемых ресурсах на момент выполнения условия. Когда условие перестает выполняться, инцидент автоматически закрывается. Вы можете просматривать все инциденты, открытые и закрытые, с помощью панели мониторинга предупреждений.

Создание политики оповещения:
""""""""""""""""""""""""""""""""

https://cloud.google.com/monitoring/alerts#types-of-policies

Управление политикой оповещения:
"""""""""""""""""""""""""""""""""""""

https://cloud.google.com/monitoring/alerts#types-of-policies


