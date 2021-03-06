Взаимодействие с GCP
===========================================

Interacting with Google Cloud Platform 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  

Существует четыре способа взаимодействия с Google Cloud Platform: Консоль, SDK и Cloud Shell, Мобильное приложение и API. 

GCP Console представляет собой веб-интерфейс администрирования. Если создаеся приложение в GCP, будет использоваться  GCP Console. Это позволяет просматривать и управлять всеми вашими проектами и всеми ресурсами, которые они используют. Также позволяет включать, отключать и изучать API служб GCP. Предоставляет доступ к Cloud Shell. 

Это интерфейс командной строки для GCP, который легко доступен из браузера. Из Cloud Shell можно использовать инструменты, предоставляемые пакетом Google Cloud Development kit SDK, без необходимости сначала устанавливать их где-нибудь.

Cloud Shell
"""""""""""""""""""""""""""""""

Когда вы запускаете Cloud Shell, она предоставляет виртуальную машину Compute Engine, работающую под управлением операционной системы Linux на базе Debian. Экземпляры облачной оболочки подготавливаются для каждого пользователя и для каждого сеанса. Экземпляр сохраняется, пока активен сеанс облачной оболочки; после часа бездействия сеанс завершается, и его виртуальная машина удаляется. 

При использовании облачной оболочки по умолчанию предоставляется эфемерная предварительно настроенная виртуальная машина, а среда, с которой вы работаете, представляет собой контейнер Docker, запущенный на этой виртуальной машине. 

**Постоянное дисковое хранилище**

Облачная оболочка предоставляет 5 ГБ бесплатного постоянного дискового хранилища, подключенного в качестве вашего домашнего каталога $ на экземпляре виртуальной машины. Это хранилище предназначено для каждого пользователя и доступно в разных проектах. В отличие от самого экземпляра, это хранилище не истекает во время бездействия. Все файлы, которые вы храните в своем домашнем каталоге, включая установленное программное обеспечение, сценарии и файлы конфигурации пользователя, такие как .bashrc и .vimrc, сохраняются между сеансами. Ваш домашний каталог $ является личным для вас и не может быть доступен другим пользователям.

Облачная оболочка также предлагает эфемерный режим, который представляет собой облачную оболочку без постоянного дискового хранилища. В эфемерном режиме у вас будет более быстрое время запуска, но все файлы, которые вы создаете в сеансе, будут потеряны в конце сеанса.

.. node:: Если вы не обращаетесь к Cloud Shell регулярно, постоянное хранилище каталога $HOME может быть переработано. Вы получите уведомление по электронной почте до того, как это произойдет. Запуск сеанса облачной оболочки предотвратит его удаление.

**Авторизация**

Когда вы впервые вызываете Google Cloud API или используете средство командной строки, для которого требуются учетные данные (например, средство командной строки gcloud) с облачной оболочкой, Cloud Shell предложит вам открыть диалоговое окно "Авторизовать облачную оболочку". Нажмите кнопку Авторизоваться, чтобы разрешить инструменту использовать ваши учетные данные для совершения звонков.

**Предварительно настроенные переменные среды**

При запуске облачной оболочки активный проект в консоли передается в конфигурацию gcloud внутри облачной оболочки для немедленного использования. GOOGLE_CLOUD_PROJECT, переменная среды, используемая поддержкой библиотеки учетных данных приложения по умолчанию для определения идентификатора проекта, также указывает на активный проект в консоли.

**Выбор зоны**

Облачная оболочка глобально распределена по нескольким облачным регионам Google. При первом подключении к Cloud Shell вы будете автоматически назначены в ближайший доступный географический регион. Вы не можете выбрать свой собственный регион, и в случае, если Cloud Shell не выберет наиболее оптимальный регион, она попытается перенести вашу виртуальную машину Cloud Shell в более близкий регион, когда она не используется.

Чтобы просмотреть свой текущий регион, выполните следующую команду из сеанса облачной оболочки:

::

	curl metadata/computeMetadata/v1/instance/zone

.. figure:: 00_gcpnow.png
       :scale: 100 %
       :align: center
       :alt: asda

**Развертывание изображения**

Образ контейнера облачной оболочки обновляется еженедельно, чтобы обеспечить обновление готовых инструментов. Это означает, что Cloud Shell всегда поставляется с последними версиями Cloud SDK, Docker и всех других его утилит.

**Пользователь Root**

Когда вы настраиваете сеанс облачной оболочки, вы получаете обычную учетную запись пользователя Unix с именем пользователя, основанным на вашем адресе электронной почты. Благодаря этому доступу у вас есть полные права суперпользователя на выделенной виртуальной машине, и вы даже можете запускать команды sudo, если вам это необходимо.


