import { Routes, RouterModule } from '@angular/router';
import { InicioComponent } from './componentes/inicio/inicio.component';
import { AdministradorComponent } from './administrador/administrador.component';
import { AuthGuardService } from './Servicios/auth-guard.service';
import { RolComponent } from './administrador/rol/rol.component';
import { RUTA_ADMIN_ROL, RUTA_ADMIN_USUARIO, RUTA_ADMINISTRADOR, RUTA_INICIO, RUTA_MENU_PRINCIPAL } from './config/constantes';
import { UsuarioComponent } from './administrador/usuario/usuario.component';
import { MenuPrincipalComponent } from './componentes/menu-principal/menu-principal.component';

const routes: Routes = [
  { path: RUTA_INICIO, component: InicioComponent },

  { path: RUTA_MENU_PRINCIPAL, component: MenuPrincipalComponent },

  // %%%%%%% ADMINISTRADOR %%%%%%%
  { path: RUTA_ADMINISTRADOR,
    component: AdministradorComponent,
    canActivate: [AuthGuardService],
    children: [
      { path: RUTA_ADMIN_ROL, component: RolComponent },
      { path: RUTA_ADMIN_USUARIO, component: UsuarioComponent },
    ] },

  { path: '**', pathMatch: 'full', redirectTo: RUTA_INICIO }
];

export const routingModule = RouterModule.forRoot(routes, {useHash: true});
