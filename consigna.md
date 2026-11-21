# Rock en el Conurbano – 2026

**Parcial de práctica – Paradigma de Objetos**

Todos los veranos pasa lo mismo: alguien alquila un predio en las afueras, anuncia un festival "histórico", vende 40.000 entradas para un lugar donde entran 15.000, y el día del show el baño químico más cercano está a dos kilómetros. Detrás de todo este circo hay productores que manejan presupuestos en servilletas y una planilla de Excel que nadie se anima a abrir porque "si la tocás, se rompe".

Nos pidieron reemplazar la planilla por un sistema. El predio sigue sin baños, pero por lo menos los números van a cerrar.

## Punto 1 – Probando, probando, sí, sí

Se necesita modelar los shows del festival. Cada show debe poder calcular su **costo de producción total**, expresado en miles de dólares. Los shows pueden tener técnicos de sonido asignados, algunos de ellos ya leyendas del ambiente, como "el Colo del sonido", "Pocho Ecualizador" o "Mirta Monitores".

- **Show acústico:** es el costo base del show, al que se le suman 3 mil dólares si es al aire libre, o 1 mil en caso contrario.
- **Show del escenario principal:** tiene un costo base de 20 mil dólares, los técnicos que trabajan ahí siempre son los mismos, y se le suman 4 mil dólares por cada técnico asignado, pero el sindicato fijó un tope: ese adicional nunca puede superar los 12 mil dólares.
- **Line-ups:** están formados por shows de cualquier tipo (incluso otros line-ups). Su costo es el costo base + la sumatoria de los adicionales de cada show que lo compone, con un 25% de descuento sobre esa sumatoria por contratarlos en paquete.

## Punto 2 – ¿Quién pone la plata?

Los productores contratan shows. De cada productor conocemos su presupuesto y los shows que tiene contratados. Para **contratar un show**, en primer lugar el productor tiene que tener presupuesto disponible (no se puede contratar nada con los bolsillos vacíos), y además:

- Los **independientes** solo contratan shows cuyo costo total no supere su presupuesto.
- Las **productoras multinacionales** solo contratan shows donde trabaje alguno de sus técnicos de confianza. Cada multinacional tiene los suyos.
- Los productores **en período de prueba** tienen que cumplir la regla del tipo de productor al que aspiran llegar (independiente o multinacional), y además no pueden tener más de 3 shows contratados.

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y, en caso de no cumplir alguna regla, defina de qué manera debe responder. Los productores pueden cambiar de categoría en cualquier momento. La solución debe ser flexible.

## Punto 3 – Llegó el dólar

- Nos interesa conocer los **shows que fundieron** a un productor: aquellos cuyo costo total supera los 40 mil dólares.
- Cada vez que hay un **salto del dólar**, todos los shows que tiene contratados un productor aumentan su costo base un 10%.

## Punto 4 – ¿Tenés fecha?

Las bandas envían pedidos de fecha a los productores. Cada pedido tiene el nombre de la banda, la fecha en que se hizo el pedido y la fecha solicitada para tocar. Cuando un productor recibe un pedido, lo agenda: a veces tal cual llegó, o de lo contrario le corre la fecha solicitada 1 mes para adelante ("esa fecha ya la tengo tomada, pibe").

- Los **independientes** solo agendan tal cual los pedidos que se hicieron con más de 60 días de anticipación respecto de la fecha solicitada.
- Las **productoras multinacionales** solo agendan tal cual los pedidos de bandas que trabajan con su sello discográfico. Cada multinacional tiene su propia lista de bandas.
- Los productores **en período de prueba** agendan tal cual según la regla del tipo de productor al que aspiran llegar.
