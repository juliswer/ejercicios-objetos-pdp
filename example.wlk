class Noticia {
  const palabrasSensacionales = #{"espectacular","increible","grandioso"}
  const gradoDeImportancia
  const fechaDePublicacion
  const titulo
  const desarrollo

  method esCopada() = self.esImportante() and self.esReciente() and self.criterioParticularCopada()

  method criterioParticularCopada()

  method esImportante() = gradoDeImportancia >= 8

  method esSensacionalista() = palabrasSensacionales.any({palabra => titulo.contains(palabra)})

  method esEscueta() = desarrollo.words().size() < 100

  method leInteresaAlVago() = self.esEscueta()

  method comienzaCon(letra) = titulo.startsWith(letra)

  method estaBienEscrita() = titulo.words().size() >= 2 and self.tieneDesarrollo()

  method tieneDesarrollo() = not desarrollo.isEmpty()

  method esDeHoy() = fechaDePublicacion == new Date()

  method publicadaHace(dias) {
    const ahora = new Date()

    return (ahora - fechaDePublicacion) < dias
  }

  method fuePublicadaHaceUnaSemana() = self.publicadaHace(7)

  method esReciente() = self.publicadaHace(3)
}

class Comun inherits Noticia {
  const links = #{}

  method agregarLink(nuevoLink) {
    links.add(nuevoLink)
  }

  method cantidadLinks() = links.size()

  override method criterioParticularCopada() = self.cantidadLinks() >= 2
}

class Chivo inherits Noticia {
  const montoPagado

  override method criterioParticularCopada() = montoPagado > 2

  override method leInteresaAlVago() = true
}

class Reportaje inherits Noticia {
  const entrevistado

  override method criterioParticularCopada() = entrevistado.size().odd()

  override method esSensacionalista() = super() and entrevistado == "Dibu Martinez"
}

class Cobertura inherits Noticia {
  const noticiasRelacionadas = #{}

  method agregarNoticia(noticia) {
    noticiasRelacionadas.add(noticia)
  }

  override method criterioParticularCopada() = noticiasRelacionadas.all({noticia => noticia.esCopada()})
}

object agencia {
  const periodistas = #{}

  method agregarPeriodista(periodista) {
    periodistas.add(periodista)
  }

  method periodistasRecientesQuePublicaronUltimaSemana() = periodistas.filter({periodista => periodista.publicoAlgoLaUltimaSemana() and periodista.esReciente()})
}

class Periodista {
  const fechaDeIngreso
  const preferencia
  const noticiasPublicadas = #{}

  method publicoAlgoLaUltimaSemana() = noticiasPublicadas.any({noticia => noticia.fuePublicadaHaceUnaSemana()})

  method esReciente() = new Date() - fechaDeIngreso <= 365

  method publicarNoticia(noticia) {
    self.validarFormato(noticia)
    self.validarPreferencia(noticia)

    noticiasPublicadas.add(noticia)
  }

  method validarFormato(noticia) {
    if(not noticia.estaBienEscrita()) throw new DomainException(message="La noticia debe estar bien escrita para ser publicada")
  }

  method validarPreferencia(noticia) {
    if (not self.prefiere(noticia) and self.noPreferidasDeHoy() >= 2)
      throw new DomainException(message = "Ya publicó 2 noticias que no prefiere en el día")
  }

  method prefiere(noticia) = preferencia.quierePublicarNoticia(noticia)

  method noPreferidasDeHoy() =
    noticiasPublicadas.count({ noticia => noticia.esDeHoy() and not self.prefiere(noticia) })
}

object copado {
  method quierePublicarNoticia(noticia) = noticia.esCopada()
}

object sensacionalista {
  method quierePublicarNoticia(noticia) = noticia.esSensacionalista()
}

object vago {
  method quierePublicarNoticia(noticia) = noticia.leInteresaAlVago()
}

object joseDeZer {
  method quierePublicarNoticia(noticia) = noticia.comienzaCon("T")
}