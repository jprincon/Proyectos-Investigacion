import { MESES } from './../../config/constantes';
import { Component, OnInit } from '@angular/core';
import { DIAS_SEMANA } from '../../config/constantes';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styles: []
})
export class FooterComponent implements OnInit {

  Fecha: string;
  constructor() { }

  ngOnInit() {
    this.obtenerFechaHora();
  }

  obtenerFechaHora() {
    const fecha = new Date();
    this.Fecha = `${DIAS_SEMANA[fecha.getDay() - 1]} ${fecha.getDate()} de ${MESES[fecha.getMonth()]} del ${fecha.getFullYear()} © Julián Andrés Rincón Penagos`;
  }

}
