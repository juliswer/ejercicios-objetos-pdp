# Sacá Número – 2026

Generado con Claude a partir del parcial de ejemplo "Operacion Transparencia" de 2025.

**Parcial de práctica – Paradigma de Objetos**

Si algo nos define como país es la capacidad de convertir cualquier gestión en una aventura épica. Llegás a las 7, sacás el número 348, van por el 12, y cuando por fin te toca te dicen que falta una fotocopia del DNI de tu abuela. El sistema que gestiona todo esto corre en una máquina que tiene un sticker de Windows XP y un post-it con la contraseña pegado en el monitor.

Nos pidieron modelar este laberinto burocrático. Nadie espera que funcione mejor, pero al menos va a estar documentado.

## Punto 1 – Vuelva mañana

Se necesita modelar los trámites que se gestionan en la repartición. Cada trámite debe poder calcular su **demora total**, expresada en días hábiles. Los trámites pueden ser evaluados por inspectores, algunos de ellos ya leyendas del edificio, como "la señora Norma del tercer piso", "el Tano Ferraro" o "Gutiérrez, el que nunca está".

- **Renovación de DNI:** es la demora base del trámite, a la que se le suman 5 días si en el medio hay un feriado largo, o 2 días en caso contrario.
- **Licencia de conducir:** tiene una demora base de 10 días, los inspectores que la evalúan siempre son los mismos, y se le suman 3 días por cada inspector asignado ("más gente mirando, más firmas que juntar").
- **Trámites combinados:** están formados por sub-trámites de cualquier tipo (incluso otros combinados). Como los sub-trámites se hacen en paralelo, la demora total es la demora base + **la mayor** de las demoras extra de sus sub-trámites.

## Punto 2 – Ese no es mi sector

Los empleados públicos toman trámites para atenderlos. De cada empleado conocemos los trámites que tiene en curso y su nivel de energía. Para **tomar un trámite**, en primer lugar el empleado tiene que tener energía (nadie atiende sin el primer mate), y además:

- Los de **ventanilla** solo toman trámites cuya demora total no supere su paciencia, que es distinta para cada empleado.
- Los **jefes de sección** solo toman trámites si tienen menos de 5 trámites en curso.

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y, en caso de no cumplir alguna regla, defina de qué manera debe responder. Los empleados pueden ascender o ser trasladados de puesto en cualquier momento. La solución debe ser flexible.

## Punto 3 – Paro y movilización

- Nos interesa conocer los **trámites cajoneados** de un empleado: aquellos cuya demora total supera los 30 días.
- Cada vez que hay **paro**, todos los trámites que tiene en curso un empleado aumentan su demora base en 2 días.

## Punto 4 – Libro de quejas

Los vecinos presentan reclamos. Cada reclamo tiene un texto, una fecha de ingreso y una fecha límite de respuesta. Cuando un empleado recibe un reclamo, lo archiva en su bandeja de pendientes: a veces tal cual llegó, o de lo contrario le extiende la fecha límite 6 meses ("eso lo tiene que ver otra área").

- Los de **ventanilla** solo archivan tal cual los reclamos cuyo texto contenga alguna de las palabras que les enseñaron en la última capacitación, como por ejemplo "urgente", "jubilado" o "discapacidad".
- Los **jefes de sección** solo archivan tal cual los reclamos que tengan más de 30 días entre la fecha de ingreso y la fecha límite.
