# Operación Pelota Limpia – 2026

**Parcial de práctica – Paradigma de Objetos**

El fútbol argentino es una maravilla: tenemos el mejor producto del mundo (los pibes que salen de las inferiores) y una hinchada que es puro corazón, capaz de llenar una cancha un martes a las 21:30 con lluvia. El problema, claro está, es la gestión. Los clubes funcionan con un sistema heredado de los años 80, documentado en un cuaderno Gloria que guarda el utilero, y cada mercado de pases termina con plata que nadie sabe muy bien dónde fue a parar.

La comisión directiva jura que "los números cierran". Nosotros, por las dudas, vamos a modelarlo.

## Punto 1 – ¿Cuánto salió el pibe?

Se necesita modelar los pases de jugadores que firma el club. Cada pase debe poder calcular su **costo total** para la institución. Todo pase puede tener representantes que intervienen en la negociación, algunos de ellos muy conocidos en el ambiente, como "el Turco Mercadal", "Pepe Cláusulas" o "el Gordo Comisiones". Todo cálculo monetario está expresado en millones de dólares.

- **Pase de juvenil:** es el monto base del pase, al que se le suma medio millón si tiene cláusula de recompra, o 1 millón en caso contrario.
- **Venta de la joya del club:** tiene un monto base de 8 millones, los representantes que intervienen siempre son los mismos, y se le suman 2 millones si intervienen hasta dos representantes. Si intervienen más de dos no se adiciona nada, porque "entre todos se reparten la comisión".
- **Paquetes de pases:** están formados por sub-pases que pueden ser de cualquier tipo (incluso otros paquetes). El costo total es el monto base + la sumatoria de los montos extra de cada sub-pase.

## Punto 2 – La caja del club

El sistema también debe gestionar a los dirigentes. Cualquiera de ellos puede tener pases firmados, y conocemos cuánta plata tiene la caja que manejan. Para **firmar un pase**, en primer lugar la caja tiene que tener fondos (no se puede firmar nada con la caja vacía), y además:

- Los **presidentes** tienen que tener un representante amigo en el pase.
- Los **tesoreros** tienen que tener en caja más del 70% del costo total del pase.

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y, en caso de no cumplir alguna regla, defina de qué manera debe responder. Claramente los dirigentes pueden pasar de un cargo a otro en diferentes momentos. La solución debe ser flexible.

## Punto 3 – Se viene la asamblea

- Nos interesa conocer los **pases que hipotecaron al club** para un dirigente: aquellos cuyo costo total supera los 10 millones.
- Cada vez que hay una **devaluación**, todos los pases que firmó un dirigente aumentan su monto base en medio millón.

## Punto 4 – Elecciones en el club

Se acercan las elecciones y, como siempre, todos los dirigentes prometen estadio nuevo, refuerzos y la vuelta a la Libertadores. A la hora de escuchar una propuesta de los socios, el dirigente la transforma en una promesa. Las propuestas tienen una descripción, una fecha de presentación y una fecha en la que deberían cumplirse. A veces las aceptan como están, o de lo contrario las toman pero con fecha de cumplimiento 3 años adelante (cuando termina el mandato).

- Los **presidentes** solamente aceptan tal cual las propuestas que contengan en su descripción alguna de las palabras clave que les da su jefe de prensa, como por ejemplo "estadio", "refuerzos" o "cuota".
- Los **tesoreros** aceptan tal cual las propuestas cortas (tienen menos de 6 meses entre la fecha de presentación y la fecha de cumplimiento).