Google Cloud SDK
""""""""""""""""""

Google Cloud SDK представляет собой набор инструментов, которые можно использовать для управления ресурсами и приложениями на GCP. К ним относится инструмент **gcloud**, который предоставляет основной интерфейс командной строки для продуктов и сервисов Google Cloud Platform. Интерфейс командной строки gcloud управляет аутентификацией, локальной конфигурацией, рабочим процессом разработчика, взаимодействием с облачными API Google. С помощью инструмента командной строки gcloud легко выполнять многие распространенные облачные задачи, такие как создание экземпляра виртуальной машины Compute Engine, управление кластером Google Kubernetes Engine и развертывание приложения App Engine либо из командной строки, либо в сценариях и других автоматизациях.

Существует также **gsutil**, который предназначен для облачного хранилища Google и **bq**, который предназначен для BigQuery. С помощью **kubectl** вы можете развертывать кластеры контейнеров Kubernetes и управлять ими с помощью командной строки.

Самый простой способ добраться до команд SDK - нажать на кнопку Cloud Shell на консоли GCP. Можно установить SDK на собственные компьютеры - ноутбук, локальные серверы виртуальных машин и другие облака. SDK также доступен в виде изображения докера.


Сервисы, которые предоставляет GCP, предлагают интерфейсы прикладного программирования (API). Эти API - это то, что называется RESTful. Ресурсы имен API и GCP имеют URL-адреса. Код может передавать информацию в API с помощью JSON, который является очень популярным способом передачи текстовой информации через Интернет. И есть открытая система для входа пользователя и контроля доступа. Консоль GCP позволяет включать и выключать API. Многие API отключены по умолчанию, и многие связаны с квотами и ограничениями. Эти ограничения помогают защитить проекты от непреднамеренного использования ресурсов. Можно включить только те API, которые нужны, и запрашивать увеличение квот, когда необходимо больше ресурсов. Например, если создается приложение, которое должно контролировать ресурсы GCP, то нужно будет правильно использовать API. И для этого надо использовать API Explorer. Консоль GCP включает инструмент под названием обозреватель API, который помогает интерактивно узнать об API. Он позволяет увидеть, какие API доступны и в каких версиях. Эти API ожидают параметры и имеют встроеннцю документацию. API можно использовать в интерактивном режиме даже при аутентификации пользователя. Нет необходимости выполнять программирование с нуля, так как Google предоставляет клиентские библиотеки, которые выполняют многие задачи вызова GCP из кода. 
 

Cloud Marketplace
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Это инструмент для быстрого развертывания функциональных пакетов программного обеспечения на Google Cloud Platform. Нет необходимости вручную настраивать программное обеспечение, экземпляры виртуальной машины, параметры хранилища или сети. Большинство пакетов программного обеспечения в Cloud Launcher не взимается дополнительная плата, сверх обычной платы за использование ресурсов GCP. При разворачивании ПО показывается оценка ежемесячных сборов, прежде чем сервис будет запущен. Но не все стоимости окончательные, в частности, они не оценивают затраты на сеть , поскольку они будут различаться в зависимости от того, как используются приложения. 

Вы можете выбрать и развернуть пакеты программного обеспечения на странице Cloud Marketplace облачной консоли. Cloud Marketplace предлагает множество различных продуктов, а в некоторых случаях предлагает несколько вариантов одного и того же продукта; например, Cloud Marketplace имеет несколько пакетов для WordPress. Чтобы убедиться, что продукт соответствует вашим потребностям, у каждого продукта есть страница сведений, описывающая тип виртуальной машины, операционную систему, предполагаемые затраты и многое другое.

Найдите пакет и выберите тот, который соответствует вашим бизнес-потребностям. При запуске развертывания вы можете либо использовать конфигурацию по умолчанию, либо настроить конфигурацию для использования большего количества виртуальных процессоров или ресурсов хранения. Некоторые пакеты позволяют указать количество экземпляров виртуальных машин для использования в кластере.

Для получения информации о покупке продуктов в Cloud Marketplace посетите раздел Общие сведения о выставлении счетов для Cloud Marketplace.

Инструкции по управлению выставлением счетов или отмене подписки см. в разделе Управление выставлением счетов для продуктов Cloud Marketplace.
Обновление пакета программного обеспечения

Чтобы устранить критические проблемы и уязвимости, Cloud Marketplace обновляет образы пакетов программного обеспечения, которые вы можете развернуть. 

.. attention:: Cloud Marketplace не обновляет развернутое программное обеспечение

Чтобы обновить существующий развернутый пакет программного обеспечения, необходимо повторно развернуть пакет программного обеспечения из Cloud Marketplace.













