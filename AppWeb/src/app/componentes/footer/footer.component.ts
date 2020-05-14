import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styles: []
})
export class FooterComponent implements OnInit {

  Fecha: Date;
  constructor() { }

  ngOnInit() {
    this.obtenerFechaHora();
  }

  obtenerFechaHora() {
    this.Fecha = new Date();
  }

}
