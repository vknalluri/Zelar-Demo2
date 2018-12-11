import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { UserService } from '../../services/user.service';
import { Router } from '@angular/router';
@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css', '../../app.component.css']
})
export class UsersComponent implements OnInit {
  users: any = null;
  constructor(
    private authService:AuthService, 
    private router:Router,
    private userService:UserService
  ) { }

  ngOnInit() {
    this.getUsersList();
  }

  getUsersList(){
    this.userService.getUsers().subscribe(
      res => {
        this.users = res;
      },
      e => {
        console.log(e)  
      }
    );
  }

}
