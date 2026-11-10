// Consigna: https://docs.google.com/document/d/1VPKwf_cHcFTCj9JSYZ-xJmchX_n10bSJwxTUcmpd3w0/edit?usp=sharing

class Complejidad {
  method costoBase(tiempo) = tiempo * 25

  method costo(tarea) = self.costoBase(tarea.tiempo()) + self.costoExtra(tarea.tiempo())

  method costoExtra(tiempo)
}

object complejidadMinima inherits Complejidad {
  override method costoExtra(tiempo) = 0

  method diasAtraso(tarea) = 5
}

object complejidadMedia inherits Complejidad {
  override method costoExtra(tiempo) = 0.05 * self.costoBase(tiempo)

  method diasAtraso(tarea) = 1.1 * tarea.tiempo()
}

object complejidadMaxima inherits Complejidad {
  override method costoExtra(tiempo) = self.costoBase(tiempo) * 0.07 + self.costoADicionalPorRetraso(tiempo)

  method costoADicionalPorRetraso(tiempo) = 10 * 0.max(tiempo - 10)

  method diasAtraso(tarea) = tarea.tiempo() * 1.2 + 8
}

class Tarea {
  var property complejidad = complejidadMinima
  var property tiempo
  const impuestos = #{}

  method agregarImpuesto(impuesto) {
    impuestos.add(impuesto)
  }

  method cumplir()

  method costo() = self.costoComplejidad() + self.costoPorOverhead() + self.costoImpositivo()

  method costoComplejidad() = complejidad.costo(self)

  method costoPorOverhead()

  method costoImpositivo() {
    const costoBase = self.costoComplejidad()

    return impuestos.sum{impuesto => impuesto.calcularValor(costoBase)}
  }

  method diasAtraso() = complejidad.diasAtraso(self)
}

class TareaSimple inherits Tarea {
  var property porcentajeCumplimiento = 0

  override method costoPorOverhead() = 0

  override method cumplir() {
    porcentajeCumplimiento = 100
  }

  method costoTotal() = self.costo()
}

class TareaCompuesta inherits Tarea {
  const subtareas = []

  override method costoPorOverhead() = if(self.tieneMuchasSubtareas()) self.costoComplejidad() * 0.04 else 0

  override method cumplir() {
    throw new DomainException(message="Solo puede marcar como cumplida una tarea simple")
  }

  method agregarSubtarea(subtarea) {
    subtareas.add(subtarea)
  }

  method tieneMuchasSubtareas() = subtareas.size() > 3

  method costoTotal() = subtareas.sum{subtarea => subtarea.costoTotal()}

  method porcentajeCumplimiento() = subtareas.sum({subtarea => subtarea.porcentajeCumplimiento()}) / subtareas.size()
}

class Impuesto {
  const porcentajeDeAplicacion
  
  method calcularValor(costoTarea) = costoTarea * (porcentajeDeAplicacion / 100)
}

const impuestoA = new Impuesto(porcentajeDeAplicacion=3)
const impuestoB = new Impuesto(porcentajeDeAplicacion=5)

class Proyecto {
  const tareas = []

  method agregarTarea(tarea) {
    tareas.add(tarea)
  }

  method costoTotal() = tareas.sum({tarea => tarea.costoTotal()})

  method diasMaximosDeAtraso() = tareas.map({tarea => tarea.diasAtraso()}).maxIfEmpty({0})
}