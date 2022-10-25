import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MegjelenesIdopontonComponent } from './megjelenes-idoponton.component';

describe('MegjelenesIdopontonComponent', () => {
  let component: MegjelenesIdopontonComponent;
  let fixture: ComponentFixture<MegjelenesIdopontonComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MegjelenesIdopontonComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MegjelenesIdopontonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
