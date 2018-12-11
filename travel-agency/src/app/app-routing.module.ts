import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UsersComponent } from './admin/users/users.component';
import { SignupComponent } from './registrations/signup/signup.component';

const routes: Routes = [
  { path: '', redirectTo: '/', pathMatch: 'full'}, //default route
  { path: '', component: SignupComponent },
  { path: 'admin', component: UsersComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { 
  
}
