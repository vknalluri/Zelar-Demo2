import { TestBed, async, inject } from '@angular/core/testing';

import { AuthGuard } from './auth.guard';

import { BrowserDynamicTestingModule,
  platformBrowserDynamicTesting } from '@angular/platform-browser-dynamic/testing';


describe('AuthGuard', () => {
  

  afterEach(()=>{
    TestBed.resetTestEnvironment();
  });
  
  beforeEach(() => {
    TestBed.initTestEnvironment(BrowserDynamicTestingModule, platformBrowserDynamicTesting());
    TestBed.configureTestingModule({
      providers: [AuthGuard]
    });
  });

  it('should ...', inject([AuthGuard], (guard: AuthGuard) => {
    expect(guard).toBeTruthy();
  }));
});
