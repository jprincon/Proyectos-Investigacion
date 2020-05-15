import { Component, OnInit } from '@angular/core';
import { ServiciosService } from '../Servicios/servicios.service';
import { RUTA_ADMINISTRADOR, RUTA_ADMIN_ROL, RUTA_ADMIN_USUARIO } from '../config/constantes';

@Component({
  selector: 'app-administrador',
  templateUrl: './administrador.component.html',
  styles: []
})
export class AdministradorComponent implements OnInit {

  titulo = 'Roles';

  menuAdministrador: any[] = [
    {
      titulo: 'Roles',
      icono: 'assets/Iconos/Rol.png',
      descripcion: 'Crea/Edita los Roles',
      ruta: RUTA_ADMIN_ROL
    },
    {
      titulo: 'Usuarios',
      icono: 'assets/Iconos/Usuario.png',
      descripcion: 'Crea/Edita los Usuarios',
      ruta: RUTA_ADMIN_USUARIO
    }
  ];

  constructor(private genService: ServiciosService) { }

  ngOnInit() {
  }

  buscarMenu(ruta: string, ss: string) {
    this.titulo = ss;
    this.genService.navegar([RUTA_ADMINISTRADOR, ruta]);
  }

}
