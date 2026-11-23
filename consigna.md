# Viaje de Egresados – Bariloche 2026

**Parcial de práctica – Paradigma de Objetos**

Cinco años ahorrando con rifas, bonos contribución y la venta de pastelitos en los recreos para llegar a esto: siete noches en Bariloche, un micro de doble piso con el baño fuera de servicio desde Olavarría, y un coordinador que jura que "a las 3 todos en la habitación". La empresa de turismo maneja todo con una planilla que heredó del viaje de 2009, y cada año alguien termina pagando una excursión a la que nunca fue.

Nos pidieron modelar el viaje. La planilla se jubila; el coordinador, lamentablemente, no.

## Punto 1 – ¿Cuánto sale el cerro? (3 puntos)

Se necesita modelar las excursiones del viaje. Cada excursión debe poder calcular su **costo total**, expresado en miles de pesos. Las excursiones pueden estar a cargo de coordinadores, algunos de ellos ya leyendas de la temporada, como "el Rulo", "la Tía Coordi" o "Maxi Boliche".

- **Boliche:** es el costo base de la excursión, al que se le suman 20 mil si es noche temática, o 5 mil en caso contrario.
- **Excursión al Cerro Catedral:** tiene un costo base de 50 mil, los coordinadores que la acompañan siempre son los mismos, y se le suman 15 mil si van menos de 3 coordinadores ("hay que contratar seguridad extra").
- **Circuitos:** están formados por excursiones de cualquier tipo (incluso otros circuitos). Su costo total es el costo base + **el promedio** de los adicionales de las excursiones que lo componen.

## Punto 2 – ¿Te anotás? (4 puntos)

Los egresados se anotan en excursiones. De cada egresado conocemos cuánta plata tiene ahorrada y si sus padres firmaron la autorización. Para **anotarse en una excursión**, en primer lugar tiene que tener la autorización firmada, y además tiene que cumplir con su criterio de elección, que puede ser:

- **Ahorrador:** solo se anota en excursiones cuyo costo total no supere el 40% de su plata ahorrada.
- **Fiestero:** solo se anota en excursiones nocturnas. Los boliches siempre son nocturnos, el cerro nunca, y un circuito es nocturno si alguna de sus excursiones lo es.
- **Indeciso:** acepta y rechaza alternadamente cada excursión que le ofrecen.
- **Una combinación de criterios**, donde todos deben cumplirse para anotarse.

Al anotarse, el costo total de la excursión se descuenta de la plata ahorrada del egresado.

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y, en caso de no cumplir alguna regla, defina de qué manera debe responder. Cada egresado puede cambiar su criterio en cualquier momento, y queremos que sea fácil incorporar nuevos criterios, así como evitar repetir la misma idea una y otra vez.

## Punto 3 – Llueve en Bariloche (2 puntos)

- Nos interesa saber si un egresado **está seco**: esto ocurre si le queda menos plata ahorrada que el costo total de la excursión más barata en la que se anotó.
- Cada vez que **llueve en Bariloche**, todas las excursiones en las que está anotado un egresado aumentan su costo base en 5 mil, porque hay que reprogramarlas.

## Punto 4 – ¡El mejor viaje de mi vida! (3 puntos)

Queremos saber si un egresado **la está pasando bien**. Esto ocurre, en general, si se anotó en al menos 2 excursiones y además:

- **Juli** siempre la pasa bien, no tiene más condiciones.
- **Santi**, si alguna de sus excursiones es nocturna.
- **Cami**, si todavía le queda más de la mitad de la plata con la que arrancó el viaje.
- **El Colo**, si alguno de los coordinadores de sus excursiones es "el Rulo".

## Punto 5 – En teoría… (2 puntos)

Indicar un lugar de su solución donde utilizó:

- polimorfismo,
- herencia,
- composición.

Justificar por qué y qué ventajas le dio. Además, explicar por qué modeló la excursión al Cerro Catedral y el criterio indeciso de la forma en que lo hizo (objeto bien conocido o clase).

---

**14 puntos:** 10 · **13 o 12:** 9 · **11:** 8 · **10:** 7 · **9 u 8:** 6 · **7:** 4 · **6:** 3 · **menos de 6:** 2
