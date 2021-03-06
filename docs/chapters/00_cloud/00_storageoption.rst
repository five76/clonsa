Варианты хранения
==================

Compute Engine предлагает несколько типов вариантов хранения для ваших экземпляров. Каждый из следующих вариантов хранения имеет уникальные ценовые и эксплуатационные характеристики:

* Zonal persistent disk:: Эффективное, надежное блочное хранилище.
* Regional persistent disk: Региональное блочное хранилище, реплицируемое в двух зонах.
* Local SSD: Высокопроизводительное, временное, локальное блочное хранилище.
* Cloud Storage buckets: Доступное хранилище объектов.
* Filestore: Высокопроизводительное хранилище файлов для пользователей Google Cloud.

.. note:: Наиболее распространенным решением является добавление постоянного диска в экземпляр.

По умолчанию каждый экземпляр Compute Engine имеет один загрузочный постоянный диск (PD), содержащий операционную систему. Если вашим приложениям требуется дополнительное место для хранения, вы можете добавить один или несколько дополнительных параметров хранения в свой экземпляр. 

Цены: https://cloud.google.com/compute/disks-image-pricing#disk

Постоянные диски
~~~~~~~~~~~~~~~~~

Постоянные диски - это надежные сетевые устройства хранения данных, к которым ваши экземпляры могут обращаться, как к физическим дискам на рабочем столе или сервере. Данные на каждом постоянном диске распределяются по нескольким физическим дискам. Compute Engine управляет физическими дисками и распределением данных, чтобы обеспечить избыточность и оптимальную производительность.

Постоянные диски расположены независимо от экземпляров виртуальной машины (ВМ), поэтому можно отсоединять или перемещать постоянные диски, чтобы сохранить данные даже после удаления экземпляров. Производительность постоянных дисков автоматически масштабируется в зависимости от размера, поэтому можно изменить размер существующих постоянных дисков или добавить дополнительные постоянные диски в экземпляр в соответствии с вашими требованиями к производительности и объему хранилища.

Типы дисков
""""""""""""""""

При настройке зонального или регионального постоянного диска можно выбрать один из следующих типов дисков.

* Стандартные постоянные диски (pd-стандарт) поддерживаются стандартными жесткими дисками (HDD).
* Сбалансированные постоянные диски (pd-сбалансированные) поддерживаются твердотельными накопителями (SSD). Они являются альтернативой твердотельным накопителям SSD, которые обеспечивают баланс производительности и стоимости.
* Постоянные диски SSD (pd-ssd) поддерживаются твердотельными накопителями (SSD).
* Экстремальные постоянные диски (pd-extreme) поддерживаются твердотельными накопителями (SSD). Благодаря неизменно высокой производительности как для рабочих нагрузок с произвольным доступом, так и для массовой пропускной способности, экстремальные постоянные диски предназначены для высокопроизводительных рабочих нагрузок баз данных. В отличие от других типов дисков, вы можете обеспечить желаемые операции ввода-вывода. Дополнительные сведения см. в разделе Экстремальные постоянные диски.

В облачной консоли, тип диска по умолчанию - pd-сбалансированный. Если диск создается с помощью инструмента **gcloud** или **API Compute Engine**, тип диска по умолчанию - pd-стандартный.

**Долговечность**

Долговечность диска представляет собой вероятность потери данных в год, используя набор предположений об аппаратных сбоях, вероятности катастрофических событий, методах изоляции и инженерных процессах в центрах обработки данных Google, а также внутренних кодировках, используемых каждым типом диска. Google также предпринимает множество шагов для снижения общепромышленного риска скрытого повреждения данных. Человеческая ошибка клиента Google Cloud, например, когда клиент случайно удаляет диск, выходит за рамки постоянной долговечности диска.

Существует очень небольшой риск потери данных с региональным постоянным диском из-за его внутренней кодировки и репликации данных. Региональные постоянные диски предоставляют в два раза больше реплик, чем зональные постоянные диски, причем их реплики распределены между двумя зонами в одном регионе, поэтому они обеспечивают высокую доступность и могут использоваться для аварийного восстановления, если весь центр обработки данных потерян и не может быть восстановлен (хотя этого никогда не случалось). Дополнительные реплики во второй зоне могут быть доступны немедленно, если основная зона становится недоступной во время длительного простоя.

.. note:: Долговечность не представляет собой соглашение об уровне обслуживания с финансовой поддержкой (SLA).

**Производительность**

Производительность постоянного диска предсказуема и линейно масштабируется с выделенной емкостью до тех пор, пока не будут достигнуты ограничения для выделенных VCPU экземпляра.

Стандартные постоянные диски эффективны и экономичны для обработки последовательных операций чтения/записи, но они не оптимизированы для обработки высоких скоростей случайных операций ввода-вывода в секунду (IOPS). Если вашим приложениям требуется высокая скорость случайных операций ввода-вывода, используйте SSD или экстремальные постоянные диски. Постоянные диски SSD предназначены для одноразрядных миллисекундных задержек. Наблюдаемая задержка зависит от конкретного приложения.

**Постоянное шифрование диска**

Compute Engine автоматически шифрует ваши данные, прежде чем они будут отправлены за пределы вашего экземпляра в постоянное дисковое хранилище. Каждый постоянный диск остается зашифрованным либо с помощью системных ключей, либо с помощью ключей, предоставленных клиентом. Google распределяет постоянные дисковые данные по нескольким физическим дискам способом, который пользователи не контролируют.

Когда вы удаляете постоянный диск, Google удаляет ключи шифрования, делая данные безвозвратными. Этот процесс необратим.

Если вы хотите управлять ключами шифрования, которые используются для шифрования ваших данных, создайте диски с собственными ключами шифрования.

**Ограничения**

Вы не можете подключить постоянный диск к экземпляру в другом проекте.

Вы можете подключить сбалансированный постоянный диск не более чем к 10 экземплярам виртуальных машин в режиме только для чтения.

Экземпляры с типами компьютеров с общим ядром ограничены максимум 16 постоянными дисками.

Для пользовательских типов компьютеров или предопределенных типов компьютеров с минимальным значением 1 vCPU можно подключить до 128 постоянных дисков.

Каждый постоянный диск может иметь размер до 64 ТБ, поэтому нет необходимости управлять массивами дисков для создания больших логических томов. Каждый экземпляр может присоединять только ограниченный объем общего постоянного дискового пространства и ограниченное количество отдельных постоянных дисков. Предопределенные типы компьютеров и пользовательские типы компьютеров имеют одинаковые ограничения на постоянный диск.

В большинстве экземпляров может быть подключено до 128 постоянных дисков и до 257 ТБ общего постоянного дискового пространства. Общее постоянное дисковое пространство для экземпляра включает размер загрузочного постоянного диска.

Типы компьютеров с общим ядром ограничены 16 постоянными дисками и общим объемом постоянного дискового пространства 3 ТБ.

Региональные постоянные диски
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Региональные постоянные диски обладают свойствами хранения, аналогичными зональным постоянным дискам. Однако региональные постоянные диски обеспечивают надежное хранение и репликацию данных между двумя зонами в одном регионе.

Если вы разрабатываете надежные системы или службы высокой доступности на Compute Engine, используйте региональные постоянные диски в сочетании с другими рекомендациями, такими как резервное копирование данных с помощью моментальных снимков. Региональные постоянные диски также предназначены для работы с региональными группами управляемых экземпляров.

Надежность
"""""""""""""""

