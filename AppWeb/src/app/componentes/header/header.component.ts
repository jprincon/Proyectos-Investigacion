import { Component, OnInit } from '@angular/core';
import { TransferenciaService } from '../../Servicios/transferencia.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styles: []
})
export class HeaderComponent implements OnInit {

  nombreUsuario = '';
  mostrarUsuario = false;
  esAdministrador = false;

  constructor(private router: Router,
              private transferencia: TransferenciaService) { }

  ngOnInit() {

  }

  salir() {

    if (localStorage.getItem('Usuario')) {
      localStorage.removeItem('Usuario');
      this.router.navigate(['inicio']);
    }

    if (localStorage.getItem('Clave')) {
      localStorage.removeItem('Clave');
    }

    this.router.navigate(['inicio']);
  }

  irMenuPrincipal() {
    this.router.navigate(['menu-principal',]);
  }

  misAplicaciones() {
    this.router.navigate(['mis-aplicaciones']);
  }

  administrar() {
    this.router.navigate(['administrar']);
  }

  AbrirSaem() {
    this.router.navigate(['saem']);
  }

}
