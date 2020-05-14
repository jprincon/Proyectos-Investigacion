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


@NgModule({
  declarations: [
    AppComponent,
    CapitalizadoPipe,
    DomSeguroPipe,
    LongitudTextoPipe,
    HeaderComponent,
    FooterComponent,
    NgDropFilesDirective,
    InicioComponent
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
  entryComponents: [],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