Вычислительный механизм копирует данные вашего регионального постоянного диска в зоны, выбранные вами при создании дисков. Данные каждой реплики распределяются по нескольким физическим машинам в пределах зоны для обеспечения избыточности.

Подобно зональным постоянным дискам, вы можете создавать моментальные снимки постоянных дисков для защиты от потери данных из-за ошибки пользователя. Моментальные снимки являются инкрементными, и их создание занимает всего несколько минут, даже если вы снимаете диски, подключенные к запущенным экземплярам.

Ограничения
""""""""""""

* Нельзя использовать региональный постоянный диск с виртуальной машиной типа, оптимизированной для памяти, оптимизированной для вычислений или оптимизированной для ускорителя.
* Нельзя использовать региональные постоянные диски в качестве загрузочных дисков.
* Нельзя создать региональный постоянный диск из моментального снимка, но не из образа.
* Минимальный размер постоянного диска регионального стандарта составляет 200 ГБ.
* При изменении размера регионального постоянного диска можете только увеличить его размер.

Локальные твердотельные накопители
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Локальные твердотельные накопители физически подключены к серверу, на котором размещен экземпляр вашей виртуальной машины. Локальные твердотельные накопители имеют более высокую пропускную способность и меньшую задержку, чем стандартные постоянные диски или постоянные диски SSD. Данные, которые вы храните на локальном твердотельном накопителе, сохраняются только до тех пор, пока экземпляр не будет остановлен или удален. Размер каждого локального SSD-накопителя составляет 375 ГБ, но вы можете подключить не более 24 локальных разделов SSD общим объемом 9 ТБ на экземпляр.

.. warning:: Повышение производительности за счет локальных твердотельных накопителей требует определенных компромиссов в отношении доступности, долговечности и гибкости. Из-за этих компромиссов локальное хранилище SSD не реплицируется автоматически, и все данные на локальном SSD могут быть потеряны, если экземпляр завершится по какой-либо причине. Дополнительные сведения см. в разделе Локальное сохранение данных SSD.

Local SSD предназначены для обеспечения очень высоких операций ввода-вывода и низкой задержки. В отличие от постоянных дисков, вы должны самостоятельно управлять чередованием на локальных твердотельных накопителях.  

Производительность локального SSD зависит от выбранного интерфейса. Локальные твердотельные накопители доступны как через интерфейсы SCSI, так и через NVMe.






