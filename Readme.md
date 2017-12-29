![Repository Logo](img/site-banner.png)
### Dockerized Sinatra / Mongoid App over Puma via Foreman

[![Build Status](https://travis-ci.org/patamimbre/sptorrent-api.svg?branch=master)](https://travis-ci.org/patamimbre/sptorrent-api)

#### Introducción 

La aplicación ha sido desarrollada según los conocimientos adquiridos en la asignatura **Infraestructura Virtual** impartida en la UGR. 

Su principal funcionamiento es buscar en la web enlaces torrent a series y películas.

Para su desarrollo, se han empleado distintas tecnologías:

* **Ruby** como lenguaje de programación.
* **Sinatra** como framework para la API.
* **Puma** como servidor web Rack.
* **MongoDB** como base de datos.
* **Mongoid** como framework ODM (Object-Document-Mapper).
* **Guard** para TDD
* **Foreman**
* **Travis CI y Rake** para integración continua.
* **Docker** y **Docker Compose**

### Uso

#### Uso básico
* Para correr la aplicación usa `docker-compose up`. 
* Accede a la aplicación en `0.0.0.0:5678`

#### Rutas para el uso de la aplicación
* `0.0.0.0:5678/status` devuelve el estado de la aplicación (JSON)
* `0.0.0.0:5678/search/<nombre>` busca series y películas
* `0.0.0.0:5678/search/<nombre>?json=yes` busca series y películas (Devuelve un JSON con las coincidencias)
* `0.0.0.0:5678/entry/<id>` muestra los enlaces de descarga
* `0.0.0.0:5678/entry/<id>?json=yes` muestra los enlaces de descarga (como JSON)
* `0.0.0.0:5678/all/` muestra la base de datos actual

#### Funcionamiento

La aplicación se nutre de [](http://www.divxtotal2.net). Cada vez que se realiza una búsqueda, la API busca directamente en esta web los resultados coincidentes y estos son almacenados en la base de datos local. 

Cada uno de los resultados es guardado con un *ID identificativo*. Cuando se accede a */entry/<ID>*, la aplicación busca los enlaces a la serie indicada y los muestra al usuario.

Los resultados son mostrados en una página web muy simple. Si se desean en *JSON* basta con añadir al final de la dirección web **?json=yes**.

#### Capturas de pantalla

*Búsqueda*

![](img/search.png)

*Búsqueda (como JSON)*

![](img/search_json.png)

*Entrada*

![](img/entry.png)

*Entrada (como JSON)*

![](img/entry_json.png)

### To Do

En la fecha actual, el programa es funcional, aunque quedan muchos apartados que mejorar e implementar.

* Las series que tienen como descarga temporadas completas en lugar de capitulos sueltos no son mostradas correctamente en el navegador, aunque si funcionan con JSON (un ejemplo es "friends")
* Algunas rutas muestran un error, deben ser redireccionadas a una página común
* Rediseño completo html y css
* Descargar todos los capítulos de una serie al completo en formato .zip
* Implementar integración continua
* Desplegar en Heroku
* Subir a DockerHub
* MUCHAS OTRAS

### INFO

No me hago responsable del mal uso de está aplicación. En ningún caso se almacenan archivos en la base de datos.

Made with ❤️ in Granada

