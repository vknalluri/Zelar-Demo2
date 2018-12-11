import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AngularTokenModule } from 'angular-token';

import { FormsModule } from '@angular/forms';
import { AuthService } from './services/auth.service';
import { AuthGuard } from './guards/auth.guard';
import { UsersComponent } from './admin/users/users.component';
import { SignupComponent } from './registrations/signup/signup.component';


@NgModule({
  declarations: [
    AppComponent,
    UsersComponent,
    SignupComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    AngularTokenModule.forRoot({
      //apiBase:                    'http://localhost:3000/api/v1',
      apiBase:                    'http://54.218.38.85:3000/api/v1',
      apiPath:                    'auth',

      signInPath:                 'sign_in',
      signInRedirect:             null,
      signInStoredUrlStorageKey:  null,

      signOutPath:                'sign_out',
      validateTokenPath:          'validate_token',
      signOutFailedValidate:      false,

      registerAccountPath:        '',
      deleteAccountPath:          'auth',
      registerAccountCallback:    window.location.href,

      updatePasswordPath:         '/',
      resetPasswordPath:          'password',
      resetPasswordCallback:      window.location.href,

      oAuthBase:                  window.location.origin,
      oAuthPaths: {
          github:                 'github'
      },
      oAuthCallbackPath:          'oauth_callback',
      oAuthWindowType:            'newWindow',
      oAuthWindowOptions:         null,
    }),
    HttpClientModule
  ],
  providers: [ AngularTokenModule, FormsModule, AuthService, AuthGuard],
  bootstrap: [AppComponent]
})
export class AppModule { }
