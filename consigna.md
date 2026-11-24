# Operación Expensas – 2026

**Parcial de práctica – Paradigma de Objetos**

Vivir en un edificio porteño es una experiencia única: tenés un balcón con vista a otro balcón, un encargado que sabe más de tu vida que tu familia, y un grupo de WhatsApp de vecinos con 47 integrantes donde nadie lee los mensajes pero todos opinan. El problema, claro está, es la administración. Las expensas suben todos los meses, nadie entiende la liquidación, y cada vez que se rompe algo aparece una obra "urgentísima" que termina costando el triple.

El administrador jura que "está todo en la planilla". Por las dudas, nosotros vamos a modelarlo.

## Punto 1 – ¿Qué es este ítem en las expensas?

Se necesita modelar las obras que se hacen en el edificio. Cada obra debe poder calcular su **costo total** para el consorcio. Toda obra puede tener proveedores que trabajan en ella, algunos de ellos muy conocidos en el barrio, como "el plomero Ramón", "Cacho Electricidad" o "Doña Pintura". Todo cálculo monetario está expresado en millones de pesos.

- **Arreglo de cañerías:** es el monto base de la obra, al que se le suman 0,3 millones si es de urgencia, o 0,1 millones en caso contrario.
- **Arreglo del ascensor:** tiene un monto base de 5 millones, los proveedores que trabajan en él siempre son los mismos, y se le suma 1,5 millones si trabajan hasta dos proveedores. Si trabajan más de dos no se adiciona nada, porque "entre todos lo terminan rápido".
- **Obras integrales:** están formadas por sub-obras que pueden ser de cualquier tipo (incluso otras obras integrales). El costo total es el monto base + la sumatoria de los montos extra de cada sub-obra.

## Punto 2 – Aprobado por la asamblea

El sistema también debe gestionar a los administradores. Cualquiera de ellos puede tener obras aprobadas, y conocemos el fondo de reserva que manejan. Para **aprobar una obra**, en primer lugar tiene que haber fondo de reserva (no se puede aprobar nada con el fondo en cero), y además:

- Los **administradores tradicionales** tienen que tener un proveedor amigo trabajando en la obra.
- Los **administradores profesionales** tienen que tener un fondo de reserva mayor al 60% del costo total de la obra.

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y, en caso de no cumplir alguna regla, defina de qué manera debe responder. Claramente los administradores pueden cambiar de modalidad en diferentes momentos. La solución debe ser flexible.

## Punto 3 – Asamblea extraordinaria

- Nos interesa conocer las **obras escandalosas** de un administrador: aquellas cuyo costo total supera los 8 millones.
- Cada vez que hay una **suba de materiales**, todas las obras que aprobó un administrador aumentan su monto base en 0,2 millones.

## Punto 4 – El libro de actas

En cada asamblea los vecinos presentan reclamos, y el administrador los transforma en compromisos que (supuestamente) tiene que cumplir. Los reclamos tienen una descripción, una fecha de presentación y una fecha en la que deberían resolverse. A veces los acepta como están, o de lo contrario los toma pero con fecha de resolución 2 años adelante ("en la próxima asamblea lo vemos").

- Los **administradores tradicionales** solamente aceptan tal cual los reclamos que contengan en su descripción alguna de las palabras clave que les pasa su encargado, como por ejemplo "humedad", "ascensor" o "ruidos".
- Los **administradores profesionales** aceptan tal cual los reclamos cortos (tienen menos de 3 meses entre la fecha de presentación y la fecha de resolución).
