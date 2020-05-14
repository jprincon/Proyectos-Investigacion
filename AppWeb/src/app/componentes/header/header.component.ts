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
    this.transferencia.obtenerMuestraUsuario.subscribe((rMuestraUsuario: boolean) => {
      this.mostrarUsuario = rMuestraUsuario;
    });

    this.transferencia.obtenerPermisoAdministrador.subscribe((rEsAdministrador: boolean) => {
      this.esAdministrador = rEsAdministrador;
    });

    this.transferencia.obtenerNombreUsuario.subscribe((rNombreUsuario: string) => {
      this.nombreUsuario = rNombreUsuario;
    });
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

    this.transferencia.enviarMuestraUsuario(false);
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
