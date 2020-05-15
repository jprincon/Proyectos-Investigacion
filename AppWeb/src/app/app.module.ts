import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

// Angular Material
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import { MatDialogModule } from '@angular/material/dialog';
import {MatSnackBarModule} from '@angular/material/snack-bar';
import {MatCheckboxModule} from '@angular/material/checkbox';

// Graficos
import { ChartsModule } from 'ng2-charts';

import { AppComponent } from './app.component';
import { routingModule } from './app.router';


import { CapitalizadoPipe } from './Pipes/capitalizado.pipe';
import { DomSeguroPipe } from './Pipes/dom-seguro.pipe';
import { LongitudTextoPipe } from './Pipes/longitud-texto.pipe';
import { HeaderComponent } from './componentes/header/header.component';
import { FooterComponent } from './componentes/footer/footer.component';
import { NgDropFilesDirective } from './Directivas/ng-drop-files.directive';
import { InicioComponent } from './componentes/inicio/inicio.component';
import { RolComponent } from './administrador/rol/rol.component';
import { AdministradorComponent } from './administrador/administrador.component';
import { DlgRolComponent } from './administrador/rol/dlg-rol/dlg-rol.component';
import { SnackbarComponent } from './dialogos/snackbar/snackbar.component';
import { ConfirmacionComponent } from './dialogos/confirmacion/confirmacion.component';
import { UsuarioComponent } from './administrador/usuario/usuario.component';
import { DlgUsuarioComponent } from './administrador/usuario/dlg-usuario/dlg-usuario.component';
import { MenuPrincipalComponent } from './componentes/menu-principal/menu-principal.component';


@NgModule({
  declarations: [
    AppComponent,
    CapitalizadoPipe,
    DomSeguroPipe,
    LongitudTextoPipe,
    HeaderComponent,
    FooterComponent,
    NgDropFilesDirective,
    InicioComponent,
    RolComponent,
    AdministradorComponent,
    DlgRolComponent,
    SnackbarComponent,
    ConfirmacionComponent,
    UsuarioComponent,
    DlgUsuarioComponent,
    MenuPrincipalComponent
  ],
  imports: [
    BrowserModule,
    routingModule,
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    MatDialogModule,
    MatSnackBarModule,
    ChartsModule,
    MatCheckboxModule
  ],
  entryComponents: [
    DlgRolComponent,
    ConfirmacionComponent,
    SnackbarComponent,
    DlgUsuarioComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
